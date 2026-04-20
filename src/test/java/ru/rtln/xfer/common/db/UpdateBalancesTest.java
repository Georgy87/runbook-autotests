package ru.rtln.xfer.common.db;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.TestReporter;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DisplayName("Сотрудник L2: Установка или обновление баланса участника")
@TestMethodOrder(OrderAnnotation.class)
class UpdateBalancesTest extends DbIntegrationTest {

    @AfterAll
    static void writeRunbookDescriptionReport() throws IOException {
        RunbookDescriptionReporter.writeReports(
            UpdateBalancesTest.class,
            Path.of("target", "runbook-reports", "update_balances_descriptions.md"),
            Path.of("target", "runbook-reports", "update_balances_descriptions.html"),
            "Описания Сценариев Runbook: Обновление балансов",
            "[runbook] Обновление балансов"
        );
    }

    // ---------------------------------------------------------------
    // 1.1 Проверяем, существует ли баланс по участнику в БД
    // ---------------------------------------------------------------

    @DisplayName("1.1 Проверяем, существует ли баланс по участнику в БД")
    @RunbookDescription(
        order = 10,
        id = "RUNBOOK-1.1-SELECT",
        title = "Проверяем, существует ли баланс по участнику в БД",
        given = "Для participant_id и settlement_participant_id может существовать 0, 1 или более записей в t_participant_balance.",
        action = "Выполняется SELECT count(*) AS balance_count из t_participant_balance по participant_id и settlement_participant_id.",
        expected = "0 — нужна первичная инициализация; 1 — нужно обновление; > 1 — несоответствие БД, вручную не продолжать.",
        sql = """
            SELECT count(*) AS balance_count
            FROM t_participant_balance
            WHERE participant_id = :participant_id
              AND settlement_participant_id = :settlement_id;
            """
    )
    @Order(10)
    @ParameterizedTest(name = "{0}")
    @MethodSource("balanceCountScenarios")
    void checksBalanceCountForParticipant(
        RunbookScenario scenario,
        int preparedRowCount,
        long expectedCount,
        long participantId,
        long settlementId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        for (int i = 0; i < preparedRowCount; i++) {
            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_participant_balance " +
                "(id, participant_id, settlement_participant_id, online_balance, minimum_balance, created_at) " +
                "VALUES (nextval('seq_participant_balance'), ?, ?, 0, 0, now())"
            )) {
                ps.setLong(1, participantId);
                ps.setLong(2, settlementId);
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "setup: не удалось вставить строку #" + (i + 1));
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT count(*) AS balance_count " +
            "FROM t_participant_balance " +
            "WHERE participant_id = ? AND settlement_participant_id = ?"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, settlementId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "ResultSet пуст");
                assertEquals(expectedCount, rs.getLong("balance_count"),
                    scenario.failurePrefix() + "Ожидался balance_count = " + expectedCount);
            }
        }
    }

    // ---------------------------------------------------------------
    // 1.2 Проверяем, что между участником и расчетным банком есть contract_flow
    // ---------------------------------------------------------------

    @DisplayName("1.2 Проверяем, что между участником и расчетным банком есть contract_flow")
    @RunbookDescription(
        order = 20,
        id = "RUNBOOK-1.2-SELECT",
        title = "Проверяем, что между участником и расчетным банком есть contract_flow",
        given = "Между participant_id и settlement_participant_id может существовать или отсутствовать contract_flow.",
        action = "Выполняется SELECT из t_contract_flow по settlement_participant_id и (originator_id = :participant_id OR receiver_id = :participant_id).",
        expected = "Если строка найдена — можно продолжать. Если нет — расчётный банк получит ошибку 1006 CONTRACT_NOT_FOUND.",
        sql = """
            SELECT id,
                   originator_id,
                   receiver_id,
                   settlement_participant_id,
                   enabled
            FROM t_contract_flow
            WHERE settlement_participant_id = :settlement_id
              AND (originator_id = :participant_id OR receiver_id = :participant_id);
            """
    )
    @Order(20)
    @ParameterizedTest(name = "{0}")
    @MethodSource("contractFlowScenarios")
    void checksContractFlowExists(
        RunbookScenario scenario,
        boolean contractFlowExists,
        long participantId,
        long settlementId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        if (contractFlowExists) {
            insertParticipant(participantId);
            insertParticipant(settlementId);

            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_contract (id) VALUES (?)"
            )) {
                ps.setLong(1, participantId);
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "setup: не удалось вставить t_contract");
            }

            // contract_id ссылается на t_contract, originator_id и settlement_participant_id — на participant
            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_contract_flow " +
                "(id, contract_id, originator_id, settlement_participant_id, enabled) " +
                "VALUES (nextval('seq_contract_flow_id'), ?, ?, ?, false)"
            )) {
                ps.setLong(1, participantId);   // contract_id
                ps.setLong(2, participantId);   // originator_id
                ps.setLong(3, settlementId);    // settlement_participant_id
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "setup: не удалось вставить t_contract_flow");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT id FROM t_contract_flow " +
            "WHERE settlement_participant_id = ? " +
            "  AND (originator_id = ? OR receiver_id = ?)"
        )) {
            ps.setLong(1, settlementId);
            ps.setLong(2, participantId);
            ps.setLong(3, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertEquals(contractFlowExists, rs.next(), scenario.failurePrefix());
            }
        }
    }

    // ---------------------------------------------------------------
    // 1.3 Первичная инициализация баланса
    // ---------------------------------------------------------------

    @DisplayName("1.3 Первичная инициализация баланса")
    @RunbookDescription(
        order = 30,
        id = "RUNBOOK-1.3-INSERT",
        title = "Первичная инициализация баланса",
        given = "Для participant_id и settlement_participant_id нет записи в t_participant_balance (count = 0).",
        action = "Выполняется INSERT INTO t_participant_balance. Вариант 1 — явные значения; вариант 2 — online_balance берётся из participant.online_balance.",
        expected = "Появляется ровно 1 запись с корректным online_balance, minimum_balance = 0, created_at IS NOT NULL.",
        sql = """
            -- Вариант 1: явные значения
            INSERT INTO t_participant_balance (
                id, participant_id, settlement_participant_id,
                online_balance, minimum_balance, currency,
                participant_balance_history_id, created_at, updated_at
            ) VALUES (
                nextval('seq_participant_balance'),
                :participant_id, :settlement_id,
                :online_balance, :minimum_balance, :currency, NULL, now(), NULL
            );

            -- Вариант 2: стартовый баланс прямо из participant.online_balance
            INSERT INTO t_participant_balance (
                id, participant_id, settlement_participant_id,
                online_balance, minimum_balance, currency,
                participant_balance_history_id, created_at, updated_at
            )
            SELECT nextval('seq_participant_balance'),
                   p.id, :settlement_id,
                   p.online_balance, :minimum_balance, :currency, NULL, now(), NULL
            FROM participant p
            WHERE p.id = :participant_id;
            """
    )
    @Order(30)
    @ParameterizedTest(name = "{0}")
    @MethodSource("initialInsertScenarios")
    void insertsInitialBalance(
        RunbookScenario scenario,
        boolean syncFromParticipant,
        long participantId,
        long settlementId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        BigDecimal expectedOnlineBalance;

        if (syncFromParticipant) {
            expectedOnlineBalance = new BigDecimal("5000.00");

            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO participant (id, online_balance) VALUES (?, ?)"
            )) {
                ps.setLong(1, participantId);
                ps.setBigDecimal(2, expectedOnlineBalance);
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "setup: не удалось вставить participant");
            }

            // Вариант 2 из runbook: INSERT...SELECT из participant
            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_participant_balance " +
                "(id, participant_id, settlement_participant_id, online_balance, minimum_balance, " +
                " participant_balance_history_id, created_at, updated_at) " +
                "SELECT nextval('seq_participant_balance'), p.id, ?, p.online_balance, 0, NULL, now(), NULL " +
                "FROM participant p WHERE p.id = ?"
            )) {
                ps.setLong(1, settlementId);
                ps.setLong(2, participantId);
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "INSERT...SELECT должен вставить 1 строку");
            }
        } else {
            expectedOnlineBalance = new BigDecimal("1000.00");

            // Вариант 1 из runbook: INSERT с явными значениями
            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_participant_balance " +
                "(id, participant_id, settlement_participant_id, online_balance, minimum_balance, " +
                " participant_balance_history_id, created_at, updated_at) " +
                "VALUES (nextval('seq_participant_balance'), ?, ?, ?, 0, NULL, now(), NULL)"
            )) {
                ps.setLong(1, participantId);
                ps.setLong(2, settlementId);
                ps.setBigDecimal(3, expectedOnlineBalance);
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "INSERT должен вставить 1 строку");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT online_balance, minimum_balance, created_at " +
            "FROM t_participant_balance " +
            "WHERE participant_id = ? AND settlement_participant_id = ?"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, settlementId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(),
                    scenario.failurePrefix() + "Ожидается 1 строка в t_participant_balance после INSERT");
                assertEquals(0, expectedOnlineBalance.compareTo(rs.getBigDecimal("online_balance")),
                    scenario.failurePrefix() + "online_balance должен быть " + expectedOnlineBalance);
                assertEquals(0, BigDecimal.ZERO.compareTo(rs.getBigDecimal("minimum_balance")),
                    scenario.failurePrefix() + "minimum_balance должен быть 0");
                assertNotNull(rs.getTimestamp("created_at"),
                    scenario.failurePrefix() + "created_at не должен быть null");
                assertFalse(rs.next(),
                    scenario.failurePrefix() + "Ожидается ровно 1 строка");
            }
        }
    }

    // ---------------------------------------------------------------
    // Данные сценариев
    // ---------------------------------------------------------------

    private static Stream<Arguments> balanceCountScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.1-COUNT-0",
                    "count = 0: запись отсутствует, нужна первичная инициализация",
                    "Для participant_id нет записей в t_participant_balance.",
                    "Выполняется SELECT count(*) AS balance_count.",
                    "balance_count = 0 — нужна первичная инициализация через INSERT.",
                    "SELECT count(*) AS balance_count FROM t_participant_balance " +
                    "WHERE participant_id = :participant_id AND settlement_participant_id = :settlement_id;"
                ),
                0, 0L, -400001L, -400001L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.1-COUNT-1",
                    "count = 1: запись существует, нужно обновление",
                    "Для participant_id есть ровно 1 запись в t_participant_balance.",
                    "Выполняется SELECT count(*) AS balance_count.",
                    "balance_count = 1 — нужно обновление через UPDATE.",
                    "SELECT count(*) AS balance_count FROM t_participant_balance " +
                    "WHERE participant_id = :participant_id AND settlement_participant_id = :settlement_id;"
                ),
                1, 1L, -400002L, -400002L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.1-COUNT-GT1",
                    "count > 1: несоответствие БД, вручную не продолжать",
                    "Для participant_id есть 2 записи в t_participant_balance — несоответствие данных.",
                    "Выполняется SELECT count(*) AS balance_count.",
                    "balance_count = 2 > 1 — консистентность БД нарушена, вручную не продолжать.",
                    "SELECT count(*) AS balance_count FROM t_participant_balance " +
                    "WHERE participant_id = :participant_id AND settlement_participant_id = :settlement_id;"
                ),
                2, 2L, -400003L, -400003L
            )
        );
    }

    private static Stream<Arguments> contractFlowScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.2-CF-NOT-FOUND",
                    "contract_flow не найден — нельзя продолжать, будет CONTRACT_NOT_FOUND",
                    "Между participant_id и settlement_participant_id нет contract_flow в t_contract_flow.",
                    "Выполняется SELECT из t_contract_flow.",
                    "Запрос не возвращает строк — расчётный банк получит ошибку 1006 CONTRACT_NOT_FOUND.",
                    "SELECT id FROM t_contract_flow WHERE settlement_participant_id = :settlement_id " +
                    "AND (originator_id = :participant_id OR receiver_id = :participant_id);"
                ),
                false, -400010L, -400011L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.2-CF-FOUND",
                    "contract_flow найден — можно продолжать",
                    "Между participant_id и settlement_participant_id есть contract_flow в t_contract_flow.",
                    "Выполняется SELECT из t_contract_flow.",
                    "Запрос возвращает строку — ручка participant-balance/v1/update сможет найти поток.",
                    "SELECT id FROM t_contract_flow WHERE settlement_participant_id = :settlement_id " +
                    "AND (originator_id = :participant_id OR receiver_id = :participant_id);"
                ),
                true, -400012L, -400013L
            )
        );
    }

    private static Stream<Arguments> initialInsertScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-INSERT-EXPLICIT",
                    "Первичная инициализация с явными значениями: online_balance = 1000, minimum_balance = 0",
                    "Для participant_id нет записи в t_participant_balance.",
                    "Выполняется INSERT INTO t_participant_balance с явным online_balance = 1000 и minimum_balance = 0.",
                    "Появляется 1 запись с online_balance = 1000, minimum_balance = 0, created_at IS NOT NULL.",
                    """
                    INSERT INTO t_participant_balance (
                        id, participant_id, settlement_participant_id,
                        online_balance, minimum_balance,
                        participant_balance_history_id, created_at, updated_at
                    ) VALUES (
                        nextval('seq_participant_balance'),
                        :participant_id, :settlement_id,
                        :online_balance, 0, NULL, now(), NULL
                    );"""
                ),
                false, -400020L, -400020L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-INSERT-SYNC-PARTICIPANT",
                    "Первичная инициализация: online_balance берётся из participant.online_balance",
                    "Для participant_id нет записи в t_participant_balance; participant.online_balance = 5000.",
                    "Выполняется INSERT...SELECT из participant WHERE p.id = :participant_id.",
                    "Появляется 1 запись с online_balance = 5000 (совпадает с participant), minimum_balance = 0, created_at IS NOT NULL.",
                    """
                    INSERT INTO t_participant_balance (
                        id, participant_id, settlement_participant_id,
                        online_balance, minimum_balance,
                        participant_balance_history_id, created_at, updated_at
                    )
                    SELECT nextval('seq_participant_balance'),
                           p.id, :settlement_id,
                           p.online_balance, 0, NULL, now(), NULL
                    FROM participant p WHERE p.id = :participant_id;"""
                ),
                true, -400021L, -400021L
            )
        );
    }

    // ---------------------------------------------------------------
    // 1.4 Обновление существующего баланса через CTE
    // ---------------------------------------------------------------

    @DisplayName("1.4 Обновление существующего баланса через CTE (REPLENISHMENT / WRITE_OFF / без изменений)")
    @RunbookDescription(
        order = 40,
        id = "RUNBOOK-1.4-CTE-UPDATE",
        title = "Обновление существующего баланса через CTE",
        given = "Для participant_id есть ровно 1 запись в t_participant_balance (count = 1). participant.online_balance содержит новый целевой баланс.",
        action = """
            Выполняется CTE-запрос: src вычитывает старый и новый баланс, delta определяет тип операции \
            (REPLENISHMENT / WRITE_OFF), hst вставляет запись в историю, \
            UPDATE обновляет online_balance и participant_balance_history_id.""",
        expected = "Если new_balance <> old_balance — t_participant_balance.online_balance обновлён, создана запись в истории. " +
                   "Если new_balance = old_balance — строка в БД не изменяется, история не создаётся.",
        sql = """
            WITH src AS (
                SELECT pb.id AS balance_id, pb.online_balance AS old_balance,
                       p.online_balance AS new_balance, pb.currency
                FROM t_participant_balance pb
                JOIN participant p ON p.id = pb.participant_id
                WHERE pb.participant_id = :participant_id
                  AND pb.settlement_participant_id = :settlement_id
                FOR UPDATE
            ),
            delta AS (
                SELECT balance_id, old_balance, new_balance, currency,
                       abs(new_balance - old_balance) AS amount,
                       CASE WHEN new_balance > old_balance THEN 'REPLENISHMENT'
                            WHEN new_balance < old_balance THEN 'WRITE_OFF' END AS operation_type
                FROM src WHERE new_balance <> old_balance
            ),
            hst AS (
                INSERT INTO t_participant_balance_history (
                    id, participant_id, operation_type, transfer_id, amount, currency,
                    settlement_participant_id, time, comment, created_at
                )
                SELECT nextval('seq_participant_balance_history'), :participant_id, operation_type,
                       NULL, amount, currency, :settlement_id, now(), 'Manual balance sync by L2', now()
                FROM delta RETURNING id
            )
            UPDATE t_participant_balance pb
            SET online_balance = (SELECT new_balance FROM delta),
                participant_balance_history_id = (SELECT id FROM hst),
                updated_at = now()
            WHERE pb.id = (SELECT balance_id FROM delta);
            """
    )
    @Order(40)
    @ParameterizedTest(name = "{0}")
    @MethodSource("cteUpdateScenarios")
    void updatesExistingBalanceWithCte(
        RunbookScenario scenario,
        BigDecimal oldBalance,
        BigDecimal newBalance,
        String expectedOperationType,
        long participantId,
        long settlementId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        insertParticipantWithBalance(participantId, newBalance);
        insertBalance(participantId, settlementId, oldBalance);

        try (PreparedStatement ps = connection.prepareStatement(
            "WITH src AS (" +
            "  SELECT pb.id AS balance_id, pb.online_balance AS old_balance," +
            "         p.online_balance AS new_balance, pb.currency" +
            "  FROM t_participant_balance pb" +
            "  JOIN participant p ON p.id = pb.participant_id" +
            "  WHERE pb.participant_id = ? AND pb.settlement_participant_id = ?" +
            "  FOR UPDATE" +
            "), delta AS (" +
            "  SELECT balance_id, old_balance, new_balance, currency," +
            "         abs(new_balance - old_balance) AS amount," +
            "         CASE WHEN new_balance > old_balance THEN 'REPLENISHMENT'" +
            "              WHEN new_balance < old_balance THEN 'WRITE_OFF' END AS operation_type" +
            "  FROM src WHERE new_balance <> old_balance" +
            "), hst AS (" +
            "  INSERT INTO t_participant_balance_history" +
            "    (id, participant_id, operation_type, transfer_id, amount, currency," +
            "     settlement_participant_id, time, comment, created_at)" +
            "  SELECT nextval('seq_participant_balance_history'), ?, operation_type," +
            "         NULL, amount, currency, ?, now(), 'Manual balance sync by L2', now()" +
            "  FROM delta RETURNING id" +
            ")" +
            "UPDATE t_participant_balance pb" +
            "  SET online_balance = (SELECT new_balance FROM delta)," +
            "      participant_balance_history_id = (SELECT id FROM hst)," +
            "      updated_at = now()" +
            "  WHERE pb.id = (SELECT balance_id FROM delta)"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, settlementId);
            ps.setLong(3, participantId);
            ps.setLong(4, settlementId);
            ps.executeUpdate();
        }

        boolean expectChange = oldBalance.compareTo(newBalance) != 0;

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT online_balance, participant_balance_history_id, updated_at " +
            "FROM t_participant_balance WHERE participant_id = ? AND settlement_participant_id = ?"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, settlementId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "Ожидается строка в t_participant_balance");
                BigDecimal expectedBalance = expectChange ? newBalance : oldBalance;
                assertEquals(0, expectedBalance.compareTo(rs.getBigDecimal("online_balance")),
                    scenario.failurePrefix() + "online_balance должен быть " + expectedBalance);
                if (expectChange) {
                    assertNotNull(rs.getObject("participant_balance_history_id"),
                        scenario.failurePrefix() + "participant_balance_history_id должен быть установлен");
                    assertNotNull(rs.getTimestamp("updated_at"),
                        scenario.failurePrefix() + "updated_at должен быть установлен");
                } else {
                    assertNull(rs.getObject("participant_balance_history_id"),
                        scenario.failurePrefix() + "participant_balance_history_id должен оставаться NULL при отсутствии изменений");
                }
            }
        }

        if (expectChange) {
            try (PreparedStatement ps = connection.prepareStatement(
                "SELECT operation_type, amount FROM t_participant_balance_history " +
                "WHERE participant_id = ? AND settlement_participant_id = ?"
            )) {
                ps.setLong(1, participantId);
                ps.setLong(2, settlementId);
                try (ResultSet rs = ps.executeQuery()) {
                    assertTrue(rs.next(), scenario.failurePrefix() + "Ожидается запись в истории баланса");
                    assertEquals(expectedOperationType, rs.getString("operation_type"),
                        scenario.failurePrefix() + "operation_type должен быть " + expectedOperationType);
                    BigDecimal expectedAmount = newBalance.subtract(oldBalance).abs();
                    assertEquals(0, expectedAmount.compareTo(rs.getBigDecimal("amount")),
                        scenario.failurePrefix() + "amount должен быть " + expectedAmount);
                }
            }
        } else {
            try (PreparedStatement ps = connection.prepareStatement(
                "SELECT count(*) FROM t_participant_balance_history " +
                "WHERE participant_id = ? AND settlement_participant_id = ?"
            )) {
                ps.setLong(1, participantId);
                ps.setLong(2, settlementId);
                try (ResultSet rs = ps.executeQuery()) {
                    assertTrue(rs.next());
                    assertEquals(0, rs.getLong(1),
                        scenario.failurePrefix() + "История не должна создаваться при отсутствии изменений баланса");
                }
            }
        }
    }

    // ---------------------------------------------------------------
    // 1.4 FOR UPDATE: блокировка конкурентного доступа
    // ---------------------------------------------------------------

    @DisplayName("1.4 FOR UPDATE блокирует конкурентный доступ к строке баланса")
    @RunbookDescription(
        order = 45,
        id = "RUNBOOK-1.4-FOR-UPDATE-CONCURRENCY",
        title = "FOR UPDATE блокирует конкурентный доступ к строке баланса",
        given = "Существует запись в t_participant_balance. Первая транзакция выполнила src CTE с FOR UPDATE и удерживает строчную блокировку.",
        action = "Вторая параллельная транзакция пытается выполнить тот же SELECT ... FOR UPDATE NOWAIT на ту же строку.",
        expected = "Пока первая транзакция удерживает блокировку — вторая немедленно получает исключение (SQLState 55P03: lock_not_available). " +
                   "После снятия блокировки первой транзакцией — вторая успешно захватывает строку.",
        sql = """
            -- Транзакция 1 (holder): захватывает блокировку
            SELECT pb.id FROM t_participant_balance pb
            JOIN participant p ON p.id = pb.participant_id
            WHERE pb.participant_id = :participant_id
              AND pb.settlement_participant_id = :settlement_id
            FOR UPDATE;

            -- Транзакция 2 (contender): пытается захватить ту же строку — получит ошибку
            SELECT pb.id FROM t_participant_balance pb
            JOIN participant p ON p.id = pb.participant_id
            WHERE pb.participant_id = :participant_id
              AND pb.settlement_participant_id = :settlement_id
            FOR UPDATE NOWAIT;
            """
    )
    @Order(45)
    @Test
    void forUpdateBlocksConcurrentAccess() throws Exception {
        final long participantId = -400038L;
        final long settlementId = -400038L;

        // Шаг 1: вставить тестовые данные и ЗАКОММИТИТЬ — чтобы были видны другим соединениям
        try (Connection setup = openConnection()) {
            setup.setAutoCommit(false);
            try (PreparedStatement ps = setup.prepareStatement(
                "INSERT INTO participant (id, online_balance) VALUES (?, ?)"
            )) {
                ps.setLong(1, participantId);
                ps.setBigDecimal(2, new BigDecimal("100.00"));
                ps.executeUpdate();
            }
            try (PreparedStatement ps = setup.prepareStatement(
                "INSERT INTO t_participant_balance " +
                "(id, participant_id, settlement_participant_id, online_balance, minimum_balance, created_at) " +
                "VALUES (nextval('seq_participant_balance'), ?, ?, ?, 0, now())"
            )) {
                ps.setLong(1, participantId);
                ps.setLong(2, settlementId);
                ps.setBigDecimal(3, new BigDecimal("100.00"));
                ps.executeUpdate();
            }
            setup.commit();
        }

        try {
            // Шаг 2: первое соединение захватывает FOR UPDATE — удерживает блокировку
            try (Connection holder = openConnection()) {
                holder.setAutoCommit(false);
                try (PreparedStatement ps = holder.prepareStatement(
                    "SELECT pb.id FROM t_participant_balance pb " +
                    "JOIN participant p ON p.id = pb.participant_id " +
                    "WHERE pb.participant_id = ? AND pb.settlement_participant_id = ? " +
                    "FOR UPDATE"
                )) {
                    ps.setLong(1, participantId);
                    ps.setLong(2, settlementId);
                    try (ResultSet rs = ps.executeQuery()) {
                        assertTrue(rs.next(), "Строка баланса должна существовать");
                    }
                }
                // Шаг 3: второе соединение пытается захватить ту же строку с NOWAIT
                try (Connection contender = openConnection()) {
                    contender.setAutoCommit(false);
                    try (PreparedStatement ps = contender.prepareStatement(
                        "SELECT pb.id FROM t_participant_balance pb " +
                        "JOIN participant p ON p.id = pb.participant_id " +
                        "WHERE pb.participant_id = ? AND pb.settlement_participant_id = ? " +
                        "FOR UPDATE NOWAIT"
                    )) {
                        ps.setLong(1, participantId);
                        ps.setLong(2, settlementId);

                        // Ожидаем исключение: строка заблокирована первой транзакцией
                        SQLException lockException = assertThrows(
                            SQLException.class, ps::executeQuery,
                            "FOR UPDATE NOWAIT должен выбросить исключение — строка заблокирована holder-ом"
                        );
                        assertEquals("55P03", lockException.getSQLState(),
                            "SQLState должен быть 55P03 (lock_not_available)");
                    }
                    contender.rollback();

                    // Шаг 4: первая транзакция освобождает блокировку
                    holder.rollback();

                    // Шаг 5: после снятия блокировки contender успешно захватывает строку
                    contender.setAutoCommit(false);
                    try (PreparedStatement ps = contender.prepareStatement(
                        "SELECT pb.id FROM t_participant_balance pb " +
                        "JOIN participant p ON p.id = pb.participant_id " +
                        "WHERE pb.participant_id = ? AND pb.settlement_participant_id = ? " +
                        "FOR UPDATE NOWAIT"
                    )) {
                        ps.setLong(1, participantId);
                        ps.setLong(2, settlementId);
                        try (ResultSet rs = ps.executeQuery()) {
                            assertTrue(rs.next(),
                                "После снятия блокировки FOR UPDATE NOWAIT должен успешно захватить строку");
                        }
                    }
                    contender.rollback();
                }
            }
        } finally {
            // Шаг 6: очистка тестовых данных с коммитом
            try (Connection cleanup = openConnection()) {
                cleanup.setAutoCommit(false);
                try (PreparedStatement ps = cleanup.prepareStatement(
                    "DELETE FROM t_participant_balance WHERE participant_id = ? AND settlement_participant_id = ?"
                )) {
                    ps.setLong(1, participantId);
                    ps.setLong(2, settlementId);
                    ps.executeUpdate();
                }
                try (PreparedStatement ps = cleanup.prepareStatement(
                    "DELETE FROM participant WHERE id = ?"
                )) {
                    ps.setLong(1, participantId);
                    ps.executeUpdate();
                }
                cleanup.commit();
            }
        }
    }

    // ---------------------------------------------------------------
    // 1.4 Обновление только minimum_balance
    // ---------------------------------------------------------------

    @DisplayName("1.4 Обновление только minimum_balance (без записи в историю)")
    @RunbookDescription(
        order = 50,
        id = "RUNBOOK-1.4-MINIMUM-BALANCE",
        title = "Обновление только minimum_balance",
        given = "Для participant_id есть запись в t_participant_balance с minimum_balance = 0.",
        action = "Выполняется UPDATE t_participant_balance SET minimum_balance = :new_minimum WHERE participant_id = :participant_id AND settlement_participant_id = :settlement_id.",
        expected = "minimum_balance обновлён до нового значения. online_balance и participant_balance_history_id не изменяются. Запись в истории не создаётся.",
        sql = """
            UPDATE t_participant_balance
            SET minimum_balance = :minimum_balance,
                updated_at = now()
            WHERE participant_id = :participant_id
              AND settlement_participant_id = :settlement_id;
            """
    )
    @Order(50)
    @ParameterizedTest(name = "{0}")
    @MethodSource("minimumBalanceUpdateScenarios")
    void updatesMinimumBalance(
        RunbookScenario scenario,
        BigDecimal initialOnlineBalance,
        BigDecimal newMinimumBalance,
        long participantId,
        long settlementId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        insertBalance(participantId, settlementId, initialOnlineBalance);

        try (PreparedStatement ps = connection.prepareStatement(
            "UPDATE t_participant_balance " +
            "SET minimum_balance = ?, updated_at = now() " +
            "WHERE participant_id = ? AND settlement_participant_id = ?"
        )) {
            ps.setBigDecimal(1, newMinimumBalance);
            ps.setLong(2, participantId);
            ps.setLong(3, settlementId);
            assertEquals(1, ps.executeUpdate(),
                scenario.failurePrefix() + "Должна обновиться ровно 1 строка");
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT online_balance, minimum_balance, participant_balance_history_id " +
            "FROM t_participant_balance WHERE participant_id = ? AND settlement_participant_id = ?"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, settlementId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "Ожидается строка в t_participant_balance");
                assertEquals(0, initialOnlineBalance.compareTo(rs.getBigDecimal("online_balance")),
                    scenario.failurePrefix() + "online_balance не должен измениться");
                assertEquals(0, newMinimumBalance.compareTo(rs.getBigDecimal("minimum_balance")),
                    scenario.failurePrefix() + "minimum_balance должен быть " + newMinimumBalance);
                assertNull(rs.getObject("participant_balance_history_id"),
                    scenario.failurePrefix() + "participant_balance_history_id должен оставаться NULL");
            }
        }
    }

    // ---------------------------------------------------------------
    // 1.10 Контрольная проверка балансов после операции
    // ---------------------------------------------------------------

    @DisplayName("1.10 Контрольная проверка балансов после операции")
    @RunbookDescription(
        order = 100,
        id = "RUNBOOK-1.10-SELECT",
        title = "Контрольная проверка балансов после операции",
        given = "Операция INSERT (первичная инициализация) или UPDATE (обновление) уже выполнена.",
        action = "Выполняется SELECT из t_participant_balance по participant_id и settlement_participant_id.",
        expected = "Возвращается 1 строка с корректными значениями online_balance, minimum_balance, created_at IS NOT NULL. " +
                   "После UPDATE: updated_at IS NOT NULL, participant_balance_history_id IS NOT NULL.",
        sql = """
            SELECT id, participant_id, settlement_participant_id,
                   online_balance, minimum_balance, currency,
                   participant_balance_history_id, created_at, updated_at
            FROM t_participant_balance
            WHERE participant_id = :participant_id
              AND settlement_participant_id = :settlement_id;
            """
    )
    @Order(100)
    @ParameterizedTest(name = "{0}")
    @MethodSource("controlVerificationScenarios")
    void verifiesBalanceRecordAfterOperation(
        RunbookScenario scenario,
        boolean afterUpdate,
        BigDecimal expectedOnlineBalance,
        long participantId,
        long settlementId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        if (afterUpdate) {
            // Сценарий после UPDATE: подготовка — вставляем участника и баланс, затем обновляем через CTE
            insertParticipantWithBalance(participantId, expectedOnlineBalance);
            insertBalance(participantId, settlementId, new BigDecimal("50.00"));

            try (PreparedStatement ps = connection.prepareStatement(
                "WITH src AS (" +
                "  SELECT pb.id AS balance_id, p.online_balance AS new_balance, pb.currency" +
                "  FROM t_participant_balance pb" +
                "  JOIN participant p ON p.id = pb.participant_id" +
                "  WHERE pb.participant_id = ? AND pb.settlement_participant_id = ?" +
                "  FOR UPDATE" +
                "), delta AS (" +
                "  SELECT balance_id, new_balance, currency," +
                "         abs(new_balance - 50) AS amount, 'REPLENISHMENT' AS operation_type" +
                "  FROM src WHERE new_balance <> 50" +
                "), hst AS (" +
                "  INSERT INTO t_participant_balance_history" +
                "    (id, participant_id, operation_type, transfer_id, amount, currency," +
                "     settlement_participant_id, time, comment, created_at)" +
                "  SELECT nextval('seq_participant_balance_history'), ?, operation_type," +
                "         NULL, amount, currency, ?, now(), 'Manual balance sync by L2', now()" +
                "  FROM delta RETURNING id" +
                ")" +
                "UPDATE t_participant_balance pb" +
                "  SET online_balance = (SELECT new_balance FROM delta)," +
                "      participant_balance_history_id = (SELECT id FROM hst)," +
                "      updated_at = now()" +
                "  WHERE pb.id = (SELECT balance_id FROM delta)"
            )) {
                ps.setLong(1, participantId);
                ps.setLong(2, settlementId);
                ps.setLong(3, participantId);
                ps.setLong(4, settlementId);
                ps.executeUpdate();
            }
        } else {
            // Сценарий после INSERT: первичная инициализация
            insertBalance(participantId, settlementId, expectedOnlineBalance);
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT online_balance, minimum_balance, created_at, updated_at, participant_balance_history_id " +
            "FROM t_participant_balance WHERE participant_id = ? AND settlement_participant_id = ?"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, settlementId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(),
                    scenario.failurePrefix() + "Контрольная проверка: ожидается 1 строка в t_participant_balance");
                assertEquals(0, expectedOnlineBalance.compareTo(rs.getBigDecimal("online_balance")),
                    scenario.failurePrefix() + "online_balance должен быть " + expectedOnlineBalance);
                assertNotNull(rs.getTimestamp("created_at"),
                    scenario.failurePrefix() + "created_at не должен быть null");
                if (afterUpdate) {
                    assertNotNull(rs.getTimestamp("updated_at"),
                        scenario.failurePrefix() + "updated_at должен быть установлен после UPDATE");
                    assertNotNull(rs.getObject("participant_balance_history_id"),
                        scenario.failurePrefix() + "participant_balance_history_id должен быть установлен после UPDATE");
                }
                assertFalse(rs.next(),
                    scenario.failurePrefix() + "Ожидается ровно 1 строка");
            }
        }
    }

    // ---------------------------------------------------------------
    // 2.1 Проверяем состояние feature_validate_participant_balance
    // ---------------------------------------------------------------

    @DisplayName("2.1 Проверяем состояние feature_validate_participant_balance")
    @RunbookDescription(
        order = 210,
        id = "RUNBOOK-2.1-SELECT",
        title = "Проверяем состояние feature_validate_participant_balance",
        given = "В t_participant_property может существовать или отсутствовать запись с participant_id = 0 и prop_name = 'feature_validate_participant_balance'.",
        action = "Выполняется SELECT prop_name, enabled FROM t_participant_property WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance'.",
        expected = "0 строк — фича не настроена. 1 строка с enabled = false — отключена. 1 строка с enabled = true — включена.",
        sql = """
            SELECT prop_name, enabled
            FROM t_participant_property
            WHERE participant_id = 0
              AND prop_name = 'feature_validate_participant_balance';
            """
    )
    @Order(210)
    @ParameterizedTest(name = "{0}")
    @MethodSource("validateBalanceFeatureStateScenarios")
    void checksValidateBalanceFeatureState(
        RunbookScenario scenario,
        Boolean expectedEnabled,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        deleteProperty(0L, "feature_validate_participant_balance");
        if (expectedEnabled != null) {
            insertProperty(0L, "feature_validate_participant_balance", expectedEnabled);
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT prop_name, enabled FROM t_participant_property " +
            "WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance'"
        )) {
            try (ResultSet rs = ps.executeQuery()) {
                if (expectedEnabled == null) {
                    assertFalse(rs.next(),
                        scenario.failurePrefix() + "Ожидается 0 строк — фича не настроена");
                } else {
                    assertTrue(rs.next(),
                        scenario.failurePrefix() + "Ожидается 1 строка");
                    assertEquals(expectedEnabled, rs.getBoolean("enabled"),
                        scenario.failurePrefix() + "enabled должен быть " + expectedEnabled);
                    assertFalse(rs.next(),
                        scenario.failurePrefix() + "Ожидается ровно 1 строка");
                }
            }
        }
    }

    // ---------------------------------------------------------------
    // 2.2 Включаем feature_validate_participant_balance
    // ---------------------------------------------------------------

    @DisplayName("2.2 Включаем feature_validate_participant_balance (INSERT или UPDATE)")
    @RunbookDescription(
        order = 220,
        id = "RUNBOOK-2.2-UPSERT",
        title = "Включаем feature_validate_participant_balance (INSERT или UPDATE)",
        given = "Запись с participant_id = 0 и prop_name = 'feature_validate_participant_balance' отсутствует или существует с enabled = false.",
        action = "Если записи нет — выполняется INSERT в t_participant_property с enabled = true. Если запись существует — выполняется UPDATE SET enabled = true.",
        expected = "В t_participant_property существует ровно 1 запись с participant_id = 0, prop_name = 'feature_validate_participant_balance', enabled = true.",
        sql = """
            -- Вариант 1: вставить новую запись (если отсутствует)
            INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
            VALUES (0, 'feature_validate_participant_balance', '', true);

            -- Вариант 2: обновить существующую запись
            UPDATE t_participant_property
            SET enabled = true
            WHERE participant_id = 0
              AND prop_name = 'feature_validate_participant_balance';
            """
    )
    @Order(220)
    @ParameterizedTest(name = "{0}")
    @MethodSource("enableValidateBalanceFeatureScenarios")
    void enablesValidateBalanceFeature(
        RunbookScenario scenario,
        boolean rowExistsBeforehand,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        deleteProperty(0L, "feature_validate_participant_balance");
        if (rowExistsBeforehand) {
            insertProperty(0L, "feature_validate_participant_balance", false);
            try (PreparedStatement ps = connection.prepareStatement(
                "UPDATE t_participant_property SET enabled = true " +
                "WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance'"
            )) {
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "UPDATE должен обновить ровно 1 строку");
            }
        } else {
            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
                "VALUES (0, 'feature_validate_participant_balance', '', true)"
            )) {
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "INSERT должен вставить ровно 1 строку");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT enabled FROM t_participant_property " +
            "WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance'"
        )) {
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "Ожидается 1 строка");
                assertTrue(rs.getBoolean("enabled"),
                    scenario.failurePrefix() + "enabled должен быть true");
                assertFalse(rs.next(), scenario.failurePrefix() + "Ожидается ровно 1 строка");
            }
        }
    }

    // ---------------------------------------------------------------
    // 3.1 Проверяем состояние feature_enable_originator_response_field_send_online_balance
    // ---------------------------------------------------------------

    @DisplayName("3.1 Проверяем состояние feature_enable_originator_response_field_send_online_balance")
    @RunbookDescription(
        order = 310,
        id = "RUNBOOK-3.1-SELECT",
        title = "Проверяем состояние feature_enable_originator_response_field_send_online_balance",
        given = "В t_participant_property может существовать или отсутствовать запись с participant_id = 0 и prop_name = 'feature_enable_originator_response_field_send_online_balance'.",
        action = "Выполняется SELECT prop_name, enabled FROM t_participant_property WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance'.",
        expected = "0 строк — фича не настроена. 1 строка с enabled = false — отключена. 1 строка с enabled = true — включена.",
        sql = """
            SELECT prop_name, enabled
            FROM t_participant_property
            WHERE participant_id = 0
              AND prop_name = 'feature_enable_originator_response_field_send_online_balance';
            """
    )
    @Order(310)
    @ParameterizedTest(name = "{0}")
    @MethodSource("sendOnlineBalanceFeatureStateScenarios")
    void checksSendOnlineBalanceFeatureState(
        RunbookScenario scenario,
        Boolean expectedEnabled,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        deleteProperty(0L, "feature_enable_originator_response_field_send_online_balance");
        if (expectedEnabled != null) {
            insertProperty(0L, "feature_enable_originator_response_field_send_online_balance", expectedEnabled);
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT prop_name, enabled FROM t_participant_property " +
            "WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance'"
        )) {
            try (ResultSet rs = ps.executeQuery()) {
                if (expectedEnabled == null) {
                    assertFalse(rs.next(),
                        scenario.failurePrefix() + "Ожидается 0 строк — фича не настроена");
                } else {
                    assertTrue(rs.next(),
                        scenario.failurePrefix() + "Ожидается 1 строка");
                    assertEquals(expectedEnabled, rs.getBoolean("enabled"),
                        scenario.failurePrefix() + "enabled должен быть " + expectedEnabled);
                    assertFalse(rs.next(),
                        scenario.failurePrefix() + "Ожидается ровно 1 строка");
                }
            }
        }
    }

    // ---------------------------------------------------------------
    // 3.2 Включаем feature_enable_originator_response_field_send_online_balance
    // ---------------------------------------------------------------

    @DisplayName("3.2 Включаем feature_enable_originator_response_field_send_online_balance (INSERT или UPDATE)")
    @RunbookDescription(
        order = 320,
        id = "RUNBOOK-3.2-UPSERT",
        title = "Включаем feature_enable_originator_response_field_send_online_balance (INSERT или UPDATE)",
        given = "Запись с participant_id = 0 и prop_name = 'feature_enable_originator_response_field_send_online_balance' отсутствует или существует с enabled = false.",
        action = "Если записи нет — выполняется INSERT в t_participant_property с enabled = true. Если запись существует — выполняется UPDATE SET enabled = true.",
        expected = "В t_participant_property существует ровно 1 запись с participant_id = 0, prop_name = 'feature_enable_originator_response_field_send_online_balance', enabled = true.",
        sql = """
            -- Вариант 1: вставить новую запись (если отсутствует)
            INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
            VALUES (0, 'feature_enable_originator_response_field_send_online_balance', '', true);

            -- Вариант 2: обновить существующую запись
            UPDATE t_participant_property
            SET enabled = true
            WHERE participant_id = 0
              AND prop_name = 'feature_enable_originator_response_field_send_online_balance';
            """
    )
    @Order(320)
    @ParameterizedTest(name = "{0}")
    @MethodSource("enableSendOnlineBalanceFeatureScenarios")
    void enablesSendOnlineBalanceFeature(
        RunbookScenario scenario,
        boolean rowExistsBeforehand,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        deleteProperty(0L, "feature_enable_originator_response_field_send_online_balance");
        if (rowExistsBeforehand) {
            insertProperty(0L, "feature_enable_originator_response_field_send_online_balance", false);
            try (PreparedStatement ps = connection.prepareStatement(
                "UPDATE t_participant_property SET enabled = true " +
                "WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance'"
            )) {
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "UPDATE должен обновить ровно 1 строку");
            }
        } else {
            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
                "VALUES (0, 'feature_enable_originator_response_field_send_online_balance', '', true)"
            )) {
                assertEquals(1, ps.executeUpdate(),
                    scenario.failurePrefix() + "INSERT должен вставить ровно 1 строку");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT enabled FROM t_participant_property " +
            "WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance'"
        )) {
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "Ожидается 1 строка");
                assertTrue(rs.getBoolean("enabled"),
                    scenario.failurePrefix() + "enabled должен быть true");
                assertFalse(rs.next(), scenario.failurePrefix() + "Ожидается ровно 1 строка");
            }
        }
    }

    // ---------------------------------------------------------------
    // Данные сценариев
    // ---------------------------------------------------------------

    private static Stream<Arguments> cteUpdateScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.4-REPLENISHMENT",
                    "CTE update: REPLENISHMENT — новый баланс больше старого (100 → 150)",
                    "participant.online_balance = 150, t_participant_balance.online_balance = 100.",
                    "Выполняется CTE-запрос обновления баланса.",
                    "online_balance обновлён до 150, operation_type = REPLENISHMENT, amount = 50, создана запись в истории.",
                    "WITH src AS (...) ... UPDATE t_participant_balance ..."
                ),
                new BigDecimal("100.00"), new BigDecimal("150.00"), "REPLENISHMENT", -400030L, -400030L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.4-WRITE_OFF",
                    "CTE update: WRITE_OFF — новый баланс меньше старого (150 → 90)",
                    "participant.online_balance = 90, t_participant_balance.online_balance = 150.",
                    "Выполняется CTE-запрос обновления баланса.",
                    "online_balance обновлён до 90, operation_type = WRITE_OFF, amount = 60, создана запись в истории.",
                    "WITH src AS (...) ... UPDATE t_participant_balance ..."
                ),
                new BigDecimal("150.00"), new BigDecimal("90.00"), "WRITE_OFF", -400032L, -400032L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.4-NO-CHANGE",
                    "CTE update: без изменений — новый баланс равен старому (150 = 150)",
                    "participant.online_balance = 150, t_participant_balance.online_balance = 150.",
                    "Выполняется CTE-запрос обновления баланса.",
                    "delta пуста, UPDATE не затрагивает строк, история не создаётся, balance остаётся 150.",
                    "WITH src AS (...) ... UPDATE t_participant_balance ..."
                ),
                new BigDecimal("150.00"), new BigDecimal("150.00"), null, -400034L, -400034L
            )
        );
    }

    private static Stream<Arguments> minimumBalanceUpdateScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.4-MINIMUM-BALANCE",
                    "Обновление только minimum_balance: 0 → 100, online_balance и история не меняются",
                    "Для participant_id есть запись в t_participant_balance с online_balance = 200, minimum_balance = 0.",
                    "Выполняется UPDATE t_participant_balance SET minimum_balance = 100.",
                    "minimum_balance = 100, online_balance = 200 без изменений, participant_balance_history_id = NULL.",
                    "UPDATE t_participant_balance SET minimum_balance = :minimum_balance, updated_at = now() " +
                    "WHERE participant_id = :participant_id AND settlement_participant_id = :settlement_id;"
                ),
                new BigDecimal("200.00"), new BigDecimal("100.00"), -400036L, -400036L
            )
        );
    }

    private static Stream<Arguments> controlVerificationScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.10-AFTER-INSERT",
                    "Контрольная проверка после первичного INSERT: строка существует с корректными значениями",
                    "Выполнена первичная инициализация баланса через INSERT.",
                    "Выполняется контрольный SELECT из t_participant_balance.",
                    "Ровно 1 строка: online_balance = 300, created_at IS NOT NULL.",
                    "SELECT id, participant_id, settlement_participant_id, online_balance, minimum_balance, " +
                    "currency, participant_balance_history_id, created_at, updated_at " +
                    "FROM t_participant_balance WHERE participant_id = :participant_id AND settlement_participant_id = :settlement_id;"
                ),
                false, new BigDecimal("300.00"), -400040L, -400040L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.10-AFTER-UPDATE",
                    "Контрольная проверка после CTE UPDATE: обновлённый баланс и запись в истории",
                    "Выполнено обновление баланса через CTE (REPLENISHMENT: 50 → целевой баланс).",
                    "Выполняется контрольный SELECT из t_participant_balance.",
                    "Ровно 1 строка: online_balance обновлён, updated_at IS NOT NULL, participant_balance_history_id IS NOT NULL.",
                    "SELECT id, participant_id, settlement_participant_id, online_balance, minimum_balance, " +
                    "currency, participant_balance_history_id, created_at, updated_at " +
                    "FROM t_participant_balance WHERE participant_id = :participant_id AND settlement_participant_id = :settlement_id;"
                ),
                true, new BigDecimal("400.00"), -400041L, -400041L
            )
        );
    }

    private static Stream<Arguments> validateBalanceFeatureStateScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-2.1-ABSENT",
                    "feature_validate_participant_balance: запись отсутствует",
                    "В t_participant_property нет записи с participant_id = 0 и prop_name = 'feature_validate_participant_balance'.",
                    "Выполняется SELECT по participant_id = 0 и prop_name = 'feature_validate_participant_balance'.",
                    "0 строк — фича не настроена.",
                    "SELECT prop_name, enabled FROM t_participant_property " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance';"
                ),
                (Boolean) null
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-2.1-DISABLED",
                    "feature_validate_participant_balance: запись есть, enabled = false (отключена)",
                    "В t_participant_property есть запись с participant_id = 0, prop_name = 'feature_validate_participant_balance', enabled = false.",
                    "Выполняется SELECT по participant_id = 0 и prop_name = 'feature_validate_participant_balance'.",
                    "1 строка с enabled = false — фича отключена.",
                    "SELECT prop_name, enabled FROM t_participant_property " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance';"
                ),
                false
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-2.1-ENABLED",
                    "feature_validate_participant_balance: запись есть, enabled = true (включена)",
                    "В t_participant_property есть запись с participant_id = 0, prop_name = 'feature_validate_participant_balance', enabled = true.",
                    "Выполняется SELECT по participant_id = 0 и prop_name = 'feature_validate_participant_balance'.",
                    "1 строка с enabled = true — фича включена.",
                    "SELECT prop_name, enabled FROM t_participant_property " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance';"
                ),
                true
            )
        );
    }

    private static Stream<Arguments> enableValidateBalanceFeatureScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-2.2-INSERT",
                    "Включение feature_validate_participant_balance: запись отсутствует — выполняется INSERT",
                    "В t_participant_property нет записи с participant_id = 0 и prop_name = 'feature_validate_participant_balance'.",
                    "Выполняется INSERT INTO t_participant_property с enabled = true.",
                    "Появляется 1 запись с enabled = true.",
                    "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
                    "VALUES (0, 'feature_validate_participant_balance', '', true);"
                ),
                false
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-2.2-UPDATE",
                    "Включение feature_validate_participant_balance: запись есть с enabled = false — выполняется UPDATE",
                    "В t_participant_property есть запись с participant_id = 0, prop_name = 'feature_validate_participant_balance', enabled = false.",
                    "Выполняется UPDATE t_participant_property SET enabled = true.",
                    "Запись обновлена: enabled = true.",
                    "UPDATE t_participant_property SET enabled = true " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_validate_participant_balance';"
                ),
                true
            )
        );
    }

    private static Stream<Arguments> sendOnlineBalanceFeatureStateScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-3.1-ABSENT",
                    "feature_enable_originator_response_field_send_online_balance: запись отсутствует",
                    "В t_participant_property нет записи с participant_id = 0 и prop_name = 'feature_enable_originator_response_field_send_online_balance'.",
                    "Выполняется SELECT по participant_id = 0 и prop_name = 'feature_enable_originator_response_field_send_online_balance'.",
                    "0 строк — фича не настроена.",
                    "SELECT prop_name, enabled FROM t_participant_property " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance';"
                ),
                (Boolean) null
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-3.1-DISABLED",
                    "feature_enable_originator_response_field_send_online_balance: enabled = false (отключена)",
                    "В t_participant_property есть запись с participant_id = 0, prop_name = 'feature_enable_originator_response_field_send_online_balance', enabled = false.",
                    "Выполняется SELECT по participant_id = 0 и prop_name = 'feature_enable_originator_response_field_send_online_balance'.",
                    "1 строка с enabled = false — фича отключена.",
                    "SELECT prop_name, enabled FROM t_participant_property " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance';"
                ),
                false
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-3.1-ENABLED",
                    "feature_enable_originator_response_field_send_online_balance: enabled = true (включена)",
                    "В t_participant_property есть запись с participant_id = 0, prop_name = 'feature_enable_originator_response_field_send_online_balance', enabled = true.",
                    "Выполняется SELECT по participant_id = 0 и prop_name = 'feature_enable_originator_response_field_send_online_balance'.",
                    "1 строка с enabled = true — фича включена.",
                    "SELECT prop_name, enabled FROM t_participant_property " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance';"
                ),
                true
            )
        );
    }

    private static Stream<Arguments> enableSendOnlineBalanceFeatureScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-3.2-INSERT",
                    "Включение feature_enable_originator_response_field_send_online_balance: запись отсутствует — выполняется INSERT",
                    "В t_participant_property нет записи с participant_id = 0 и prop_name = 'feature_enable_originator_response_field_send_online_balance'.",
                    "Выполняется INSERT INTO t_participant_property с enabled = true.",
                    "Появляется 1 запись с enabled = true.",
                    "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
                    "VALUES (0, 'feature_enable_originator_response_field_send_online_balance', '', true);"
                ),
                false
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-3.2-UPDATE",
                    "Включение feature_enable_originator_response_field_send_online_balance: запись есть с enabled = false — выполняется UPDATE",
                    "В t_participant_property есть запись с participant_id = 0, prop_name = 'feature_enable_originator_response_field_send_online_balance', enabled = false.",
                    "Выполняется UPDATE t_participant_property SET enabled = true.",
                    "Запись обновлена: enabled = true.",
                    "UPDATE t_participant_property SET enabled = true " +
                    "WHERE participant_id = 0 AND prop_name = 'feature_enable_originator_response_field_send_online_balance';"
                ),
                true
            )
        );
    }

    private Connection openConnection() throws SQLException {
        String url = System.getProperty("db.url", "jdbc:postgresql://localhost:5432/gp");
        String user = System.getProperty("db.user", "postgres");
        String password = System.getProperty("db.password", System.getenv("DB_PASSWORD"));
        return DriverManager.getConnection(url, user, password);
    }

    private void insertParticipant(long id) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO participant (id) VALUES (?)"
        )) {
            ps.setLong(1, id);
            assertEquals(1, ps.executeUpdate());
        }
    }

    private void insertParticipantWithBalance(long id, BigDecimal onlineBalance) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO participant (id, online_balance) VALUES (?, ?)"
        )) {
            ps.setLong(1, id);
            ps.setBigDecimal(2, onlineBalance);
            assertEquals(1, ps.executeUpdate());
        }
    }

    private void insertBalance(long participantId, long settlementId, BigDecimal onlineBalance) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO t_participant_balance " +
            "(id, participant_id, settlement_participant_id, online_balance, minimum_balance, created_at) " +
            "VALUES (nextval('seq_participant_balance'), ?, ?, ?, 0, now())"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, settlementId);
            ps.setBigDecimal(3, onlineBalance);
            assertEquals(1, ps.executeUpdate());
        }
    }

    private void insertProperty(long participantId, String propName, boolean enabled) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) VALUES (?, ?, '', ?)"
        )) {
            ps.setLong(1, participantId);
            ps.setString(2, propName);
            ps.setBoolean(3, enabled);
            assertEquals(1, ps.executeUpdate());
        }
    }

    private void deleteProperty(long participantId, String propName) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
            "DELETE FROM t_participant_property WHERE participant_id = ? AND prop_name = ?"
        )) {
            ps.setLong(1, participantId);
            ps.setString(2, propName);
            ps.executeUpdate();
        }
    }
}

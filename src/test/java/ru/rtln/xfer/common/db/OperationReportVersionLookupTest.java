package ru.rtln.xfer.common.db;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.TestReporter;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.io.IOException;
import java.nio.file.Path;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DisplayName("1.3 Сотрудник L2: настройка записи operation_report_version для банка-участника")
@TestMethodOrder(OrderAnnotation.class)
class OperationReportVersionLookupTest extends DbIntegrationTest {

    @AfterAll
    static void writeRunbookDescriptionReport() throws IOException {
        RunbookDescriptionReporter.writeReports(
            OperationReportVersionLookupTest.class,
            Path.of("target", "runbook-reports", "operation_report_version_1_3_descriptions.md"),
            Path.of("target", "runbook-reports", "operation_report_version_1_3_descriptions.html"),
            "Описания Сценариев Runbook 1.3",
            "[runbook] Операционные реестры в формате excel"
        );
    }

    @DisplayName("1.3 Проверяет, существует ли уже запись operation_report_version для данного participant_id")
    @RunbookDescription(
        order = 10,
        id = "RUNBOOK-1.3-SELECT",
        title = "Проверяет, существует ли уже запись operation_report_version для данного participant_id",
        given = "Для participant_id запись operation_report_version может существовать или отсутствовать.",
        action = "Выполняется SELECT из runbook по participant_id и prop_name = 'operation_report_version'.",
        expected = "Если запись найдена, далее выбирается UPDATE; если запись не найдена, далее выбирается INSERT.",
        sql = """
            SELECT * FROM t_participant_property
            WHERE participant_id = { participant_id }
            AND prop_name = 'operation_report_version';
            """
    )
    @Order(10)
    @ParameterizedTest(name = "{0}")
    @MethodSource("existenceScenarios")
    void checksWhetherOperationReportVersionAlreadyExists(
        RunbookScenario scenario,
        boolean propertyExists,
        long participantId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        if (propertyExists) {
            try (PreparedStatement ps = connection.prepareStatement(
                "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
                "VALUES (?, 'operation_report_version', 'LEGACY_REPORT_VERSION', false)"
            )) {
                ps.setLong(1, participantId);
                assertEquals(1, ps.executeUpdate());
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT 1 FROM t_participant_property " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_version'"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertEquals(propertyExists, rs.next(), scenario.failurePrefix());
            }
        }
    }

    @DisplayName("1.3 Если запись существует - обновить значение prop_value")
    @RunbookDescription(
        order = 20,
        id = "RUNBOOK-1.3-UPDATE",
        title = "Если запись существует - обновить значение prop_value",
        given = "Для participant_id уже есть запись operation_report_version.",
        action = "Выполняется UPDATE: prop_value = '{ CE_V2_EXCEL | CE_V2_EXCEL_CUSTOM }', enabled = true.",
        expected = "Должна остаться ровно 1 запись operation_report_version с выбранным prop_value и enabled = true.",
        sql = """
            SELECT * FROM t_participant_property
            WHERE participant_id = { participant_id }
            AND prop_name = 'operation_report_version';

            UPDATE t_participant_property
            SET prop_value = '{ CE_V2_EXCEL | CE_V2_EXCEL_CUSTOM }',
            enabled = true
            WHERE participant_id = { participant_id }
            AND prop_name = 'operation_report_version';
            """
    )
    @Order(20)
    @ParameterizedTest(name = "{0}")
    @MethodSource("updateScenarios")
    void updatesOperationReportVersionWhenPropertyExists(
        RunbookScenario scenario,
        String reportVersion,
        long participantId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
            "VALUES (?, 'operation_report_version', 'LEGACY_REPORT_VERSION', false)"
        )) {
            ps.setLong(1, participantId);
            assertEquals(1, ps.executeUpdate());
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT 1 FROM t_participant_property " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_version'"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "Expected operation_report_version to exist");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "UPDATE t_participant_property " +
            "SET prop_value = ?, enabled = true " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_version'"
        )) {
            ps.setString(1, reportVersion);
            ps.setLong(2, participantId);
            assertEquals(1, ps.executeUpdate(), scenario.failurePrefix() + "Expected to update 1 row");
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT prop_value, enabled FROM t_participant_property " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_version'"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "Expected 1 row");
                assertEquals(reportVersion, rs.getString("prop_value"), scenario.failurePrefix());
                assertTrue(rs.getBoolean("enabled"), scenario.failurePrefix() + "Expected enabled=true");
                assertFalse(rs.next(), scenario.failurePrefix() + "Expected exactly 1 row");
            }
        }
    }

    @DisplayName("1.3 Если запись отсутствует - вставить новую")
    @RunbookDescription(
        order = 30,
        id = "RUNBOOK-1.3-INSERT",
        title = "Если запись отсутствует - вставить новую",
        given = "Для participant_id нет записи с prop_name = 'operation_report_version'.",
        action = "Выполняется INSERT в t_participant_property с prop_value = '{ CE_V2_EXCEL | CE_V2_EXCEL_CUSTOM }' и enabled = true.",
        expected = "Должна появиться ровно 1 запись operation_report_version с выбранным prop_value и enabled = true.",
        sql = """
            SELECT * FROM t_participant_property
            WHERE participant_id = { participant_id }
            AND prop_name = 'operation_report_version';

            INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
            VALUES ({ participant_id }, 'operation_report_version', '{ CE_V2_EXCEL | CE_V2_EXCEL_CUSTOM }', true);
            """
    )
    @Order(30)
    @ParameterizedTest(name = "{0}")
    @MethodSource("insertScenarios")
    void insertsOperationReportVersionWhenPropertyIsAbsent(
        RunbookScenario scenario,
        String reportVersion,
        long participantId,
        TestInfo testInfo,
        TestReporter testReporter
    ) throws SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        scenario.publish(testReporter);

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT 1 FROM t_participant_property " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_version'"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertFalse(
                    rs.next(),
                    scenario.failurePrefix() + "Expected operation_report_version to be absent"
                );
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
            "VALUES (?, 'operation_report_version', ?, true)"
        )) {
            ps.setLong(1, participantId);
            ps.setString(2, reportVersion);
            assertEquals(1, ps.executeUpdate(), scenario.failurePrefix() + "Expected to insert 1 row");
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT prop_value, enabled FROM t_participant_property " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_version'"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), scenario.failurePrefix() + "Expected 1 row");
                assertEquals(reportVersion, rs.getString("prop_value"), scenario.failurePrefix());
                assertTrue(rs.getBoolean("enabled"), scenario.failurePrefix() + "Expected enabled=true");
                assertFalse(rs.next(), scenario.failurePrefix() + "Expected exactly 1 row");
            }
        }
    }

    private static Stream<Arguments> insertScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-INSERT-CE_V2_EXCEL",
                    "Если запись отсутствует - вставить новую: CE_V2_EXCEL",
                    "Для participant_id нет записи с prop_name = 'operation_report_version'.",
                    "Выполняется INSERT в t_participant_property с prop_value = 'CE_V2_EXCEL' и enabled = true.",
                    "Должна появиться ровно 1 запись operation_report_version со значением CE_V2_EXCEL и enabled = true.",
                    """
                    SELECT * FROM t_participant_property
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';

                    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
                    VALUES ({ participant_id }, 'operation_report_version', 'CE_V2_EXCEL', true);
                    """
                ),
                "CE_V2_EXCEL",
                -290001L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-INSERT-CE_V2_EXCEL_CUSTOM",
                    "Если запись отсутствует - вставить новую: CE_V2_EXCEL_CUSTOM",
                    "Для participant_id нет записи с prop_name = 'operation_report_version'.",
                    "Выполняется INSERT в t_participant_property с prop_value = 'CE_V2_EXCEL_CUSTOM' и enabled = true.",
                    "Должна появиться ровно 1 запись operation_report_version со значением CE_V2_EXCEL_CUSTOM и enabled = true.",
                    """
                    SELECT * FROM t_participant_property
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';
                    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
                    VALUES ({ participant_id }, 'operation_report_version', 'CE_V2_EXCEL_CUSTOM', true);
                    """
                ),
                "CE_V2_EXCEL_CUSTOM",
                -290002L
            )
        );
    }

    private static Stream<Arguments> updateScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-UPDATE-CE_V2_EXCEL",
                    "Если запись существует - обновить значение prop_value: CE_V2_EXCEL",
                    "Для participant_id уже есть запись operation_report_version с устаревшим prop_value и enabled = false.",
                    "Выполняется UPDATE: prop_value = 'CE_V2_EXCEL', enabled = true.",
                    "Должна остаться ровно 1 запись operation_report_version со значением CE_V2_EXCEL и enabled = true.",
                    """
                    SELECT * FROM t_participant_property
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';

                    UPDATE t_participant_property
                    SET prop_value = 'CE_V2_EXCEL',
                    enabled = true
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';
                    """
                ),
                "CE_V2_EXCEL",
                -290003L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-UPDATE-CE_V2_EXCEL_CUSTOM",
                    "Если запись существует - обновить значение prop_value: CE_V2_EXCEL_CUSTOM",
                    "Для participant_id уже есть запись operation_report_version с устаревшим prop_value и enabled = false.",
                    "Выполняется UPDATE: prop_value = 'CE_V2_EXCEL_CUSTOM', enabled = true.",
                    "Должна остаться ровно 1 запись operation_report_version со значением CE_V2_EXCEL_CUSTOM и enabled = true.",
                    """
                    SELECT * FROM t_participant_property
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';

                    UPDATE t_participant_property
                    SET prop_value = 'CE_V2_EXCEL_CUSTOM',
                    enabled = true
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';
                    """
                ),
                "CE_V2_EXCEL_CUSTOM",
                -290004L
            )
        );
    }

    private static Stream<Arguments> existenceScenarios() {
        return Stream.of(
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-SELECT-ABSENT",
                    "Проверяет, существует ли уже запись operation_report_version: запись отсутствует",
                    "Для participant_id нет записи с prop_name = 'operation_report_version'.",
                    "Выполняется SELECT из runbook.",
                    "Проверка должна вернуть false, чтобы далее был выбран сценарий INSERT.",
                    """
                    SELECT * FROM t_participant_property
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';
                    """
                ),
                false,
                -290006L
            ),
            Arguments.of(
                new RunbookScenario(
                    "RUNBOOK-1.3-SELECT-EXISTS",
                    "Проверяет, существует ли уже запись operation_report_version: запись существует",
                    "Для participant_id уже есть запись с prop_name = 'operation_report_version'.",
                    "Выполняется SELECT из runbook.",
                    "Проверка должна вернуть true, чтобы далее был выбран сценарий UPDATE.",
                    """
                    SELECT * FROM t_participant_property
                    WHERE participant_id = { participant_id }
                    AND prop_name = 'operation_report_version';
                    """
                ),
                true,
                -290005L
            )
        );
    }

}

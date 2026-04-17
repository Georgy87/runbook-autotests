package ru.rtln.xfer.common.db;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.TestReporter;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

@DisplayName("2.1-2.3 Сотрудник L2: настройка кастомных полей operation_report_fields")
@TestMethodOrder(OrderAnnotation.class)
class OperationReportFieldsConfigurationTest extends DbIntegrationTest {

    private static final Path VALIDATION_MIGRATION =
        Path.of("db", "migration", "V2__validate_operation_report_fields.sql");
    private static final String CUSTOM_FIELDS = "creation_time,check_sum,platform_reference_number";
    private static final String UPDATED_CUSTOM_FIELDS = "check_sum,creation_time";

    @AfterAll
    static void writeRunbookDescriptionReport() throws IOException {
        RunbookDescriptionReporter.writeReports(
            OperationReportFieldsConfigurationTest.class,
            Path.of("target", "runbook-reports", "operation_report_fields_2_descriptions.md"),
            Path.of("target", "runbook-reports", "operation_report_fields_2_descriptions.html"),
            "Описания Сценариев Runbook 2.1-2.3",
            "[runbook] Операционные реестры в формате excel.pdf"
        );
    }

    @DisplayName("2.1 Формирует строку из полей через запятую в порядке требования партнёра")
    @RunbookDescription(
        order = 10,
        id = "RUNBOOK-2.1-FORM-FIELDS-CSV",
        title = "Формирует строку из полей через запятую в порядке требования партнёра",
        given = "Бизнес-эксперт передал список кастомных полей в требуемой очерёдности.",
        action = "Сотрудник L2 формирует CSV-строку из полей через запятую без изменения порядка.",
        expected = "CSV-строка должна сохранить порядок полей, указанный бизнес-экспертом.",
        sql = """
            'check_sum,platform_reference_number,creation_time,payment_amount,payment_currency'
            """
    )
    @Order(10)
    @Test
    void formsOperationReportFieldsCsvInRequestedOrder(
        TestInfo testInfo,
        TestReporter testReporter
    ) {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);

        List<String> requestedFields = List.of(
            "creation_time",
            "check_sum",
            "platform_reference_number"
        );

        String reportFields = String.join(",", requestedFields);

        assertEquals(CUSTOM_FIELDS, reportFields);
    }

    @DisplayName("2.2 Выполняет INSERT записи operation_report_fields")
    @RunbookDescription(
        order = 20,
        id = "RUNBOOK-2.2-INSERT-OPERATION-REPORT-FIELDS",
        title = "Выполняет INSERT записи operation_report_fields",
        given = "Для participant_id нет записи с prop_name = 'operation_report_fields'.",
        action = "Выполняется INSERT в t_participant_property с prop_name = 'operation_report_fields', CSV-списком полей и enabled = true.",
        expected = "Должна появиться ровно 1 запись operation_report_fields с ожидаемым prop_value и enabled = true.",
        sql = """
            INSERT INTO t_participant_property (participant_id, prop_name,
            prop_value, enabled)
            VALUES (
                { participant_id },
                'operation_report_fields',
                '{      }',
                true
            );
            """
    )
    @Order(20)
    @Test
    void insertsOperationReportFieldsWhenPropertyIsAbsent(
        TestInfo testInfo,
        TestReporter testReporter
    ) throws IOException, SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        applyOperationReportFieldsValidationMigration();

        long participantId = -310001L;

        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT 1 FROM t_participant_property " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_fields'"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertFalse(rs.next(), "Expected operation_report_fields to be absent");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
            "VALUES (?, 'operation_report_fields', ?, true)"
        )) {
            ps.setLong(1, participantId);
            ps.setString(2, CUSTOM_FIELDS);
            assertEquals(1, ps.executeUpdate());
        }

        assertSingleOperationReportFieldsRow(participantId, CUSTOM_FIELDS, true);
    }

    @DisplayName("2.2 Выполняет UPDATE записи operation_report_fields")
    @RunbookDescription(
        order = 30,
        id = "RUNBOOK-2.2-UPDATE-OPERATION-REPORT-FIELDS",
        title = "Выполняет UPDATE записи operation_report_fields",
        given = "Для participant_id уже есть запись с prop_name = 'operation_report_fields'.",
        action = "Выполняется UPDATE записи operation_report_fields с новым CSV-списком полей и enabled = true.",
        expected = "Должна остаться ровно 1 запись operation_report_fields с новым prop_value и enabled = true.",
        sql = """
            UPDATE t_participant_property
            SET prop_value = '{      }',
                enabled = true
            WHERE participant_id = { participant_id }
              AND prop_name = 'operation_report_fields';
            """
    )
    @Order(30)
    @Test
    void updatesOperationReportFieldsWhenPropertyExists(
        TestInfo testInfo,
        TestReporter testReporter
    ) throws IOException, SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        applyOperationReportFieldsValidationMigration();

        long participantId = -310002L;

        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
            "VALUES (?, 'operation_report_fields', 'check_sum', false)"
        )) {
            ps.setLong(1, participantId);
            assertEquals(1, ps.executeUpdate());
        }

        try (PreparedStatement ps = connection.prepareStatement(
            "UPDATE t_participant_property " +
            "SET prop_value = ?, enabled = true " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_fields'"
        )) {
            ps.setString(1, UPDATED_CUSTOM_FIELDS);
            ps.setLong(2, participantId);
            assertEquals(1, ps.executeUpdate());
        }

        assertSingleOperationReportFieldsRow(participantId, UPDATED_CUSTOM_FIELDS, true);
    }

    @DisplayName("2.3 Проверяет, что записи operation_report_version и operation_report_fields добавлены корректно")
    @RunbookDescription(
        order = 40,
        id = "RUNBOOK-2.3-VERIFY-OPERATION-REPORT-PROPERTIES",
        title = "Проверяет, что записи operation_report_version и operation_report_fields добавлены корректно",
        given = "Для participant_id настроены кастомная версия реестра и список кастомных полей.",
        action = "Выполняется SELECT из runbook по participant_id и prop_name IN ('operation_report_version', 'operation_report_fields').",
        expected = "Запрос должен вернуть ровно 2 enabled-записи: operation_report_version = CE_V2_EXCEL_CUSTOM и operation_report_fields = ожидаемый CSV.",
        sql = """
            SELECT * FROM t_participant_property
            WHERE participant_id = { participant_id }
              AND prop_name IN ('operation_report_version',
            'operation_report_fields');
            """
    )
    @Order(40)
    @Test
    void verifiesOperationReportVersionAndFieldsWereConfigured(
        TestInfo testInfo,
        TestReporter testReporter
    ) throws IOException, SQLException {
        RunbookDescriptionReporter.publishAnnotation(testInfo, testReporter);
        applyOperationReportFieldsValidationMigration();

        long participantId = -310003L;

        try (PreparedStatement ps = connection.prepareStatement(
            "INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled) " +
            "VALUES " +
            "(?, 'operation_report_version', 'CE_V2_EXCEL_CUSTOM', true), " +
            "(?, 'operation_report_fields', ?, true)"
        )) {
            ps.setLong(1, participantId);
            ps.setLong(2, participantId);
            ps.setString(3, CUSTOM_FIELDS);
            assertEquals(2, ps.executeUpdate());
        }

        Map<String, PropertyRow> rows = new HashMap<>();
        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT prop_name, prop_value, enabled FROM t_participant_property " +
            "WHERE participant_id = ? " +
            "AND prop_name IN ('operation_report_version', 'operation_report_fields')"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rows.put(
                        rs.getString("prop_name"),
                        new PropertyRow(rs.getString("prop_value"), rs.getBoolean("enabled"))
                    );
                }
            }
        }

        assertEquals(2, rows.size());
        assertEquals(new PropertyRow("CE_V2_EXCEL_CUSTOM", true), rows.get("operation_report_version"));
        assertEquals(new PropertyRow(CUSTOM_FIELDS, true), rows.get("operation_report_fields"));
    }

    private void applyOperationReportFieldsValidationMigration() throws IOException, SQLException {
        try (Statement statement = connection.createStatement()) {
            statement.execute(Files.readString(VALIDATION_MIGRATION));
        }
    }

    private void assertSingleOperationReportFieldsRow(
        long participantId,
        String expectedPropValue,
        boolean expectedEnabled
    ) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(
            "SELECT prop_value, enabled FROM t_participant_property " +
            "WHERE participant_id = ? AND prop_name = 'operation_report_fields'"
        )) {
            ps.setLong(1, participantId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next(), "Expected 1 operation_report_fields row");
                assertEquals(expectedPropValue, rs.getString("prop_value"));
                assertEquals(expectedEnabled, rs.getBoolean("enabled"));
                assertFalse(rs.next(), "Expected exactly 1 operation_report_fields row");
            }
        }
    }

    private record PropertyRow(String propValue, boolean enabled) {
    }
}

\set ON_ERROR_STOP on

BEGIN;

-- 1.3 Сотрудник L2
-- Проверяет, существует ли уже запись operation_report_version для данного participant_id:
-- SELECT * FROM t_participant_property
-- WHERE participant_id = { participant_id }
-- AND prop_name = 'operation_report_version';
--
-- Если запись отсутствует - вставить новую
-- INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
-- VALUES ({ participant_id }, 'operation_report_version', '{ CE_V2_EXCEL | CE_V2_EXCEL_CUSTOM }', true);
INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
VALUES (-290001, 'operation_report_version', 'CE_V2_EXCEL_CUSTOM', true);

-- Если запись существует - обновить значение prop_value
-- UPDATE t_participant_property
-- SET prop_value = '{ CE_V2_EXCEL | CE_V2_EXCEL_CUSTOM }',
-- enabled = true
-- WHERE participant_id = { participant_id }
-- AND prop_name = 'operation_report_version';
INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
VALUES
    (-290003, 'operation_report_version', 'LEGACY_REPORT_VERSION', false),
    (-290004, 'operation_report_version', 'LEGACY_REPORT_VERSION', false);

INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
VALUES (-290002, 'operation_report_version', 'CE_V2_EXCEL', true);

UPDATE t_participant_property
SET prop_value = 'CE_V2_EXCEL', enabled = true
WHERE participant_id = -290003
  AND prop_name = 'operation_report_version';

UPDATE t_participant_property
SET prop_value = 'CE_V2_EXCEL_CUSTOM', enabled = true
WHERE participant_id = -290004
  AND prop_name = 'operation_report_version';

DO $$
DECLARE
    case_record record;
BEGIN
    FOR case_record IN
        SELECT *
        FROM (VALUES
            (-290001::bigint, 'CE_V2_EXCEL_CUSTOM'::varchar),
            (-290002::bigint, 'CE_V2_EXCEL'::varchar),
            (-290003::bigint, 'CE_V2_EXCEL'::varchar),
            (-290004::bigint, 'CE_V2_EXCEL_CUSTOM'::varchar)
        ) AS expected(participant_id, prop_value)
    LOOP
        IF (
            SELECT count(*)
            FROM t_participant_property
            WHERE participant_id = case_record.participant_id
              AND prop_name = 'operation_report_version'
        ) <> 1 THEN
            RAISE EXCEPTION 'Expected 1 operation_report_version row for participant_id %', case_record.participant_id;
        END IF;

        IF NOT EXISTS (
            SELECT 1
            FROM t_participant_property
            WHERE participant_id = case_record.participant_id
              AND prop_name = 'operation_report_version'
              AND prop_value = case_record.prop_value
              AND enabled = true
        ) THEN
            RAISE EXCEPTION 'Expected operation_report_version=% and enabled=true for participant_id %',
                case_record.prop_value,
                case_record.participant_id;
        END IF;
    END LOOP;
END $$;

ROLLBACK;

\echo 'operation_report_version lookup test: ok'

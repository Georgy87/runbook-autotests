BEGIN;

DELETE FROM t_participant_property
WHERE participant_id BETWEEN -300020 AND -300001;

INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
VALUES (
    -300001,
    'operation_report_fields',
    'check_sum, platform_reference_number,creation_time',
    true
);

DO $$
DECLARE
    v_prop_value text;
BEGIN
    SELECT prop_value
    INTO v_prop_value
    FROM t_participant_property
    WHERE participant_id = -300001
      AND prop_name = 'operation_report_fields';

    IF v_prop_value <> 'check_sum,platform_reference_number,creation_time' THEN
        RAISE EXCEPTION 'Expected normalized prop_value, got %', v_prop_value;
    END IF;
END;
$$;

UPDATE t_participant_property
SET prop_value = 'check_sum, creation_time'
WHERE participant_id = -300001
  AND prop_name = 'operation_report_fields';

DO $$
DECLARE
    v_prop_value text;
BEGIN
    SELECT prop_value
    INTO v_prop_value
    FROM t_participant_property
    WHERE participant_id = -300001
      AND prop_name = 'operation_report_fields';

    IF v_prop_value <> 'check_sum,creation_time' THEN
        RAISE EXCEPTION 'Expected normalized updated prop_value, got %', v_prop_value;
    END IF;
END;
$$;

INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
VALUES (-300002, 'operation_report_version', 'unknown_field', true);

DO $$
BEGIN
    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
    VALUES (-300003, 'operation_report_fields', null, true);

    RAISE EXCEPTION 'Expected null prop_value validation error';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLERRM <> 'operation_report_fields must not be null' THEN
            RAISE EXCEPTION 'Expected null prop_value error, got: %', SQLERRM;
        END IF;
END;
$$;

DO $$
BEGIN
    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
    VALUES (-300004, 'operation_report_fields', '', true);

    RAISE EXCEPTION 'Expected empty prop_value validation error';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLERRM <> 'operation_report_fields must not be empty' THEN
            RAISE EXCEPTION 'Expected empty prop_value error, got: %', SQLERRM;
        END IF;
END;
$$;

DO $$
BEGIN
    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
    VALUES (-300005, 'operation_report_fields', 'check_sum,,creation_time', true);

    RAISE EXCEPTION 'Expected empty CSV field validation error';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLERRM <> 'operation_report_fields contains empty field value' THEN
            RAISE EXCEPTION 'Expected empty CSV field error, got: %', SQLERRM;
        END IF;
END;
$$;

DO $$
BEGIN
    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
    VALUES (-300006, 'operation_report_fields', 'check_sum, ,creation_time', true);

    RAISE EXCEPTION 'Expected whitespace-only CSV field validation error';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLERRM <> 'operation_report_fields contains empty field value' THEN
            RAISE EXCEPTION 'Expected whitespace-only CSV field error, got: %', SQLERRM;
        END IF;
END;
$$;

DO $$
BEGIN
    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
    VALUES (-300007, 'operation_report_fields', 'check_sum,unknown_field', true);

    RAISE EXCEPTION 'Expected invalid field validation error';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLERRM <> 'operation_report_fields contains invalid fields: unknown_field' THEN
            RAISE EXCEPTION 'Expected invalid field error, got: %', SQLERRM;
        END IF;
END;
$$;

DO $$
BEGIN
    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
    VALUES (-300008, 'operation_report_fields', 'check_sum,check_sum', true);

    RAISE EXCEPTION 'Expected duplicate field validation error';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLERRM <> 'operation_report_fields contains duplicate fields: check_sum' THEN
            RAISE EXCEPTION 'Expected duplicate field error, got: %', SQLERRM;
        END IF;
END;
$$;

DO $$
BEGIN
    INSERT INTO t_participant_property (participant_id, prop_name, prop_value, enabled)
    VALUES (-300009, 'operation_report_fields', 'check_sum,null', true);

    RAISE EXCEPTION 'Expected null element validation error';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLERRM <> 'operation_report_fields contains null element' THEN
            RAISE EXCEPTION 'Expected null element error, got: %', SQLERRM;
        END IF;
END;
$$;

ROLLBACK;

\echo 'operation_report_fields validation test: ok'

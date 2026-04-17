CREATE OR REPLACE FUNCTION validate_operation_report_fields()
RETURNS trigger AS $$
DECLARE
    v_prop_value_normalized text;
    v_fields text[];
    v_val text;
    v_duplicates text[] := array[]::text[];
    v_invalid text[] := array[]::text[];
    v_seen text[] := array[]::text[];
    v_whitelist text[] := array[
        'check_sum',
        'platform_reference_number',
        'creation_time'
    ];
BEGIN
    IF NEW.prop_name <> 'operation_report_fields' THEN
        RETURN NEW;
    END IF;

    IF NEW.prop_value IS NULL THEN
        RAISE EXCEPTION 'operation_report_fields must not be null';
    END IF;

    IF btrim(NEW.prop_value) = '' THEN
        RAISE EXCEPTION 'operation_report_fields must not be empty';
    END IF;

    v_prop_value_normalized := replace(NEW.prop_value, ' ', '');

    IF v_prop_value_normalized = '' THEN
        RAISE EXCEPTION 'operation_report_fields must not be empty';
    END IF;

    v_fields := string_to_array(v_prop_value_normalized, ',');

    IF v_fields IS NULL OR array_length(v_fields, 1) IS NULL THEN
        RAISE EXCEPTION 'operation_report_fields must not be empty';
    END IF;

    FOREACH v_val IN ARRAY v_fields
    LOOP
        IF v_val = 'null' THEN
            RAISE EXCEPTION 'operation_report_fields contains null element';
        END IF;

        IF btrim(v_val) = '' THEN
            RAISE EXCEPTION 'operation_report_fields contains empty field value';
        END IF;

        IF v_val = ANY(v_seen) AND NOT (v_val = ANY(v_duplicates)) THEN
            v_duplicates := array_append(v_duplicates, v_val);
        END IF;

        v_seen := array_append(v_seen, v_val);

        IF NOT (v_val = ANY(v_whitelist)) AND NOT (v_val = ANY(v_invalid)) THEN
            v_invalid := array_append(v_invalid, v_val);
        END IF;
    END LOOP;

    IF array_length(v_duplicates, 1) > 0 THEN
        RAISE EXCEPTION 'operation_report_fields contains duplicate fields: %',
            array_to_string(v_duplicates, ', ');
    END IF;

    IF array_length(v_invalid, 1) > 0 THEN
        RAISE EXCEPTION 'operation_report_fields contains invalid fields: %',
            array_to_string(v_invalid, ', ');
    END IF;

    NEW.prop_value := v_prop_value_normalized;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_validate_operation_report_fields ON t_participant_property;

CREATE TRIGGER tr_validate_operation_report_fields
BEFORE INSERT OR UPDATE ON t_participant_property
FOR EACH ROW
WHEN (NEW.prop_name = 'operation_report_fields')
EXECUTE FUNCTION validate_operation_report_fields();

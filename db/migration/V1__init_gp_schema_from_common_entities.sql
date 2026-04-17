-- Initial PostgreSQL schema for local database `gp`.
-- Based on entities visible in common/data/entity.
-- References to entities missing from this checkout are kept as scalar columns without FK constraints.

CREATE SEQUENCE IF NOT EXISTS fee_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS participant_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_customer_identification START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS currency_rate_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS currency_pair_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_contract_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_contract_flow_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS transfer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_transfer_bin_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_participant_property START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_participant_balance START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_participant_balance_history START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS participant_limit_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS participant_names_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS notification_address_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_notification_event START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS consolidated_entry_seq START WITH 1 INCREMENT BY 100;
CREATE SEQUENCE IF NOT EXISTS rds_selector_id_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS failed_message_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS seq_currency_rate_history START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IF NOT EXISTS revinfo_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS fee (
    id bigint PRIMARY KEY DEFAULT nextval('fee_seq'),
    fee_amount numeric(38, 2),
    start_date timestamp,
    end_date timestamp,
    document_name varchar(255)
);

CREATE TABLE IF NOT EXISTS participant (
    id bigint PRIMARY KEY DEFAULT nextval('participant_seq'),
    alias_participant_id_for_balance bigint,
    country varchar(255),
    logo varchar(255),
    fee_id bigint,
    upper_fee boolean NOT NULL DEFAULT false,
    account_number varchar(255),
    agreement_number varchar(255),
    inn varchar(255),
    locale varchar(255),
    status varchar(255),
    currencies varchar(255),
    url varchar(255),
    originator_markup numeric(38, 2),
    receiver_markup numeric(38, 2),
    receiver_fee numeric(38, 2),
    minimum_balance numeric(38, 2),
    online_balance numeric(38, 2),
    is_failing_response boolean NOT NULL DEFAULT false,
    is_validate_personal_data boolean NOT NULL DEFAULT false,
    transliterate_mandatory boolean NOT NULL DEFAULT false,
    is_send_originator boolean NOT NULL DEFAULT false,
    is_report_settlement_prefix boolean NOT NULL DEFAULT false,
    is_report_intermediaries_prefix boolean NOT NULL DEFAULT false,
    is_validate_response_v3 boolean NOT NULL DEFAULT false,
    intermediary_code varchar(255),
    external_id varchar(255),
    intermediary_for varchar(255),
    api_version varchar(255),
    identification_type_list varchar(1024)
);

CREATE TABLE IF NOT EXISTS t_customer_identification (
    id bigint PRIMARY KEY DEFAULT nextval('seq_customer_identification'),
    type varchar(255),
    value varchar(255),
    hashed_value varchar(255),
    cc_masked boolean DEFAULT false
);

CREATE TABLE IF NOT EXISTS customer (
    id bigint PRIMARY KEY DEFAULT nextval('customer_seq'),
    participant_id bigint,
    email varchar(255),
    full_name varchar(64),
    full_name_lat varchar(64),
    display_name varchar(255),
    registration_data varchar(255),
    account_mask varchar(255),
    currencies varchar(255),
    identification_id bigint
);

CREATE TABLE IF NOT EXISTS currency_rate (
    id bigint PRIMARY KEY DEFAULT nextval('currency_rate_seq'),
    currency_code varchar(255),
    settlement_currency_code varchar(255),
    buy_rate numeric(38, 10),
    sell_rate numeric(38, 10),
    base_rate numeric(38, 10),
    base_rate_source varchar(255),
    start_date timestamp with time zone,
    end_date timestamp with time zone
);

CREATE TABLE IF NOT EXISTS t_currency_pair (
    id bigint PRIMARY KEY DEFAULT nextval('currency_pair_id_seq'),
    settlement_currency varchar(255),
    requested_currency varchar(255)
);

CREATE TABLE IF NOT EXISTS t_contract (
    id bigint PRIMARY KEY DEFAULT nextval('seq_contract_id'),
    type varchar(255),
    number varchar(255),
    start_date date,
    end_date date,
    status varchar(255)
);

CREATE TABLE IF NOT EXISTS t_contract_flow (
    id bigint PRIMARY KEY DEFAULT nextval('seq_contract_flow_id'),
    contract_id bigint NOT NULL,
    originator_id bigint,
    originator_intermediary_id bigint,
    receiver_intermediary_id bigint,
    receiver_id bigint,
    payment_flow_type varchar(255),
    originator_currency varchar(255),
    receiver_currency varchar(255),
    mask_originator_by bigint,
    settlement_participant_id bigint NOT NULL,
    receiver_url varchar(255),
    identification_type varchar(255),
    originator_markup numeric(38, 10),
    platform_markup numeric(38, 10),
    receiver_markup numeric(38, 10),
    originator_fee numeric(38, 10),
    originator_intermediary_fee numeric(38, 10),
    platform_fee_from_originator numeric(38, 10),
    platform_fee_from_receiver numeric(38, 10),
    receiver_intermediary_fee numeric(38, 10),
    receiver_fee numeric(38, 10),
    intermediary_fee numeric(38, 10),
    originator_interest numeric(38, 10),
    platform_interest numeric(38, 10),
    receiver_interest numeric(38, 10),
    settlement_payer varchar(255),
    settlement_fee numeric(38, 10),
    enabled boolean NOT NULL DEFAULT false,
    need_receiving_amount_rounding boolean NOT NULL DEFAULT false,
    balancing_spread_percentage smallint
);

CREATE TABLE IF NOT EXISTS transfer (
    id bigint PRIMARY KEY DEFAULT nextval('transfer_seq'),
    originator_reference_number varchar(255),
    platform_reference_number varchar(255),
    originator_id bigint,
    receiver_id bigint,
    payment_amount_sum numeric(38, 10),
    payment_amount_currency varchar(255),
    display_fee_amount_sum numeric(38, 10),
    display_fee_amount_currency varchar(255),
    fee_amount_sum numeric(38, 10),
    fee_amount_currency varchar(255),
    receiver_fee_amount_sum numeric(38, 10),
    receiver_fee_amount_currency varchar(255),
    intermediary_fee_amount_sum numeric(38, 10),
    intermediary_fee_amount_currency varchar(255),
    settelment_amount_sum numeric(38, 10),
    settelment_amount_currency varchar(255),
    receiving_amount_sum numeric(38, 10),
    receiving_amount_currency varchar(255),
    precheck_date timestamp with time zone,
    check_date timestamp with time zone,
    transfer_date timestamp with time zone,
    confirmed_date timestamp with time zone,
    settelment_date timestamp,
    received_date timestamp with time zone,
    comment varchar(255),
    conversion_rate_buy_id bigint,
    conversion_rate_sell_id bigint,
    transfer_state varchar(255),
    error_code integer,
    ext_check_request_id varchar(255),
    ext_check_response_id varchar(255),
    ext_confirm_request_id varchar(255),
    ext_confirm_response_id varchar(255),
    contract_flow_id bigint,
    payment_purpose varchar(255),
    receiver_bin_country_code varchar(2),
    precheck_transfer_id bigint,
    payment_id varchar(255)
);

CREATE TABLE IF NOT EXISTS t_transfer_bin (
    id bigint PRIMARY KEY DEFAULT nextval('seq_transfer_bin_id'),
    transfer_id bigint,
    bin varchar(16),
    country_code varchar(255),
    participant_id bigint,
    payment_system varchar(20)
);

CREATE TABLE IF NOT EXISTS t_participant_property (
    id bigint PRIMARY KEY DEFAULT nextval('seq_participant_property'),
    participant_id bigint NOT NULL DEFAULT -1,
    prop_name varchar(255) NOT NULL DEFAULT '',
    prop_value varchar(255) NOT NULL DEFAULT '',
    enabled boolean NOT NULL DEFAULT true
);

CREATE TABLE IF NOT EXISTS t_participant_balance_history (
    id bigint PRIMARY KEY DEFAULT nextval('seq_participant_balance_history'),
    participant_id bigint NOT NULL,
    settlement_participant_id bigint NOT NULL,
    operation_type varchar(255) NOT NULL,
    transfer_id bigint,
    amount numeric(38, 10),
    currency varchar(255),
    time timestamp with time zone,
    created_at timestamp NOT NULL,
    comment varchar(255)
);

CREATE TABLE IF NOT EXISTS t_participant_balance (
    id bigint PRIMARY KEY DEFAULT nextval('seq_participant_balance'),
    participant_id bigint,
    settlement_participant_id bigint,
    currency varchar(255),
    online_balance numeric(38, 10),
    minimum_balance numeric(38, 10),
    participant_balance_history_id bigint,
    created_at timestamp NOT NULL,
    updated_at timestamp
);

CREATE TABLE IF NOT EXISTS t_participant_limit (
    id bigint PRIMARY KEY DEFAULT nextval('participant_limit_id_seq'),
    limit_type varchar(255),
    val numeric(38, 10),
    currency varchar(255),
    participant_id bigint
);

CREATE TABLE IF NOT EXISTS participant_names (
    id bigint PRIMARY KEY DEFAULT nextval('participant_names_seq'),
    participant_id bigint,
    locale varchar(255),
    participant_name varchar(255)
);

CREATE TABLE IF NOT EXISTS notification_addresses (
    id bigint PRIMARY KEY DEFAULT nextval('notification_address_seq'),
    participant_id bigint,
    type varchar(255),
    email varchar(255),
    certificate_path varchar(255)
);

CREATE TABLE IF NOT EXISTS t_notification_event (
    id bigint PRIMARY KEY DEFAULT nextval('seq_notification_event'),
    participant_id bigint,
    type varchar(255),
    state varchar(255),
    key varchar(255),
    attempts integer,
    create_date timestamp with time zone,
    sent_date timestamp with time zone,
    title varchar(255),
    body varchar(255)
);

CREATE TABLE IF NOT EXISTS consolidated_entry (
    id bigint PRIMARY KEY DEFAULT nextval('consolidated_entry_seq'),
    business_day timestamp,
    participant_id bigint,
    amount numeric(38, 10),
    account_number varchar(255),
    agreement_number varchar(255),
    currency varchar(255),
    state varchar(255),
    entry_type_id bigint,
    intermediary_type varchar(255),
    payment_flow_type varchar(255),
    ce_file_id bigint,
    report_send_data_id bigint,
    contract_flow_id bigint,
    amount_nds numeric(38, 10),
    amount_without_nds numeric(38, 10)
);

CREATE TABLE IF NOT EXISTS t_rds_selector (
    id bigint PRIMARY KEY DEFAULT nextval('rds_selector_id_seq'),
    sender_id bigint,
    receiver_id bigint,
    rate_type varchar(255),
    currency_pair_id bigint,
    rds_id bigint
);

CREATE TABLE IF NOT EXISTS t_currency_rate_history (
    id bigint PRIMARY KEY DEFAULT nextval('seq_currency_rate_history'),
    participant_id bigint,
    settlement_participant_id bigint,
    currency_code varchar(255),
    settlement_currency_code varchar(255),
    buy_rate numeric(38, 10),
    sell_rate numeric(38, 10),
    base_sell_rate numeric(38, 10),
    base_buy_rate numeric(38, 10),
    national_rate numeric(38, 10),
    base_rate_source varchar(255),
    create_date timestamp with time zone
);

CREATE TABLE IF NOT EXISTS t_currency_rate_spread (
    id bigint PRIMARY KEY,
    country_name varchar(255),
    base_percent_value numeric(38, 10),
    base_percent_weekend_value numeric(38, 10),
    first_step_percent_limit numeric(38, 10)
);

CREATE TABLE IF NOT EXISTS clearing_bank_rate (
    first_currency_code varchar(255) NOT NULL,
    second_currency_code varchar(255) NOT NULL,
    platform_code varchar(255) NOT NULL,
    bid numeric(38, 10),
    offer numeric(38, 10),
    last numeric(38, 10),
    trading_status boolean,
    timestamp timestamp,
    PRIMARY KEY (first_currency_code, second_currency_code, platform_code)
);

CREATE TABLE IF NOT EXISTS national_bank_exchange_rate (
    first_currency_code varchar(255) NOT NULL,
    second_currency_code varchar(255) NOT NULL,
    rate numeric(38, 10),
    rate_date date,
    updated timestamp with time zone,
    PRIMARY KEY (first_currency_code, second_currency_code)
);

CREATE TABLE IF NOT EXISTS t_additional_identification_type (
    name varchar(255) PRIMARY KEY,
    description varchar(255)
);

CREATE TABLE IF NOT EXISTS t_ci (
    id bigint PRIMARY KEY,
    type varchar(255),
    value varchar(255),
    hashed_value varchar(255),
    cc_masked boolean DEFAULT false
);

CREATE TABLE IF NOT EXISTS t_sign_valid_cert (
    id bigint PRIMARY KEY,
    participant_id bigint,
    valid_from timestamp,
    valid_to timestamp,
    encoded_content varchar(255)
);

CREATE TABLE IF NOT EXISTS keys (
    id bigint PRIMARY KEY,
    participant_id bigint,
    start_date timestamp with time zone,
    path varchar(255),
    comment varchar(255)
);

CREATE TABLE IF NOT EXISTS platform (
    account_number varchar(255) PRIMARY KEY,
    business_day timestamp,
    platform_interest numeric(38, 10),
    settlement_interest numeric(38, 10),
    originator_interest numeric(38, 10),
    receiver_interest numeric(38, 10),
    intermediary_fee numeric(38, 10)
);

CREATE TABLE IF NOT EXISTS t_limit_value (
    id varchar(255) PRIMARY KEY,
    val numeric(38, 10)
);

CREATE TABLE IF NOT EXISTS failed_message (
    id bigint PRIMARY KEY DEFAULT nextval('failed_message_seq'),
    recipient varchar(255),
    subject varchar(255),
    created timestamp,
    updated timestamp,
    retry_count integer NOT NULL DEFAULT 0,
    status varchar(255),
    mime_message bytea
);

CREATE TABLE IF NOT EXISTS t_ops_connector_sysno_mapping (
    sysno varchar(255) PRIMARY KEY,
    prn varchar(255) NOT NULL UNIQUE,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE IF NOT EXISTS revinfo (
    rev bigint PRIMARY KEY DEFAULT nextval('revinfo_seq'),
    revtstmp bigint NOT NULL
);

ALTER TABLE participant
    ADD CONSTRAINT fk_participant_fee FOREIGN KEY (fee_id) REFERENCES fee(id);

ALTER TABLE customer
    ADD CONSTRAINT fk_customer_participant FOREIGN KEY (participant_id) REFERENCES participant(id),
    ADD CONSTRAINT fk_customer_identification FOREIGN KEY (identification_id) REFERENCES t_customer_identification(id);

ALTER TABLE t_contract_flow
    ADD CONSTRAINT fk_contract_flow_contract FOREIGN KEY (contract_id) REFERENCES t_contract(id),
    ADD CONSTRAINT fk_contract_flow_originator FOREIGN KEY (originator_id) REFERENCES participant(id),
    ADD CONSTRAINT fk_contract_flow_originator_intermediary FOREIGN KEY (originator_intermediary_id) REFERENCES participant(id),
    ADD CONSTRAINT fk_contract_flow_receiver_intermediary FOREIGN KEY (receiver_intermediary_id) REFERENCES participant(id),
    ADD CONSTRAINT fk_contract_flow_receiver FOREIGN KEY (receiver_id) REFERENCES participant(id),
    ADD CONSTRAINT fk_contract_flow_mask_originator_by FOREIGN KEY (mask_originator_by) REFERENCES participant(id),
    ADD CONSTRAINT fk_contract_flow_settlement_participant FOREIGN KEY (settlement_participant_id) REFERENCES participant(id);

ALTER TABLE transfer
    ADD CONSTRAINT fk_transfer_originator FOREIGN KEY (originator_id) REFERENCES customer(id),
    ADD CONSTRAINT fk_transfer_receiver FOREIGN KEY (receiver_id) REFERENCES customer(id),
    ADD CONSTRAINT fk_transfer_conversion_rate_buy FOREIGN KEY (conversion_rate_buy_id) REFERENCES currency_rate(id),
    ADD CONSTRAINT fk_transfer_conversion_rate_sell FOREIGN KEY (conversion_rate_sell_id) REFERENCES currency_rate(id),
    ADD CONSTRAINT fk_transfer_contract_flow FOREIGN KEY (contract_flow_id) REFERENCES t_contract_flow(id);

ALTER TABLE t_transfer_bin
    ADD CONSTRAINT fk_transfer_bin_transfer FOREIGN KEY (transfer_id) REFERENCES transfer(id),
    ADD CONSTRAINT fk_transfer_bin_participant FOREIGN KEY (participant_id) REFERENCES participant(id);

ALTER TABLE t_participant_balance
    ADD CONSTRAINT fk_participant_balance_history FOREIGN KEY (participant_balance_history_id) REFERENCES t_participant_balance_history(id);

ALTER TABLE participant_names
    ADD CONSTRAINT fk_participant_names_participant FOREIGN KEY (participant_id) REFERENCES participant(id);

ALTER TABLE notification_addresses
    ADD CONSTRAINT fk_notification_addresses_participant FOREIGN KEY (participant_id) REFERENCES participant(id);

ALTER TABLE t_notification_event
    ADD CONSTRAINT fk_notification_event_participant FOREIGN KEY (participant_id) REFERENCES participant(id);

ALTER TABLE consolidated_entry
    ADD CONSTRAINT fk_consolidated_entry_participant FOREIGN KEY (participant_id) REFERENCES participant(id),
    ADD CONSTRAINT fk_consolidated_entry_contract_flow FOREIGN KEY (contract_flow_id) REFERENCES t_contract_flow(id);

ALTER TABLE t_rds_selector
    ADD CONSTRAINT fk_rds_selector_currency_pair FOREIGN KEY (currency_pair_id) REFERENCES t_currency_pair(id);

CREATE INDEX IF NOT EXISTS idx_participant_property_participant_name_enabled
    ON t_participant_property (participant_id, prop_name, enabled);
CREATE INDEX IF NOT EXISTS idx_transfer_contract_flow_id ON transfer (contract_flow_id);
CREATE INDEX IF NOT EXISTS idx_transfer_originator_id ON transfer (originator_id);
CREATE INDEX IF NOT EXISTS idx_transfer_receiver_id ON transfer (receiver_id);
CREATE INDEX IF NOT EXISTS idx_participant_balance_business_key
    ON t_participant_balance (participant_id, settlement_participant_id, currency);
CREATE INDEX IF NOT EXISTS idx_participant_balance_history_business_key
    ON t_participant_balance_history (participant_id, settlement_participant_id, created_at);

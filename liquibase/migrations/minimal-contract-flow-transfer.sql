-- Minimal coherent seed for one sender bank, one receiver bank, one contract flow, and one transfer.
-- IDs use the 9000xx range to avoid collisions with existing test fixtures.

insert into fee (id, fee_amount, start_date, end_date, document_name)
values (900001, 0.002, null, null, 'gp originator fee'),
       (900002, 0.003, null, null, 'gp receiver fee')
on conflict (id) do nothing;

insert into participant (
    id, country, logo, fee_id, upper_fee, account_number, locale, status, currencies, url, inn, agreement_number,
    originator_markup, receiver_markup, receiver_fee, minimum_balance, online_balance, intermediary_code,
    external_id, intermediary_for, api_version, is_failing_response, is_validate_personal_data,
    identification_type_list, transliterate_mandatory, is_send_originator, is_report_settlement_prefix,
    is_report_intermediaries_prefix, is_validate_response_v3
)
values
    (900001, 'RU', '', 900001, true, '40702810900000000001', 'ru_RU', 'ACTIVE', 'RUB',
     'http://localhost:8193/originator/v3', '7700009001', 'GP-ORIGINATOR-001',
     0.01, 0.01, 0.003, 1000000000, 1000000000, null, 'GP_ORIGINATOR', 'SBP', 'V3',
     false, false, 'PHONE', false, true, true, false, false),
    (900002, 'KG', '', 900002, true, '40702810900000000002', 'ru_RU', 'ACTIVE', 'KGS',
     'http://localhost:8193/receiver/v3', '7700009002', 'GP-RECEIVER-001',
     0.01, 0.01, 0.003, 1000000000, 1000000000, null, 'GP_RECEIVER', 'SBP', 'V3',
     false, false, 'PHONE', false, false, false, false, false)
on conflict (id) do nothing;

insert into participant_names (id, participant_id, locale, participant_name)
values (900001, 900001, 'ru_RU', 'GP Originator Bank'),
       (900002, 900002, 'ru_RU', 'GP Receiver Bank')
on conflict (id) do nothing;

insert into notification_addresses (id, participant_id, type, email, certificate_path)
values (900001, 900001, 'BALANCE', 'originator-gp@example.test', null),
       (900002, 900002, 'BALANCE', 'receiver-gp@example.test', null)
on conflict (id) do nothing;

insert into t_participant_property (id, participant_id, prop_name, prop_value, enabled)
values (900001, 900001, 'feature_gp_seed_originator', 'true', true),
       (900002, 900002, 'feature_gp_seed_receiver', 'true', true)
on conflict (id) do nothing;

insert into t_participant_limit (id, limit_type, val, currency, participant_id)
values (900001, 'MAX_DAILY_TRANSFERS', 1000, 'RUB', 900001),
       (900002, 'MAX_OUTCOME_AMOUNT', 1000000, 'KGS', 900002)
on conflict (id) do nothing;

insert into t_limit_value (id, val)
values ('gp-900001-RUB-DAILY-TRANSFER', 1000),
       ('gp-900002-KGS-OUTCOME-AMOUNT', 1000000)
on conflict (id) do nothing;

insert into t_participant_balance_history (
    id, participant_id, settlement_participant_id, operation_type, transfer_id, amount, currency, time, created_at, comment
)
values (900001, 900001, 900001, 'REPLENISHMENT', null, 1000000, 'RUB', now(), now(), 'Initial GP originator balance'),
       (900002, 900002, 900001, 'REPLENISHMENT', null, 1000000, 'KGS', now(), now(), 'Initial GP receiver balance')
on conflict (id) do nothing;

insert into t_participant_balance (
    id, participant_id, settlement_participant_id, currency, online_balance, minimum_balance,
    participant_balance_history_id, created_at, updated_at
)
values (900001, 900001, 900001, 'RUB', 1000000, 0, 900001, now(), now()),
       (900002, 900002, 900001, 'KGS', 1000000, 0, 900002, now(), now())
on conflict (id) do nothing;

insert into t_customer_identification (id, type, value, hashed_value, cc_masked)
values (900001, 'PHONE', '79009000001', null, false),
       (900002, 'PHONE', '996900000002', null, false)
on conflict (id) do nothing;

insert into t_ci (id, type, value, hashed_value, cc_masked)
values (900001, 'PHONE', '79009000001', null, false),
       (900002, 'PHONE', '996900000002', null, false)
on conflict (id) do nothing;

insert into customer (
    id, participant_id, email, full_name, full_name_lat, display_name, registration_data, account_mask, currencies, identification_id
)
values (900001, 900001, null, 'Ivan Originator', 'Ivan Originator', 'Ivan O.', null, null, 'RUB', 900001),
       (900002, 900002, null, 'Azamat Receiver', 'Azamat Receiver', 'Azamat R.', null, null, 'KGS', 900002)
on conflict (id) do nothing;

insert into t_contract (id, type, number, start_date, end_date, status)
values (900001, 'BASE', 'GP-CONTRACT-001', current_date, null, 'ACTIVE')
on conflict (id) do nothing;

insert into t_currency_pair (id, settlement_currency, requested_currency)
values (900001, 'RUB', 'KGS')
on conflict (id) do nothing;

insert into currency_rate (
    id, currency_code, settlement_currency_code, buy_rate, sell_rate, base_rate, base_rate_source, start_date, end_date
)
values (900001, 'KGS', 'RUB', 1.25, 1.30, 1.28, 'SELF_CALCULATED', now(), null)
on conflict (id) do nothing;

insert into national_bank_exchange_rate (first_currency_code, second_currency_code, rate, rate_date, updated)
values ('KGS', 'RUB', 1.28, current_date, now())
on conflict (first_currency_code, second_currency_code) do nothing;

insert into clearing_bank_rate (
    first_currency_code, second_currency_code, platform_code, bid, offer, last, trading_status, timestamp
)
values ('KGS', 'RUB', 'GP', 1.25, 1.30, 1.28, true, now())
on conflict (first_currency_code, second_currency_code, platform_code) do nothing;

insert into t_currency_rate_history (
    id, participant_id, settlement_participant_id, currency_code, settlement_currency_code, buy_rate, sell_rate,
    base_sell_rate, base_buy_rate, national_rate, base_rate_source, create_date
)
values (900001, 900002, 900001, 'KGS', 'RUB', 1.25, 1.30, 1.30, 1.25, 1.28, 'SELF_CALCULATED', now())
on conflict (id) do nothing;

insert into t_rds_selector (id, sender_id, receiver_id, rate_type, currency_pair_id, rds_id)
values (900001, 900001, 900002, 'BUY', 900001, 900001)
on conflict (id) do nothing;

insert into t_contract_flow (
    id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency,
    originator_markup, platform_markup, receiver_markup, originator_fee, originator_intermediary_fee,
    platform_fee_from_originator, platform_fee_from_receiver, receiver_intermediary_fee, receiver_fee,
    intermediary_fee, originator_interest, platform_interest, receiver_interest, settlement_payer, settlement_fee,
    enabled, need_receiving_amount_rounding, balancing_spread_percentage, settlement_participant_id,
    mask_originator_by, identification_type, receiver_url
)
values (
    900001, 900001, 900001, 900002, 'INCOMING_V1', 'RUB', 'KGS',
    0.01, 0, 0.01, 0, null,
    0.002, 0.003, null, 0.003,
    0.0005, 0.8, 0.2, 0.8, 'ORIGINATOR', 0.005,
    true, false, 50, 900001,
    null, 'PHONE', 'http://localhost:8193/receiver/v3'
)
on conflict (id) do nothing;

insert into transfer (
    id, originator_reference_number, platform_reference_number, originator_id, receiver_id,
    payment_amount_sum, payment_amount_currency, display_fee_amount_sum, display_fee_amount_currency,
    fee_amount_sum, fee_amount_currency, receiver_fee_amount_sum, receiver_fee_amount_currency,
    intermediary_fee_amount_sum, intermediary_fee_amount_currency, settelment_amount_sum, settelment_amount_currency,
    receiving_amount_sum, receiving_amount_currency, precheck_date, check_date, transfer_date, confirmed_date,
    settelment_date, received_date, comment, conversion_rate_buy_id, conversion_rate_sell_id, transfer_state,
    error_code, ext_check_request_id, ext_check_response_id, ext_confirm_request_id, ext_confirm_response_id,
    contract_flow_id, payment_purpose, receiver_bin_country_code, precheck_transfer_id, payment_id
)
values (
    900001, 'gp-orn-900001', 'gp-prn-900001', 900001, 900002,
    1000, 'RUB', 0, 'RUB',
    2, 'RUB', 3, 'RUB',
    0.5, 'RUB', 998, 'RUB',
    1280, 'KGS', now(), now(), now(), now(),
    current_date, now(), 'Minimal GP transfer seed', 900001, 900001, 'CONFIRMED',
    null, 'gp-check-request-900001', 'gp-check-response-900001', 'gp-confirm-request-900001', 'gp-confirm-response-900001',
    900001, 'GP seed transfer', 'KG', null, 'gp-payment-900001'
)
on conflict (id) do nothing;

insert into t_transfer_bin (id, transfer_id, bin, country_code, participant_id, payment_system)
values (900001, 900001, '996900', 'KG', 900002, 'VISA')
on conflict (id) do nothing;

insert into consolidated_entry (
    id, business_day, participant_id, amount, account_number, agreement_number, currency, state, entry_type_id,
    intermediary_type, payment_flow_type, ce_file_id, report_send_data_id, contract_flow_id, amount_nds, amount_without_nds
)
values (900001, current_date, 900001, 1000, '40702810900000000001', 'GP-ORIGINATOR-001', 'RUB', 'NEW', null,
        null, 'INCOMING_V1', null, null, 900001, 0, 1000)
on conflict (id) do nothing;

insert into t_notification_event (
    id, participant_id, type, state, key, attempts, create_date, sent_date, title, body
)
values (900001, 900001, 'BALANCE', 'NEW', 'GP_BALANCE_900001_900001', 0, now(), null,
        'GP balance seed', 'Initial balance event for GP seed data')
on conflict (id) do nothing;

insert into keys (id, participant_id, start_date, path, comment)
values (900001, 900001, now(), '../config/keys/gp-originator.crt', 'GP originator test key'),
       (900002, 900002, now(), '../config/keys/gp-receiver.crt', 'GP receiver test key')
on conflict (id) do nothing;

insert into platform (
    account_number, business_day, platform_interest, settlement_interest, originator_interest, receiver_interest, intermediary_fee
)
values ('40820gpseed0001', current_date, 0.002, 0, 0.8, 0.8, 0.0005)
on conflict (account_number) do nothing;

insert into t_additional_identification_type (name, description)
values ('PHONE', 'Phone number')
on conflict (name) do nothing;

insert into t_sign_valid_cert (id, participant_id, valid_from, valid_to, encoded_content)
values (900001, 900001, now(), now() + interval '1 year', 'gp-originator-certificate'),
       (900002, 900002, now(), now() + interval '1 year', 'gp-receiver-certificate')
on conflict (id) do nothing;

insert into failed_message (id, recipient, subject, created, updated, retry_count, status, mime_message)
values (900001, 'ops-gp@example.test', 'GP seed message', now(), now(), 0, 'NEW', decode('', 'hex'))
on conflict (id) do nothing;

insert into t_ops_connector_sysno_mapping (sysno, prn, created_at, updated_at)
values ('gp-sysno-900001', 'gp-prn-900001', now(), now())
on conflict (sysno) do nothing;

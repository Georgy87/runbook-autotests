-- platform
insert into platform (account_number, business_day, platform_interest, settlement_interest, originator_interest, receiver_interest, intermediary_fee)
values ('40820dummynumber', '2022-07-18 00:00:00', 0.002, 0, 0.2, 0.2, 0.005);

-- old keys
insert into keys (id, participant_id, start_date, path)
select nextval('participant_seq'),
       p.id,
       '2023-07-25 17:09:26.000000',
       '../config/keys/selfsigned-x509.crt'
from participant p;

-- t_participant_limit
insert into T_PARTICIPANT_LIMIT (id,                                  limit_type,            val, currency, participant_id)
values                          (nextval('participant_limit_id_seq'), 'MAX_OUTCOME_AMOUNT',  0,   'RUB',    30004         ),
                                (nextval('participant_limit_id_seq'), 'MAX_DAILY_TRANSFERS', 0,   'RUB',    10010         ),
                                (nextval('participant_limit_id_seq'), 'MAX_MONTHLY_AMOUNT',  0,   'RUB',    10005         ),
                                (nextval('participant_limit_id_seq'), 'MAX_MONTHLY_AMOUNT',  0,   'RUB',    10003         ),
                                (nextval('participant_limit_id_seq'), 'MAX_DAILY_TRANSFERS', 0,   'RUB',    10003         );

-- t_limit_value
insert into t_limit_value (id, val)
values ('10003-1015-20230802-Russian Ruble-QUANTITY', 0);
insert into t_limit_value (id, val)
values ('10003-1015-20230802-Russian Ruble-SUM', 0);

-- t_currency_pair
insert into t_currency_pair (id,  settlement_currency, requested_currency)
values                      (100, 'RUB',               'TRY'             ),
                            (99,  'RUB',               'TJS'             ),
                            (98,  'RUB',               'KGS'             );

-- t_contract_flow_history
insert into t_contract_flow_history (id, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, originator_intermediary_fee, receiver_intermediary_fee, create_date)
values (93, 0.01, 0, 0.01, 0, 0.002, 0.003, 0.0005, 0.8, 0.2, 0.8, null, 0, '2023-07-13 10:41:11.935000');

-- t_rds_selector
insert into t_rds_selector (id,  sender_id, receiver_id, rate_type, currency_pair_id, rds_id)
values                     (98,  10003,     10011,       'BUY',     99,               94    ),
                           (100, 10011,     10003,       'SELL',    99,               94    ),
                           (101, 10003,     10010,       'BUY',     99,               94    ),
                           (102, 10010,     10003,       'SELL',    99,               94    ),
                           (97,  1000054,   1000055,     'SELL',    100,              94    ),
                           (99,  10227,     10225,       'SELL',    98,               94    );

-- -- t_bic_length
-- insert into t_bic_length (country_code, bic_length)
-- values                   (TR, 8);
--
--
-- -- t_participant_bic
-- insert into t_participant_bic (id, participant_id, country_code, bic, required_extras)
-- values                        (1, 1000055, KG, 00100099, receiver_first_name);
--

--platform features

--dummy for test
insert into t_participant_property (id,   participant_id, prop_name                               )
values                             (-997, 0,              'feature_dummy_for_test'                ),
                                   (-998, 1,              'feature_dummy_for_test_per_participant')
;

--TODO: ждем когда на проде включится (обоих) и тогда применим
--insert into t_participant_property (id, participant_id, prop_name)
--select nextval('seq_participant_property'),
--       p.id,
--       'feature_disable_confirm_pending_force_200_response_code'
--from participant p;

insert into transfer (id,   originator_reference_number,                                                                      originator_signature, platform_reference_number,                                                                        platform_signature, originator_id, receiver_id, payment_amount_sum, payment_amount_currency, display_fee_amount_sum, display_fee_amount_currency, fee_amount_sum, fee_amount_currency, settelment_amount_sum, settelment_amount_currency, receiving_amount_sum, receiving_amount_currency, check_date, transfer_date, settelment_date, comment, conversion_rate_buy_id, conversion_rate_sell_id, transfer_state,    error_code, receiver_fee_amount_sum, receiver_fee_amount_currency, received_date, intermediary_fee_amount_sum, intermediary_fee_amount_currency, ext_check_request_id, ext_check_response_id,                  ext_confirm_request_id, ext_confirm_response_id, contract_flow_id, payment_purpose, contract_flow_history_id)
values               (-335, 'orn_-335',                                                                                       'qwe',                'prn_-335',                                                                                       'asd',              631,           6633,        658,                'RUB',                   null,                   null,                        0.02,           'RUB',               9.80,                  'RUB',                      12.84,                'KGS',                     now(),      null,          null,            null,    null,                   3830,                    'CHECK_PENDING',   100,        0.03,                    'RUB',                        null,          null,                        null,                             null,                 '7980f8ab-6d4d-4d35-b4ae-d4df3cc2e136', null,                   null,                    58,               null,            null                    ),
                     (-336, 'orn_-336',                                                                                       'qwe',                'prn_-336',                                                                                       'asd',              631,           6633,        658,                'RUB',                   null,                   null,                        0.02,           'RUB',               9.80,                  'RUB',                      12.84,                'KGS',                     now(),      null,          null,            null,    null,                   3830,                    'CONFIRM_PENDING', 100,        0.03,                    'RUB',                        null,          null,                        null,                             null,                 '7980f8ab-6d4d-4d35-b4ae-d4df3cc2e136', null,                   null,                    58,               null,            null                    ),
                     (4105, '100_200_100_0_10009_0_e3624b97-e287-459c-a14a-97e4961a7180841acaa5-245b-43d6-9f18-b4f0c82a79bf', 'qwe',                '100_200_100_0_10009_0_e3624b97-e287-459c-a14a-97e4961a7180841acaa5-245b-43d6-9f18-b4f0c82a79bf', 'asd',              631,           649,         10,                 'RUB',                   null,                   null,                        0.02,           'RUB',               9.80,                  'RUB',                      12.84,                'KGS',                     now(),      null,          null,            null,    null,                   3830,                    'CHECKED',         100,        0.03,                    'RUB',                        null,          null,                        null,                             null,                 '7980f8ab-6d4d-4d35-b4ae-d4df3cc2e136', null,                   null,                    58,               null,            null                    )
;

--platform features

--for debug only for gpb - some cases in ConfirmV3IT will fail with error != 237 that's what we need
--insert into t_participant_property (id, participant_id, prop_name) values (-994, 0, 'feature_gpb_remove_mapping_237_code');

insert into t_receiver_participant_required_extras (id, participant_id, country_code, extra_name,            validation_regex                                                             )
values                                             (1,  1000057,        'CN',         'PAYMENT_MODE',        null                                                                         ),
                                                   (2,  1000057,        'CN',         'TRANSFER_PURPOSE',    null                                                                         ),
                                                   (3,  1000057,        'CN',         'ACCOUNT_TYPE',        null                                                                         ),
                                                   (4,  1000061,        'CN',         'PAYMENT_MODE',        '^(ALIPAY|UNIONPAY|WECHAT|BANKACCOUNT)$'                                     ),
                                                   (5,  1000061,        'CN',         'TRANSFER_PURPOSE',    '^(FAMILY_SUPPORT|EDUCATION|GIFT_AND_DONATION|PERSONAL_TRANSFER|OTHER_FEES)$'),
                                                   (6,  1000061,        'CN',         'ACCOUNT_TYPE',        '^(CARD|WALLET|BANK)$'                                                       ),
                                                   (7,  1000055,        'TR',         'receiver_first_name', null                                                                         );
;

insert into KEYS (ID, PARTICIPANT_ID, START_DATE, PATH)
values (0, 0, now(), '../config/keys/selfsigned-x509.crt');

insert into t_iban_country_parsing_rule(country_code, bank_identifier_length_starting_from_5th_symbol)
values ('TR', 5);

insert into t_receiver_participant_iban_info(id, participant_id, iban_bank_identifier, country_code)
values                                      (1,  10011,          '00061',              'TR'        ),
                                            (2,  1000055,        '00100',              'TR'        ),
                                            (3,  10010,          '00062',              'TR'        );

insert into t_receiver_participant_iban_required_extras(id, participant_iban_extras_id, extra_name,     validation_regex)
values                                                 (1,  1,                          'extraName',    '[a-zA-Z]*'     ),
                                                       (2,  1,                          'extraName2',   '[a-zA-Z]*'     ),
                                                       (3,  2,                          'PAYMENT_MODE', '[a-zA-Z]*'     ),
                                                       (4,  3,                          'extraName',    '[a-zA-Z]*'     ),
                                                       (5,  3,                          'extraName2',   '[a-zA-Z]*'     );

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (6401, 'INCOMING', 'ПЛ-АЛИ-ТА-1-11082022', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30008);
insert into FEE (ID, FEE_AMOUNT, START_DATE, END_DATE)
values (225, 0.001, now(), '2038-11-20 14:00:00.000000');

insert into public.participant (id, country, logo, fee_id, upper_fee, account_number, locale, status, currencies, url, inn, agreement_number, originator_markup, receiver_markup, receiver_fee, minimum_balance, online_balance, intermediary_code, external_id, intermediary_for, api_version, is_failing_response, is_validate_personal_data, transliterate_mandatory, identification_type_list, is_send_originator, is_report_settlement_prefix, is_validate_response_v3, is_report_intermediaries_prefix)
values (1, 'RU', '', 225, false, '', 'ru_RU', 'ACTIVE', 'RUB', 'url7', 304304, '304-111', 0.01, 0.01, 0.003, 1000000000000, 999999199044.83, 'CO', '', null, 'V3', false, false, false, 'PHONE', false, false, false, false);

insert into t_contract_flow
(id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, originator_intermediary_id, receiver_intermediary_id, originator_intermediary_fee, receiver_intermediary_fee, receiver_url, balancing_spread_percentage, settlement_participant_id, mask_originator_by, settlement_model_type, settlement_fee, settlement_payer)
values (-1, 6401, 10011, 10011, 'INCOMING_GAP', 'RUB', 'KGS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.0005, 0.8, 0.2, 0.8, true, null, null, null, null, 'url1', 50, 1, null, null, 0.2, 'ORIGINATOR'),
       (-2, 6401, 10010, 10011, 'INCOMING_V1', 'RUB', 'KGS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.0005, 0.8, 0.2, 0.8, true, null, null, null, null, 'url1', 50, 1, null, null, 0.2, 'ORIGINATOR');

insert into PARTICIPANT (ID,      COUNTRY, LOGO, FEE_ID, UPPER_FEE, ACCOUNT_NUMBER,  LOCALE,  STATUS,   CURRENCIES, URL,                                   INN,               AGREEMENT_NUMBER,       ORIGINATOR_MARKUP, RECEIVER_MARKUP, RECEIVER_FEE, MINIMUM_BALANCE, ONLINE_BALANCE,   INTERMEDIARY_CODE, EXTERNAL_ID, INTERMEDIARY_FOR, API_VERSION, IS_FAILING_RESPONSE, IS_VALIDATE_PERSONAL_DATA, IDENTIFICATION_TYPE_LIST, TRANSLITERATE_MANDATORY, is_validate_response_v3)
values                  (525,       'RU',    null, 28,     false,     '1',             'en_US', 'ACTIVE', 'RUB',      'http://localhost:8193/api/payments/qr/v1/check',          '7726467260',      'ПЛ-ДУШ-ТА-060921',     0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        null,             'V1',        false,               false,                     'PHONE,QR',                  false,                   false                  );

insert into T_CONTRACT_FLOW(id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, balancing_spread_percentage, settlement_participant_id, mask_originator_by, identification_type)
values (147, 14, 525, 525, 'INCOMING_V1', 'RUB', 'KGS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 50, 10011, null, 'PHONE_QR');


insert into t_payment(ID, PLATFORM_REFERENCE_NUMBER, CREATED_AT, UPDATED_AT, STATE, ORIGINATOR_PARTICIPANT_ID, RECEIVER_PARTICIPANT_ID, QR_DATA, CHECK_DATE, CONFIRM_DATE)
values (-1, 'a9ce69fc-c2a8-4870-b077-28116c4a6942108a0915-6e9a-41a7-8b7b-ab176bddcfa1', '2025-09-15', '2025-09-15', 'CHECKED', 525, 525, 'testQr', '2025-09-15', '2025-09-15');

-- old key
insert into KEYS (ID, PARTICIPANT_ID, START_DATE, PATH)
values (-1,  525,        now(),      '../config/keys/selfsigned-x509.crt');

-- Добавляем запись с participantId не используемым в переводах, к нему привязан приложенный сертификат для верификации
-- Ключ для "виртуального" participant (тот, кто хранит кастомный сертификат)
insert into keys (id, participant_id, start_date, path)
values (
           nextval('participant_seq'),
           999222333,
           now(),
           '../config/keys/update-balance_cert.crt'
       );

insert into T_CONTRACT_FLOW(id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, balancing_spread_percentage, settlement_participant_id, mask_originator_by, identification_type)
values (9999,       14,          1000023,       103250,      'INCOMING_GAP',    'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'CARD'       );

-- баланс для участника-получателя(агрегатора) с неуникальным ИНН
insert into t_participant_balance (id, participant_id, settlement_participant_id, online_balance, minimum_balance, currency, participant_balance_history_id, created_at, updated_at)
values (nextval('seq_participant_balance'), 103250, 10011, 1000.00, 0, 'KGS', null, now(), null);
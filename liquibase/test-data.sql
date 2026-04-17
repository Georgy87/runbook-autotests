-- fee
insert into FEE (id,   fee_amount, start_date, end_date, document_name)
values          (136,  0.002,      null,       null,     null         ),
                (121,  0.002,      null,       null,     null         ),
                (130,  0.002,      null,       null,     null         ),
                (1125, 0.002,      null,       null,     null         ),
                (116,  0.002,      '2020-06-23 10:11:40.607',
                                               null,     null         ),
                (119,  null,       '2020-06-23 10:17:25.839',
                                               null,     null         ),
                (1194, 0,          null,       null,     null         ),
                (129,  0.002,      null,       null,     null         ),
                (1212, 0.002,      null,       null,     null         ),
                (185,  0.002,      null,       null,     null         ),
                (58,   0.002,      null,       null,     null         ),
                (28,   0.002,      null,       null,     null         );

-- participant
insert into PARTICIPANT (ID,      COUNTRY, LOGO, FEE_ID, UPPER_FEE, ACCOUNT_NUMBER,  LOCALE,  STATUS,   CURRENCIES, URL,                                   INN,               AGREEMENT_NUMBER,       ORIGINATOR_MARKUP, RECEIVER_MARKUP, RECEIVER_FEE, MINIMUM_BALANCE, ONLINE_BALANCE,   INTERMEDIARY_CODE, EXTERNAL_ID, INTERMEDIARY_FOR, API_VERSION, IS_FAILING_RESPONSE, IS_VALIDATE_PERSONAL_DATA, IDENTIFICATION_TYPE_LIST, TRANSLITERATE_MANDATORY, is_validate_response_v3)
values                  (0,       'RU',    null, 28,     false,     '1',             'en_US', 'ACTIVE', 'RUB',      'https://109.74.70.51:8441/',          '7726467260',      'ПЛ-ДУШ-ТА-060921',     0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (101,     'RU',    null, 136,    false,     '0000000000000', 'ru_RU', 'ACTIVE', 'RUB',      'https://fakehost.nbu.uz:8443',        '9909057314',      'ПЛ-АЛИ-ТА-1-11082021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       '',               'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10003,   'TJ',    '',   121,    false,     '',              'ru_RU', 'ACTIVE', 'TJS',      'https://fakehost.tj/gate/tinkoff/',   '29909057314',     'ПЛ-УНИ-УЗ-1-06082021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       '',               'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10005,   'TJ',    '',   130,    false,     '',              'ru_RU', 'ACTIVE', 'TJS',      'https://fakehost.tj:4444/tinkoff/',   '19909057314',     'ПЛ-УНИ-УЗ-1-06082021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       '',               'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (228,     'RU',    '',   1125,   true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v3',            '1589634258',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       'SBP',            'V3',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10011,   'RU',    '',   1125,   true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v3',            '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       'SBP',            'V3',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10006,   'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://127.0.0.1:8086/ops/',          '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               true,                      'PHONE',                  false,                   false                  ),
                        (10009,   'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'KGS',      'http://localhost:8193/v3',            '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               true,                      'PHONE',                  false,                   false                  ),
                        (10029,   'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://127.0.0.1:8086/ops/',          '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1.1,             2.2,              null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10007,   'KG',    '',   116,    false,     '',              'ru_RU', 'ACTIVE', 'KZT',      'http://fakehost:1111/some/path1',     '77101406791245',  null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       '',               'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10010,   'RU',    '',   119,    true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v1',            '011111111111111', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       '',               'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10036,   'KG',    '',   1194,   false,     '',              'ru_RU', 'ACTIVE', 'KGS',      'http://localhost:8193/v1',            '9109057314',      'ПЛ-УНИ-УЗ-1-06082021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       '',               'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10008,   'KZ',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'KZT',      'http://fakehost:4545/some/path3',     '11111111111111',  null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       '',               'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30001,   'AM',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'AMD',      'http://fakehost:4545/some/path3',     '111111111111112', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30002,   'AZ',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'AZN',      'http://fakehost:4545/some/path3',     '111111111111113', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30003,   'KG',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'KGS',      'http://fakehost:4545/some/path3',     '111111111111114', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30004,   'KG',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'KGS',      'http://fakehost:4545/some/path3',     '111111111111115', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30005,   'RU',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'RUB',      'http://fakehost:4545/some/path3',     '111111111111116', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30006,   'TJ',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'TJS',      'http://fakehost:4545/some/path3',     '111111111111117', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30007,   'UZ',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'UZS',      'http://fakehost:4545/some/path3',     '111111111111118', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (30008,   'BY',    '',   129,    false,     '',              'ru_RU', 'ACTIVE', 'BYN',      'http://fakehost:4545/some/path3',     '111111111111119', null,                   0.01,              0.01,            0.003,        1000000000000,   1000000000000,    '',                12345,       null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10025,   'KG',    '',   28,     false,     '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v2',            '9909412625',      'ПЛ-УНИ-УЗ-1-06082025', 0.01,              0.01,            0.003,        1000000000000,   1000000000981.83, null,              null,        null,             'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10225,   'KG',    '',   28,     false,     '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v2',            '9909412625',      'ПЛ-УНИ-УЗ-1-06082025', 0.01,              0.01,            0.003,        1000000000000,   1000000000981.83, null,              null,        null,             'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10325,   'KG',    '',   28,     false,     '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v3',            '9909412625',      'ПЛ-УНИ-УЗ-1-06082025', 0.01,              0.01,            0.003,        1000000000000,   1000000000981.83, null,              null,        null,             'V3',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (103250,  'KG',    '',   28,     false,     '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v3',            '9909412625',      'ПЛ-УНИ-УЗ-1-06082025', 0.01,              0.01,            0.003,        1000000000000,   1000000000981.83, null,              null,        null,             'V3',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10425,   'KG',    '',   28,     false,     '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v2',            '9909412625',      'ПЛ-УНИ-УЗ-1-06082025', 0.01,              0.01,            0.003,        1000000000000,   1000000000981.83, null,              null,        null,             'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10525,   'KG',    '',   28,     false,     '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v2',            '9909412625',      'ПЛ-УНИ-УЗ-1-06082025', 0.01,              0.01,            0.003,        1000000000000,   1000000000981.83, null,              null,        null,             'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10026,   'TJ',    '',   28,     false,     '',              'ru_RU', 'ACTIVE', 'TJS',      'https://hp-xmlgate-test.humo.tj/v1/', '9909412640',      'ПЛ-УНИ-УЗ-1-06082021', 0.01,              0.01,            0.003,        1000000000000,   1000000000981.83, null,              null,        null,             'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (1000011, 'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://127.0.0.1:8086/ops/',          '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10227,   'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://127.0.0.1:8086/ops/',          '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10327,   'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v2',            '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10427,   'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v2',            '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (10527,   'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v2',            '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1000000000000,   1000000000000,    null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (1000021, 'RU',    '',   null,   true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v1',            '7700000121',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        null,             'V1',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (1000022, 'RU',    '',   null,   true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v2',            '7700000122',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (1000023, 'RU',    '',   null,   true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'http://localhost:8193/v3',            '7700000123',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               false,                     'PHONE,CARD',             false,                   true                   ),
                        (1000052, 'KG',    '',   null,   true,      '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v2',            '7700000152',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V2',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (1000053, 'KG',    '',   null,   true,      '',              'ky_KG', 'ACTIVE', 'KGS',      'http://localhost:8193/v3',            '7700000153',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               false,                     'PHONE,CARD',             false,                   true                   ),
                        (1000054, 'RU',    '',   null,   true,      '',              'ru_RU', 'ACTIVE', 'KGS',      'http://localhost:8193/v3',            '7700000153',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               false,                     'PHONE,CARD',             false,                   true                   ),
                        (1000055, 'TR',    '',   null,   true,      '',              'tr_TR', 'ACTIVE', 'TRY',      'http://localhost:8193/v3',            '7700000153',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               false,                     'PHONE,CARD',             false,                   true                   ),
                        (1000057, 'CN',    '',   null,   true,      '',              'cn_CN', 'ACTIVE', 'CNY',      'http://localhost:8193/v3',            '7700000153',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               false,                     'PHONE',                  false,                   true                   ),
                        (1000058, 'CN',    '',   null,   true,      '',              'cn_CN', 'ACTIVE', 'CNY',      'http://localhost:8193/v3',            '7700000153',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               false,                     'PHONE',                  false,                   true                   ),
                        (3005001, 'RU',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'RUB',      'https://localhost/v3',                '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1.1,             2.2,              null,              null,        'SBP',            'V3',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (3005002, 'KG',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'KGS',      'https://localhost/v3',                '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1.1,             2.2,              null,              null,        'SBP',            'V3',        false,               false,                     'PHONE',                  false,                   false                  ),
                        (1000061, 'CN',    '',   null,   true,      '',              'ru_RU', 'ACTIVE', 'KGS',      'http://localhost:8193/v3',            '7700000153',      '',                     null,              null,            null,         1000000000000,   1000000000000,    null,              null,        'SBP',            'V3',        false,               false,                     'PHONE',                  true,                    true                   ),
                        (1000056, 'KG',    '',   28,     true,      '',              'ru_RU', 'ACTIVE', 'KGS',      'http://localhost:8193/v3',            '7710140679',      'ПЛ-ФИН-КИ-1-07122021', 0.01,              0.01,            0.003,        1.1,             2.2,              null,              null,        'SBP',            'V3',        false,               false,                     'PHONE',                  false,                   false                  );


-- t_customer_identification
insert into T_CUSTOMER_IDENTIFICATION (id,       type,    "value"               )
values                                (-1000011, 'PHONE', '79708500629'         ),
                                      (-10227,   'PHONE', '79708500624'         ),
                                      (-10327,   'PHONE', '79708500623'         ),
                                      (-10427,   'PHONE', '79708500622'         ),
                                      (-10527,   'PHONE', '79718500622'         ),
                                      (-121,     'PHONE', '999999999121'        ),
                                      (-122,     'PHONE', '999999999122'        ),
                                      (-123,     'PHONE', '999999999123'        ),
                                      (-10025,   'PHONE', '996505240599'        ),
                                      (-10225,   'PHONE', '996505240597'        ),
                                      (-10325,   'PHONE', '996505240596'        ),
                                      (-10425,   'PHONE', '996505240595'        ),
                                      (-10525,   'PHONE', '996505240594'        ),
                                      (-152,     'PHONE', '999999999152'        ),
                                      (-153,     'PHONE', '999999999153'        ),
                                      (-100001,  'PHONE', '79000000000'         ),
                                      (-100002,  'CARD',  '370000000000002'     ),
                                      (-100003,  'CARD',  '370000000000010'     ),
                                      (-100004,  'IBAN',  'KZ563190000012344567');


-- customer
insert into CUSTOMER (ID,  PARTICIPANT_ID, EMAIL, FULL_NAME,             REGISTRATION_DATA, ACCOUNT_MASK, DISPLAY_NAME,          CURRENCIES, IDENTIFICATION_ID, FULL_NAME_LAT)
values               (1,   1000011,        null,  null,                  null,              null,         null,                  null,       -1000011,          null         ),
                     (4,   10227,          null,  null,                  null,              null,         null,                  null,       -10227,            null         ),
                     (121, 1000021,        null,  'Иван Иван Иванович',  null,              null,         'Иван И.',             null,       -121,              null         ),
                     (122, 1000022,        null,  'Иван Иван Иванович',  null,              null,         'Иван И.',             null,       -122,              null         ),
                     (123, 1000023,        null,  'Иван Иван Иванович',  null,              null,         'Иван И.',             null,       -123,              null         ),
                     (125, 10025,          null,  'Азамат Жанузак уулу', null,              null,         'Азамат Ж.',           null,       -10025,            null         ),
                     (126, 1000054,        null,  'Азамат Жанузак уулу', null,              null,         'Азамат Ж.',           null,       -10025,            null         ),
                     (127, 1000055,        null,  'Азамат Жанузак уулу', null,              null,         'Азамат Ж.',           null,       -10025,            null         ),
                     (152, 1000052,        null,  'Азамат Жанузак уулу', null,              null,         'Азамат Ж.',           null,       -152,              null         ),
                     (153, 1000053,        null,  'Азамат Жанузак уулу', null,              null,         'Азамат Ж.',           null,       -153,              null         ),
                     (631, 1000011,        null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (632, 10005,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (633, 10006,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (634, 10009,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (648, 10025,          null,  null,                  null,              null,         'Тохир Мансурович Д.', 'TJS',      -100002,           null         ),
                     (649, 10025,          null,  null,                  null,              null,         'Тохир Мансурович Д.', 'TJS',      -100001,           null         ),
                     (650, 10025,          null,  null,                  null,              null,         'Тохир Мансурович Д.', 'TJS',      -100004,           null         ),
                     (652, 10026,          null,  null,                  null,              null,         'Тохир Мансурович Д.', 'TJS',      -100003,           null         ),
                     (651, 10026,          null,  null,                  null,              null,         'Тохир Мансурович Д.', 'TJS',      -100004,           null         ),
                     (653, 10011,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (654, 30003,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (655, 3005001,        null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (656, 3005002,        null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (657, 10327,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (658, 10325,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (659, 10225,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (660, 10010,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (661, 10036,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (662, 10425,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (663, 10427,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         ),
                     (664, 10527,          null,  'Магомед С.',          null,              null,         'Магомед С.',          null,       -100001,           null         );
alter sequence customer_seq restart with 1000;
--SELECT setval('customer_seq', (select MAX(id) from customer), true);

--region contracts
insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (111, 'INCOMING', 'ПЛ-АЛИ-ТА-1-11082022', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30008);
insert into t_contract_participant (contract_id, participant_id)
values (111, 30008);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (1, 'INCOMING', 'ПЛ-АЛИ-ТА-1-11082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 101);
insert into t_contract_participant (contract_id, participant_id)
values (1, 101);
insert into t_contract_participant (contract_id, participant_id)
values (1, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (1, 1, 10011, 101, 'INCOMING_V1', 'RUB', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (2, 1, 101, 10011, 'OUTCOMING_V1', 'RUB', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (2, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 10003);
insert into t_contract_participant (contract_id, participant_id)
values (2, 10003);
insert into t_contract_participant (contract_id, participant_id)
values (2, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (3, 2, 10011, 10003, 'INCOMING_V1', 'RUB', 'TJS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (4, 2, 10003, 10011, 'OUTCOMING_V1', 'TJS', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (3, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 10005);
insert into t_contract_participant (contract_id, participant_id)
values (3, 10005);
insert into t_contract_participant (contract_id, participant_id)
values (3, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (5, 3, 10011, 10005, 'INCOMING_V1', 'RUB', 'TJS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (6, 3, 10005, 10011, 'OUTCOMING_V1', 'TJS', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (4, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 10007);
insert into t_contract_participant (contract_id, participant_id)
values (4, 10007);
insert into t_contract_participant (contract_id, participant_id)
values (4, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (7, 4, 10011, 10007, 'INCOMING_V1', 'RUB', 'KZT', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (8, 4, 10007, 10011, 'OUTCOMING_V1', 'KZT', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (5, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 10010);
insert into t_contract_participant (contract_id, participant_id)
values (5, 10010);
insert into t_contract_participant (contract_id, participant_id)
values (5, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (9, 5, 10011, 10010, 'INCOMING_V1', 'RUB', 'UZS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (10, 5, 10010, 10011, 'OUTCOMING_V1', 'UZS', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (6, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 10036);
insert into t_contract_participant (contract_id, participant_id)
values (6, 10036);
insert into t_contract_participant (contract_id, participant_id)
values (6, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (11, 6, 10011, 10036, 'INCOMING_V1', 'RUB', 'KGS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (12, 6, 10036, 10011, 'OUTCOMING_V1', 'KGS', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (7, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 10008);
insert into t_contract_participant (contract_id, participant_id)
values (7, 10008);
insert into t_contract_participant (contract_id, participant_id)
values (7, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (13, 7, 10011, 10008, 'INCOMING_V1', 'RUB', 'KZT', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (14, 7, 10008, 10011, 'OUTCOMING_V1', 'KZT', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (8, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30001);
insert into t_contract_participant (contract_id, participant_id)
values (8, 30001);
insert into t_contract_participant (contract_id, participant_id)
values (8, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (15, 8, 10011, 30001, 'INCOMING_V1', 'RUB', 'AMD', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (16, 8, 30001, 10011, 'OUTCOMING_V1', 'AMD', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (9, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30002);
insert into t_contract_participant (contract_id, participant_id)
values (9, 30002);
insert into t_contract_participant (contract_id, participant_id)
values (9, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (17, 9, 10011, 30002, 'INCOMING_V1', 'RUB', 'AZN', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (18, 9, 30002, 10011, 'OUTCOMING_V1', 'AZN', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (10, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30003);
insert into t_contract_participant (contract_id, participant_id)
values (10, 30003);
insert into t_contract_participant (contract_id, participant_id)
values (10, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (20, 10, 30003, 10011, 'OUTCOMING_V1', 'KGS', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (11, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30004);
insert into t_contract_participant (contract_id, participant_id)
values (11, 30004);
insert into t_contract_participant (contract_id, participant_id)
values (11, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (21, 11, 10011, 30004, 'INCOMING_V1', 'RUB', 'KGS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (22, 11, 30004, 10011, 'OUTCOMING_V1', 'KGS', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (12, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30005);
insert into t_contract_participant (contract_id, participant_id)
values (12, 30005);
insert into t_contract_participant (contract_id, participant_id)
values (12, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (23, 12, 10011, 30005, 'INCOMING_V1', 'RUB', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (24, 12, 30005, 10011, 'OUTCOMING_V1', 'RUB', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (13, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 30006);
insert into t_contract_participant (contract_id, participant_id)
values (13, 30006);
insert into t_contract_participant (contract_id, participant_id)
values (13, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (25, 13, 10011, 30006, 'INCOMING_V1', 'RUB', 'TJS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (26, 13, 30006, 10011, 'OUTCOMING_V1', 'TJS', 'RUB', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract (id, type, number, start_date, end_date, status, participant_id)
values (14, 'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null, 'ACTIVE', 1000011);
insert into t_contract_participant (contract_id, participant_id)
values (14, 30007);
insert into t_contract_participant (contract_id, participant_id)
values (14, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (27, 14, 10011, 30007, 'INCOMING_V1', 'RUB', 'UZS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);
insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, settlement_participant_id)
values (28, 14, 30007, 10011, 'INCOMING_V1', 'RUB', 'KGS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.005, 0.2, 0.002, 0.8, true, 10011);

insert into t_contract_flow (id, contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, originator_intermediary_id, receiver_intermediary_id, originator_intermediary_fee, receiver_intermediary_fee, receiver_url, balancing_spread_percentage, settlement_model_type, settlement_participant_id, mask_originator_by, settlement_fee, settlement_payer, platform_fee_from_receiver, identification_type)
values (-123153001, 14, 1000023, 1000053, 'INCOMING_V1', 'RUB', 'KGS', 0.01, 0, 0.01, 0, 0.002, 0.003, 0.0005, 0.8, 0.2, 0.8, true, null, null, null, 0, null, 50, null, 1000023, null, 0.005, 'ORIGINATOR', 0.003, 'CARD');

insert into t_customer_identification (id,      type,   value,              hashed_value,                                   cc_masked)
values                                (-111100, 'CARD', '411111******1111', '3e7DPsKS9U2UoQLkjL7ye6kaY4ZOJK3iWjNvhZvB2Ek=', true     ),
                                      (-112900, 'CARD', '411111******1129', 'm5dQ/jc7QB3wlFgqy6HsVcig9FhKD4B1YbaBZbjMkqY=', true     );

insert into customer (id,    participant_id, email,         full_name,             registration_data, account_mask, display_name, currencies, identification_id, full_name_lat     )
values               (-1023, 1000023,        null,          null,                  null,              null,         null,         null,       -111100,           null              ),
                     (-1053, 1000053,        null,          'Ашот Уллу Кыйял',     null,              null,         'Ашот К.',    null,       -112900,           'Ashot Ullu Kiyal'),
                     (6633,  103250,         '79000000456', 'Махмуд Ахмедович У.', null,              null,         'Махмуд У.',  'TJS',      -112900,           'Azamat Suvorov'  );

-- currency_rate
insert into currency_rate (id, currency_code, settlement_currency_code, buy_rate, sell_rate, start_date, end_date, base_rate, base_rate_source)
values (3830, 'KGS', 'RUB', null, 1.2836, null, null, 1.3098, 'SELF_CALCULATED');

-- t_contract
insert into T_CONTRACT (ID,  TYPE,        NUMBER,   START_DATE, END_DATE,                     STATUS  )
values                 (101, 'INCOMING',  'ABC-11', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (102, 'OUTCOMING', 'ABC-12', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (103, 'SBPIN',     'ABC-13', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (104, 'SBPOUT',    'ABC-14', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (105, 'RUBIN',     'ABC-15', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (106, 'RUBOUT',    'ABC-16', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (107, 'EXCLIN',    'ABC-17', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (108, 'SMEIN',     'ABC-18', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE'),
                       (109, 'SMEOUT',    'ABC-19', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE');

-- t_contract_participant
insert into T_CONTRACT_PARTICIPANT (CONTRACT_ID, PARTICIPANT_ID)
values                             (101,         1000021       ),
                                   (101,         1000022       ),
                                   (101,         1000023       ),
                                   (101,         10025         ),
                                   (101,         1000052       ),
                                   (101,         1000053       );

-- t_contract_flow
insert into T_CONTRACT_FLOW (ID,     CONTRACT_ID, ORIGINATOR_ID, RECEIVER_ID, PAYMENT_FLOW_TYPE, ORIGINATOR_CURRENCY, RECEIVER_CURRENCY, ORIGINATOR_MARKUP, PLATFORM_MARKUP, RECEIVER_MARKUP, ORIGINATOR_FEE, platform_fee_from_originator, RECEIVER_FEE, INTERMEDIARY_FEE, ORIGINATOR_INTEREST, PLATFORM_INTEREST, RECEIVER_INTEREST, ENABLED, ORIGINATOR_INTERMEDIARY_ID, RECEIVER_INTERMEDIARY_ID, ORIGINATOR_INTERMEDIARY_FEE, RECEIVER_INTERMEDIARY_FEE, RECEIVER_URL, BALANCING_SPREAD_PERCENTAGE, SETTLEMENT_MODEL_TYPE, SETTLEMENT_PARTICIPANT_ID, MASK_ORIGINATOR_BY, IDENTIFICATION_TYPE)
values                      (121125, 101,         1000021,       10025,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000021,                   null,               'PHONE'            ),
                            (121153, 101,         1000021,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000021,                   null,               'PHONE'            ),
                            (121154, 101,         1000021,       1000052,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000021,                   null,               'PHONE'            ),
                            (122125, 101,         1000022,       10025,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000022,                   null,               'PHONE'            ),
                            (122153, 101,         1000022,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000022,                   null,               'PHONE'            ),
                            (122154, 101,         1000022,       1000052,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000022,                   null,               'PHONE'            ),
                            (123125, 101,         1000023,       10025,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000023,                   null,               'PHONE'            ),
                            (123152, 101,         1000023,       1000052,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000023,                   null,               'PHONE'            ),
                            (123153, 101,         1000023,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000023,                   10011,              'PHONE'            ),
                            (123155, 101,         1000023,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         50,                          null,                  1000023,                   null,               'CARD'             ),
                            (123156, 101,         1000023,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         50,                          null,                  1000023,                   null,               'CARD_PHONE'       ),
                            (123157, 101,         1000023,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         50,                          null,                  1000023,                   null,               'PHONE_CARD'       ),
                            (123158, 101,         1000023,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         50,                          null,                  1000023,                   null,               'IBAN_PHONE'       ),
                            (123159, 101,         1000023,       1000053,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         50,                          null,                  1000023,                   null,               'PHONE_IBAN'       ),
                            (123161, 101,         1000061,       10009,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         50,                          null,                  1000023,                   null,               'PHONE'            ),
                            (123154, 101,         1000053,       1000023,     'OUTCOMING_V1',    'KGS',               'RUB',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000023,                   null,               'PHONE'            ),
                            (123160, 101,         1000023,       1000056,     'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.0005,           0.8,                 0.2,               0.8,               true,    null,                       null,                     null,                        0,                         null,         null,                        null,                  1000023,                   null,               'PHONE'            );

insert into T_CONTRACT_FLOW(id,       contract_id, originator_id, receiver_id, payment_flow_type, originator_currency, receiver_currency, originator_markup, platform_markup, receiver_markup, originator_fee, platform_fee_from_originator, receiver_fee, intermediary_fee, originator_interest, platform_interest, receiver_interest, enabled, balancing_spread_percentage, settlement_participant_id, mask_originator_by, identification_type)
values                     (58,       14,          1000011,       10025,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (59,       14,          10005,         10003,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (60,       14,          10010,         10036,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (61,       14,          30004,         10036,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (62,       14,          10005,         10010,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (63,       14,          10005,         10036,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (64,       14,          10003,         10036,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (65,       111,         10011,         30008,       'INCOMING_V1',     'RUB',               'BYN',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (66,       14,          10006,         10009,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (68,       14,          10029,         10025,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (67,       14,          1000011,       10009,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (69,       14,          10011,         30003,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (70,       14,          10227,         10225,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (71,       14,          10327,         10325,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (72,       14,          1000011,       10325,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (720,      14,          1000011,       103250,      'INCOMING_GAP',    'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (721,      14,          1000011,       103250,      'INCOMING_GAP',    'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE_IBAN'       ),
                           (73,       14,          10427,         10425,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     10011,              'PHONE'            ),
                           (74,       14,          10527,         10525,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (75,       14,          10527,         10009,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (76,       14,          1000021,       10009,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (77,       14,          1000023,       10009,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (78,       14,          228,           10011,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (791,      14,          1000023,       10325,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (79,       14,          1000023,       103250,      'INCOMING_GAP',    'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE_CARD'       ),
                           (80,       14,          10527,         10525,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'CARD_PHONE'       ),
                           (81,       14,          10227,         10225,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'CARD_PHONE'       ),
                           (82,       14,          10527,         10525,       'INCOMING_V1',     'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE_CARD'       ),
                           (83,       14,          1000054,       1000055,     'INCOMING_GAP',    'RUB',               'TRY',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE_IBAN'       ),
                           (84,       14,          1000054,       1000057,     'INCOMING_GAP',    'RUB',               'CNY',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (85,       14,          1000054,       1000058,     'INCOMING_GAP',    'RUB',               'CNY',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (12345678, 14,          3005001,       3005002,     'INCOMING_SME',    'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (218,      14,          3005001,       3005002,     'INCOMING_V1_ONE_2_ONE',    'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            );
                           (12345678, 14,          3005001,       3005002,     'INCOMING_SME',    'RUB',               'KGS',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'            ),
                           (86,       14,          1000054,       1000055,     'INCOMING_V1',     'RUB',               'TRY',             0.01,              0,               0.01,            0,              0.002,                        0.003,        0.005,            0.2,                 0.002,             0.8,               true,    50,                          10011,                     null,               'PHONE'       );

--endregion

-- platform
insert into platform (account_number, business_day, platform_interest, settlement_interest, originator_interest, receiver_interest, intermediary_fee)
values ('40820dummynumber', '2022-07-18 00:00:00', 0.002, 0, 0.2, 0.2, 0.005);

--region national_bank_exchange_rate
insert into national_bank_exchange_rate (first_currency_code, second_currency_code, rate,       rate_date,    updated                     )
values                                  ('KZT',               'EUR',                455.41,     '2022-06-02', '2022-06-01 15:00:12.126626'),
                                        ('KZT',               'INR',                5.48,       '2022-06-02', '2022-06-01 15:00:12.126906'),
                                        ('KZT',               'IRR',                10.1,       '2022-06-02', '2022-06-01 15:00:12.127377'),
                                        ('KZT',               'CAD',                335.93,     '2022-06-02', '2022-06-01 15:00:12.128034'),
                                        ('KZT',               'CNY',                63.52,      '2022-06-02', '2022-06-01 15:00:12.128476'),
                                        ('KZT',               'KWD',                1387.51,    '2022-06-02', '2022-06-01 15:00:12.128926'),
                                        ('KZT',               'KGS',                5.25,       '2022-06-02', '2022-06-01 15:00:12.129204'),
                                        ('KZT',               'XDR',                573.11,     '2022-06-02', '2022-06-01 15:00:12.133044'),
                                        ('KZT',               'SGD',                309.6,      '2022-06-02', '2022-06-01 15:00:12.133493'),
                                        ('KZT',               'TJS',                37.41,      '2022-06-02', '2022-06-01 15:00:12.133987'),
                                        ('KZT',               'THB',                12.37,      '2022-06-02', '2022-06-01 15:00:12.134504'),
                                        ('KZT',               'TRY',                25.82,      '2022-06-02', '2022-06-01 15:00:12.134992'),
                                        ('KZT',               'UZS',                3.87,       '2022-06-02', '2022-06-01 15:00:12.135442'),
                                        ('KZT',               'UAH',                14.39,      '2022-06-02', '2022-06-01 15:00:12.135889'),
                                        ('KZT',               'GBP',                534.51,     '2022-06-02', '2022-06-01 15:00:12.136799'),
                                        ('KZT',               'CZK',                18.41,      '2022-06-02', '2022-06-01 15:00:12.137603'),
                                        ('KZT',               'SEK',                43.45,      '2022-06-02', '2022-06-01 15:00:12.138151'),
                                        ('KZT',               'CHF',                441.71,     '2022-06-02', '2022-06-01 15:00:12.138642'),
                                        ('KZT',               'ZAR',                27.35,      '2022-06-02', '2022-06-01 15:00:12.139163'),
                                        ('KZT',               'KRW',                34.14,      '2022-06-02', '2022-06-01 15:00:12.13988' ),
                                        ('KZT',               'JPY',                3.28,       '2022-06-02', '2022-06-01 15:00:12.140512'),
                                        ('KZT',               'MYR',                96.92,      '2022-06-02', '2022-06-01 15:00:12.129761'),
                                        ('KZT',               'MXN',                21.57,      '2022-06-02', '2022-06-01 15:00:12.130296'),
                                        ('KZT',               'MDL',                22.47,      '2022-06-02', '2022-06-01 15:00:12.130827'),
                                        ('KZT',               'NOK',                45.3,       '2022-06-02', '2022-06-01 15:00:12.131279'),
                                        ('KZT',               'PLN',                99.16,      '2022-06-02', '2022-06-01 15:00:12.131769'),
                                        ('KZT',               'SAR',                113.22,     '2022-06-02', '2022-06-01 15:00:12.132261'),
                                        ('KZT',               'RUB',                6.94,       '2022-06-02', '2022-06-01 15:00:12.13277' ),
                                        ('KZT',               'AMD',                9.58,       '2022-06-02', '2022-06-01 15:00:12.122284'),
                                        ('KZT',               'BYN',                128.09,     '2022-06-02', '2022-06-01 15:00:12.122769'),
                                        ('KZT',               'BRL',                89.75,      '2022-06-02', '2022-06-01 15:00:12.123235'),
                                        ('KZT',               'HUF',                11.5,       '2022-06-02', '2022-06-01 15:00:12.123738'),
                                        ('KZT',               'HKD',                54.12,      '2022-06-02', '2022-06-01 15:00:12.124235'),
                                        ('KZT',               'GEL',                142.01,     '2022-06-02', '2022-06-01 15:00:12.124718'),
                                        ('KGS',               'RUB',                1.2684,     '2022-06-02', '2022-06-01 15:00:02.598411'),
                                        ('KZT',               'DKK',                61.23,      '2022-06-02', '2022-06-01 15:00:12.125177'),
                                        ('KZT',               'AUD',                305.47,     '2022-06-02', '2022-06-01 15:00:12.120504'),
                                        ('KZT',               'AZN',                250.81,     '2022-06-02', '2022-06-01 15:00:12.121754'),
                                        ('KZT',               'AED',                115.62,     '2022-06-02', '2022-06-01 15:00:12.125641'),
                                        ('KZT',               'USD',                424.62,     '2022-06-02', '2022-06-01 15:00:12.126166'),
                                        ('KGS',               'USD',                79.5477,    '2022-06-02', '2022-06-01 15:00:02.596359'),
                                        ('KGS',               'EUR',                85.2552,    '2022-06-02', '2022-06-01 15:00:02.597556'),
                                        ('KGS',               'KZT',                0.1873,     '2022-06-02', '2022-06-01 15:00:02.59785' ),
                                        ('TJS',               'UZS',                0.001038,   '2022-06-01', '2022-06-01 15:00:01.978411'),
                                        ('TJS',               'KGS',                0.13986,    '2022-06-01', '2022-06-01 15:00:01.978859'),
                                        ('TJS',               'KZT',                0.02749,    '2022-06-01', '2022-06-01 15:00:01.979346'),
                                        ('TJS',               'BYN',                3.4432,     '2022-06-01', '2022-06-01 15:00:01.97991' ),
                                        ('TJS',               'IRR',                0.0002714,  '2022-06-01', '2022-06-01 15:00:01.980184'),
                                        ('TJS',               'AFN',                0.12795,    '2022-06-01', '2022-06-01 15:00:01.980667'),
                                        ('TJS',               'PKR',                0.05743,    '2022-06-01', '2022-06-01 15:00:01.981118'),
                                        ('TJS',               'TRY',                0.6948,     '2022-06-01', '2022-06-01 15:00:01.981595'),
                                        ('TJS',               'TMT',                3.2571,     '2022-06-01', '2022-06-01 15:00:01.982064'),
                                        ('UZS',               'LYD',                2302.18,    '2022-06-01', '2022-06-01 15:00:12.947746'),
                                        ('UZS',               'MAD',                1112.74,    '2022-06-01', '2022-06-01 15:00:12.948275'),
                                        ('UZS',               'MDL',                576.83,     '2022-06-01', '2022-06-01 15:00:12.948861'),
                                        ('UZS',               'MMK',                5.93,       '2022-06-01', '2022-06-01 15:00:12.949316'),
                                        ('UZS',               'MNT',                3.52,       '2022-06-01', '2022-06-01 15:00:12.949797'),
                                        ('UZS',               'MXN',                560.70,     '2022-06-01', '2022-06-01 15:00:12.950299'),
                                        ('UZS',               'MYR',                2509.03,    '2022-06-01', '2022-06-01 15:00:12.950766'),
                                        ('TJS',               'INR',                0.14671,    '2022-06-01', '2022-06-01 15:00:01.990359'),
                                        ('TJS',               'PLN',                2.6621,     '2022-06-01', '2022-06-01 15:00:01.990872'),
                                        ('TJS',               'MYR',                2.6027,     '2022-06-01', '2022-06-01 15:00:01.991147'),
                                        ('TJS',               'THB',                0.3322,     '2022-06-01', '2022-06-01 15:00:01.9916'  ),
                                        ('AZN',               'GEL',                0.5629,     '2022-06-01', '2022-06-01 15:00:03.49416' ),
                                        ('AZN',               'HKD',                0.2167,     '2022-06-01', '2022-06-01 15:00:03.494607'),
                                        ('AZN',               'INR',                0.0219,     '2022-06-01', '2022-06-01 15:00:03.495102'),
                                        ('AZN',               'GBP',                2.1391,     '2022-06-01', '2022-06-01 15:00:03.495573'),
                                        ('AZN',               'IDR',                0.000117,   '2022-06-01', '2022-06-01 15:00:03.49588' ),
                                        ('AZN',               'IRR',                0.00004,    '2022-06-01', '2022-06-01 15:00:03.496333'),
                                        ('AZN',               'SEK',                0.1737,     '2022-06-01', '2022-06-01 15:00:03.496775'),
                                        ('AMD',               'USD',                445.6400,   '2022-06-01', '2022-06-01 15:00:00.6918'  ),
                                        ('AMD',               'GBP',                560.9300,   '2022-06-01', '2022-06-01 15:00:00.694184'),
                                        ('AMD',               'AUD',                320.5000,   '2022-06-01', '2022-06-01 15:00:00.694861'),
                                        ('AMD',               'EUR',                477.5900,   '2022-06-01', '2022-06-01 15:00:00.69537' ),
                                        ('AMD',               'XDR',                601.4800,   '2022-06-01', '2022-06-01 15:00:00.696012'),
                                        ('AMD',               'IRR',                0.0106,     '2022-06-01', '2022-06-01 15:00:00.696963'),
                                        ('AMD',               'PLN',                103.9800,   '2022-06-01', '2022-06-01 15:00:00.697438'),
                                        ('AMD',               'CAD',                352.4800,   '2022-06-01', '2022-06-01 15:00:00.69791' ),
                                        ('AMD',               'INR',                5.7500,     '2022-06-01', '2022-06-01 15:00:00.698362'),
                                        ('AMD',               'NOK',                47.5100,    '2022-06-01', '2022-06-01 15:00:00.698839'),
                                        ('AMD',               'JPY',                3.4430,     '2022-06-01', '2022-06-01 15:00:00.69931' ),
                                        ('AMD',               'SEK',                45.5900,    '2022-06-01', '2022-06-01 15:00:00.699761'),
                                        ('AMD',               'RUB',                7.2700,     '2022-06-01', '2022-06-01 15:00:00.703435'),
                                        ('AMD',               'XAU',                26344.2600, '2022-06-01', '2022-06-01 15:00:00.706311'),
                                        ('AMD',               'XAG',                311.9100,   '2022-06-01', '2022-06-01 15:00:00.706688'),
                                        ('AMD',               'NZD',                289.8900,   '2022-06-01', '2022-06-01 15:00:00.707072'),
                                        ('TJS',               'UAH',                0.3859,     '2022-06-01', '2022-06-01 15:00:01.988936'),
                                        ('TJS',               'AED',                3.1033,     '2022-06-01', '2022-06-01 15:00:01.989397'),
                                        ('TJS',               'SAR',                3.0394,     '2022-06-01', '2022-06-01 15:00:01.989882'),
                                        ('AZN',               'DKK',                0.2448,     '2022-06-01', '2022-06-01 15:00:03.493666'),
                                        ('AZN',               'CHF',                1.768,      '2022-06-01', '2022-06-01 15:00:03.497259'),
                                        ('AZN',               'ILS',                0.5123,     '2022-06-01', '2022-06-01 15:00:03.49771' ),
                                        ('AZN',               'CAD',                1.3422,     '2022-06-01', '2022-06-01 15:00:03.498219'),
                                        ('AZN',               'KWD',                5.5546,     '2022-06-01', '2022-06-01 15:00:03.498724'),
                                        ('AZN',               'KZT',                0.004,      '2022-06-01', '2022-06-01 15:00:03.499173'),
                                        ('AZN',               'KGS',                0.0207,     '2022-06-01', '2022-06-01 15:00:03.499647'),
                                        ('AZN',               'LBP',                0.001126,   '2022-06-01', '2022-06-01 15:00:03.500251'),
                                        ('AZN',               'MYR',                0.3874,     '2022-06-01', '2022-06-01 15:00:03.500724'),
                                        ('AZN',               'MXN',                0.0864,     '2022-06-01', '2022-06-01 15:00:03.501168'),
                                        ('AZN',               'MDL',                0.0893,     '2022-06-01', '2022-06-01 15:00:03.50165' ),
                                        ('AZN',               'EGP',                0.0915,     '2022-06-01', '2022-06-01 15:00:03.502127'),
                                        ('AZN',               'NOK',                0.1809,     '2022-06-01', '2022-06-01 15:00:03.502612'),
                                        ('AZN',               'UZS',                0.000154,   '2022-06-01', '2022-06-01 15:00:03.503231'),
                                        ('AZN',               'PLN',                0.3973,     '2022-06-01', '2022-06-01 15:00:03.503925'),
                                        ('AZN',               'RUB',                0.0272,     '2022-06-01', '2022-06-01 15:00:03.50439' ),
                                        ('AZN',               'SGD',                1.2375,     '2022-06-01', '2022-06-01 15:00:03.504895'),
                                        ('AZN',               'SAR',                0.4533,     '2022-06-01', '2022-06-01 15:00:03.5054'  ),
                                        ('AZN',               'TRY',                0.1037,     '2022-06-01', '2022-06-01 15:00:03.505699'),
                                        ('AZN',               'TWD',                0.0583,     '2022-06-01', '2022-06-01 15:00:03.506391'),
                                        ('AZN',               'TJS',                0.1449,     '2022-06-01', '2022-06-01 15:00:03.506852'),
                                        ('AZN',               'TMT',                0.4857,     '2022-06-01', '2022-06-01 15:00:03.507348'),
                                        ('AZN',               'UAH',                0.0575,     '2022-06-01', '2022-06-01 15:00:03.507876'),
                                        ('AZN',               'JPY',                0.013154,   '2022-06-01', '2022-06-01 15:00:03.508503'),
                                        ('AZN',               'NZD',                1.1035,     '2022-06-01', '2022-06-01 15:00:03.509155'),
                                        ('UZS',               'AED',                2990.88,    '2022-06-01', '2022-06-01 15:00:12.916531'),
                                        ('UZS',               'AFN',                123.44,     '2022-06-01', '2022-06-01 15:00:12.917133'),
                                        ('UZS',               'AMD',                24.08,      '2022-06-01', '2022-06-01 15:00:12.91742' ),
                                        ('UZS',               'ARS',                91.54,      '2022-06-01', '2022-06-01 15:00:12.917731'),
                                        ('UZS',               'AUD',                7891.09,    '2022-06-01', '2022-06-01 15:00:12.918169'),
                                        ('UZS',               'AZN',                6466.03,    '2022-06-01', '2022-06-01 15:00:12.919879'),
                                        ('UZS',               'BDT',                123.33,     '2022-06-01', '2022-06-01 15:00:12.920168'),
                                        ('UZS',               'BGN',                6022.91,    '2022-06-01', '2022-06-01 15:00:12.92047' ),
                                        ('UZS',               'BHD',                29140.03,   '2022-06-01', '2022-06-01 15:00:12.920739'),
                                        ('UZS',               'BND',                8015.90,    '2022-06-01', '2022-06-01 15:00:12.921018'),
                                        ('UZS',               'BRL',                2310.90,    '2022-06-01', '2022-06-01 15:00:12.921399'),
                                        ('UZS',               'BYN',                3252.54,    '2022-06-01', '2022-06-01 15:00:12.921682'),
                                        ('UZS',               'CAD',                8663.19,    '2022-06-01', '2022-06-01 15:00:12.921949'),
                                        ('UZS',               'CHF',                11443.53,   '2022-06-01', '2022-06-01 15:00:12.922247'),
                                        ('UZS',               'CNY',                1649.64,    '2022-06-01', '2022-06-01 15:00:12.922549'),
                                        ('UZS',               'CUP',                457.74,     '2022-06-01', '2022-06-01 15:00:12.922818'),
                                        ('UZS',               'CZK',                476.50,     '2022-06-01', '2022-06-01 15:00:12.923098'),
                                        ('UZS',               'DKK',                1583.38,    '2022-06-01', '2022-06-01 15:00:12.923382'),
                                        ('UZS',               'DZD',                75.44,      '2022-06-01', '2022-06-01 15:00:12.923915'),
                                        ('UZS',               'EGP',                591.27,     '2022-06-01', '2022-06-01 15:00:12.924198'),
                                        ('UZS',               'EUR',                11780.06,   '2022-06-01', '2022-06-01 15:00:12.924509'),
                                        ('UZS',               'GBP',                13843.19,   '2022-06-01', '2022-06-01 15:00:12.927884'),
                                        ('UZS',               'GEL',                3601.90,    '2022-06-01', '2022-06-01 15:00:12.928167'),
                                        ('UZS',               'HKD',                1399.91,    '2022-06-01', '2022-06-01 15:00:12.939731'),
                                        ('UZS',               'HUF',                29.84,      '2022-06-01', '2022-06-01 15:00:12.940075'),
                                        ('AZN',               'XPD',                3420.9695,  '2022-06-01', '2022-06-01 15:00:03.485592'),
                                        ('AZN',               'XPT',                1648.3965,  '2022-06-01', '2022-06-01 15:00:03.486918'),
                                        ('AZN',               'XAG',                36.5245,    '2022-06-01', '2022-06-01 15:00:03.487366'),
                                        ('AZN',               'XAU',                3115.7175,  '2022-06-01', '2022-06-01 15:00:03.487854'),
                                        ('AZN',               'USD',                1.7,        '2022-06-01', '2022-06-01 15:00:03.488351'),
                                        ('AZN',               'EUR',                1.8213,     '2022-06-01', '2022-06-01 15:00:03.488803'),
                                        ('AZN',               'AUD',                1.2186,     '2022-06-01', '2022-06-01 15:00:03.489242'),
                                        ('AZN',               'ARS',                0.0141,     '2022-06-01', '2022-06-01 15:00:03.489705'),
                                        ('AZN',               'BYN',                0.6186,     '2022-06-01', '2022-06-01 15:00:03.490188'),
                                        ('AZN',               'BRL',                0.359,      '2022-06-01', '2022-06-01 15:00:03.490626'),
                                        ('AZN',               'AED',                0.4628,     '2022-06-01', '2022-06-01 15:00:03.491073'),
                                        ('AZN',               'ZAR',                0.1085,     '2022-06-01', '2022-06-01 15:00:03.491579'),
                                        ('AZN',               'KRW',                0.001364,   '2022-06-01', '2022-06-01 15:00:03.491987'),
                                        ('AZN',               'CZK',                0.0737,     '2022-06-01', '2022-06-01 15:00:03.492429'),
                                        ('AZN',               'CLP',                0.002064,   '2022-06-01', '2022-06-01 15:00:03.492879'),
                                        ('AZN',               'CNY',                0.2539,     '2022-06-01', '2022-06-01 15:00:03.493384'),
                                        ('UZS',               'ILS',                3287.09,    '2022-06-01', '2022-06-01 15:00:12.940647'),
                                        ('UZS',               'INR',                141.51,     '2022-06-01', '2022-06-01 15:00:12.94096' ),
                                        ('UZS',               'IQD',                7.53,       '2022-06-01', '2022-06-01 15:00:12.941267'),
                                        ('UZS',               'IRR',                0.262,      '2022-06-01', '2022-06-01 15:00:12.941532'),
                                        ('UZS',               'ISK',                86.42,      '2022-06-01', '2022-06-01 15:00:12.941814'),
                                        ('UZS',               'JOD',                15494.77,   '2022-06-01', '2022-06-01 15:00:12.942133'),
                                        ('UZS',               'JPY',                85.86,      '2022-06-01', '2022-06-01 15:00:12.942407'),
                                        ('UZS',               'NOK',                1164.74,    '2022-06-01', '2022-06-01 15:00:12.954088'),
                                        ('UZS',               'KHR',                2.70,       '2022-06-01', '2022-06-01 15:00:12.943323'),
                                        ('UZS',               'KRW',                8.87,       '2022-06-01', '2022-06-01 15:00:12.943779'),
                                        ('UZS',               'KWD',                35901.27,   '2022-06-01', '2022-06-01 15:00:12.944688'),
                                        ('UZS',               'KZT',                25.80,      '2022-06-01', '2022-06-01 15:00:12.945608'),
                                        ('UZS',               'LAK',                0.82,       '2022-06-01', '2022-06-01 15:00:12.946109'),
                                        ('UZS',               'LBP',                7.26,       '2022-06-01', '2022-06-01 15:00:12.94659' ),
                                        ('UZS',               'VND',                0.474,      '2022-06-01', '2022-06-01 15:00:12.970125'),
                                        ('UZS',               'XDR',                14821.49,   '2022-06-01', '2022-06-01 15:00:12.970401'),
                                        ('UZS',               'YER',                43.91,      '2022-06-01', '2022-06-01 15:00:12.970856'),
                                        ('UZS',               'IDR',                0.753,      '2022-06-01', '2022-06-01 15:00:12.940362'),
                                        ('UZS',               'ZAR',                705.38,     '2022-06-01', '2022-06-01 15:00:12.973158'),
                                        ('AMD',               'CHF',                463.1000,   '2022-06-01', '2022-06-01 15:00:00.700219'),
                                        ('AMD',               'CZK',                19.2900,    '2022-06-01', '2022-06-01 15:00:00.70068' ),
                                        ('AMD',               'CNY',                66.8600,    '2022-06-01', '2022-06-01 15:00:00.70107' ),
                                        ('AMD',               'SGD',                324.6200,   '2022-06-01', '2022-06-01 15:00:00.701457'),
                                        ('AMD',               'BRL',                94.1400,    '2022-06-01', '2022-06-01 15:00:00.701865'),
                                        ('AMD',               'AED',                121.3300,   '2022-06-01', '2022-06-01 15:00:00.702303'),
                                        ('AMD',               'KGS',                5.4200,     '2022-06-01', '2022-06-01 15:00:00.702686'),
                                        ('AMD',               'KZT',                1.0370,     '2022-06-01', '2022-06-01 15:00:00.703056'),
                                        ('AMD',               'UAH',                15.0300,    '2022-06-01', '2022-06-01 15:00:00.703841'),
                                        ('AMD',               'UZS',                0.0410,     '2022-06-01', '2022-06-01 15:00:00.704246'),
                                        ('AMD',               'BYN',                172.9600,   '2022-06-01', '2022-06-01 15:00:00.704557'),
                                        ('AMD',               'TJS',                37.9800,    '2022-06-01', '2022-06-01 15:00:00.704916'),
                                        ('AMD',               'GEL',                147.0800,   '2022-06-01', '2022-06-01 15:00:00.705429'),
                                        ('AMD',               'HKD',                56.7900,    '2022-06-01', '2022-06-01 15:00:00.705941'),
                                        ('UZS',               'KGS',                135.96,     '2022-06-01', '2022-06-01 15:00:12.942852'),
                                        ('UZS',               'NZD',                7157.24,    '2022-06-01', '2022-06-01 15:00:12.95459' ),
                                        ('UZS',               'OMR',                28534.52,   '2022-06-01', '2022-06-01 15:00:12.955275'),
                                        ('UZS',               'PHP',                209.33,     '2022-06-01', '2022-06-01 15:00:12.955559'),
                                        ('UZS',               'PKR',                55.38,      '2022-06-01', '2022-06-01 15:00:12.956096'),
                                        ('UZS',               'PLN',                2570.32,    '2022-06-01', '2022-06-01 15:00:12.956551'),
                                        ('UZS',               'QAR',                3008.40,    '2022-06-01', '2022-06-01 15:00:12.957019'),
                                        ('UZS',               'RON',                2383.34,    '2022-06-01', '2022-06-01 15:00:12.9575'  ),
                                        ('UZS',               'RSD',                100.26,     '2022-06-01', '2022-06-01 15:00:12.957802'),
                                        ('UZS',               'RUB',                179.43,     '2022-06-01', '2022-06-01 15:00:12.9583'  ),
                                        ('UZS',               'SAR',                2929.00,    '2022-06-01', '2022-06-01 15:00:12.958771'),
                                        ('UZS',               'SDG',                24.59,      '2022-06-01', '2022-06-01 15:00:12.960064'),
                                        ('UZS',               'SEK',                1120.37,    '2022-06-01', '2022-06-01 15:00:12.960558'),
                                        ('UZS',               'SGD',                8015.90,    '2022-06-01', '2022-06-01 15:00:12.961024'),
                                        ('UZS',               'SYP',                4.37,       '2022-06-01', '2022-06-01 15:00:12.965188'),
                                        ('TJS',               'GBP',                14.3537,    '2022-06-01', '2022-06-01 15:00:01.982581'),
                                        ('TJS',               'AUD',                8.1852,     '2022-06-01', '2022-06-01 15:00:01.982905'),
                                        ('TJS',               'DKK',                1.6416,     '2022-06-01', '2022-06-01 15:00:01.9834'  ),
                                        ('TJS',               'ISK',                0.08949,    '2022-06-01', '2022-06-01 15:00:01.983878'),
                                        ('TJS',               'CAD',                9.0012,     '2022-06-01', '2022-06-01 15:00:01.984364'),
                                        ('TJS',               'KWD',                37.2257,    '2022-06-01', '2022-06-01 15:00:01.98482' ),
                                        ('TJS',               'NOK',                1.2102,     '2022-06-01', '2022-06-01 15:00:01.985353'),
                                        ('TJS',               'SGD',                8.3145,     '2022-06-01', '2022-06-01 15:00:01.985625'),
                                        ('TJS',               'SEK',                1.1626,     '2022-06-01', '2022-06-01 15:00:01.986095'),
                                        ('UZS',               'THB',                321.08,     '2022-06-01', '2022-06-01 15:00:12.965649'),
                                        ('UZS',               'TJS',                965.78,     '2022-06-01', '2022-06-01 15:00:12.966159'),
                                        ('UZS',               'TMT',                3143.29,    '2022-06-01', '2022-06-01 15:00:12.966618'),
                                        ('UZS',               'TND',                3630.47,    '2022-06-01', '2022-06-01 15:00:12.967075'),
                                        ('UZS',               'TRY',                668.81,     '2022-06-01', '2022-06-01 15:00:12.967696'),
                                        ('UZS',               'UAH',                371.85,     '2022-06-01', '2022-06-01 15:00:12.968026'),
                                        ('UZS',               'USD',                10985.79,   '2022-06-01', '2022-06-01 15:00:12.968719'),
                                        ('UZS',               'UYU',                275.33,     '2022-06-01', '2022-06-01 15:00:12.969206'),
                                        ('TJS',               'JPY',                0.08894,    '2022-06-01', '2022-06-01 15:00:01.986545'),
                                        ('TJS',               'AZN',                6.7059,     '2022-06-01', '2022-06-01 15:00:01.986984'),
                                        ('TJS',               'AMD',                0.025447,   '2022-06-01', '2022-06-01 15:00:01.987496'),
                                        ('TJS',               'GEL',                3.8584,     '2022-06-01', '2022-06-01 15:00:01.987875'),
                                        ('TJS',               'MDL',                0.5978,     '2022-06-01', '2022-06-01 15:00:01.988446'),
                                        ('UZS',               'VES',                2170.89,    '2022-06-01', '2022-06-01 15:00:12.96965' ),
                                        ('TJS',               'USD',                11.4000,    '2022-06-01', '2022-06-01 15:00:01.975204'),
                                        ('TJS',               'EUR',                12.2151,    '2022-06-01', '2022-06-01 15:00:01.976451'),
                                        ('TJS',               'CNY',                1.7095,     '2022-06-01', '2022-06-01 15:00:01.977027'),
                                        ('TJS',               'CHF',                11.8762,    '2022-06-01', '2022-06-01 15:00:01.977659'),
                                        ('TJS',               'RUB',                0.1750,     '2022-06-01', '2022-06-01 15:00:01.977958'),
                                        ('CNY',               'RUB',                0.1750,     '2022-06-01', '2022-06-01 15:00:01.977958'),
                                        ('BYN',               'RUB',                0.033946,   '2022-06-01', '2022-06-01 15:00:01.977958');
--endregion

--region clearing_bank_rate
insert into clearing_bank_rate (first_currency_code, second_currency_code, bid,     offer,   last,    trading_status, timestamp,                 platform_code)
values                         ('USD',               'RUB',                61.3222, 61.3222, 61.3222, true,           '2022-06-01 18:30:05',     'Bloomberg'  ),
                               ('USD',               'RUB',                61.3222, 61.3222, 61.3222, true,           '2022-06-01 18:30:05',     'Elektron'   ),
                               ('USD',               'RUB',                61.3222, 61.3222, 61.3222, true,           '2022-06-01 18:30:05',     'MICEX'      ),
                               ('USD',               'UAH',                29.4,    29.4,    29.4,    true,           '2022-04-01 12:51:01.391', 'Bloomberg'  ),
                               ('USD',               'UAH',                29.4,    29.4,    29.4,    true,           '2022-04-01 12:51:01.391', 'Elektron'   ),
                               ('UAH',               'RUB',                29.4,    29.4,    29.4,    true,           '2022-04-01 12:51:01.391', 'MICEX'      ),
                               ('USD',               'TMT',                3.495,   3.495,   3.495,   false,          '2022-04-26 07:12:48.899', 'Bloomberg'  ),
                               ('USD',               'TMT',                3.495,   3.495,   3.495,   false,          '2022-04-26 07:12:48.899', 'Elektron'   ),
                               ('TMT',               'RUB',                3.495,   3.495,   3.495,   false,          '2022-04-26 07:12:48.899', 'MICEX'      ),
                               ('USD',               'TJS',                11.3395, 11.3395, 11.3395, true,           '2022-04-26 07:12:48.899', 'Bloomberg'  ),
                               ('USD',               'TJS',                11.3395, 11.3395, 11.3395, true,           '2022-04-26 07:12:48.899', 'Elektron'   ),
                               ('TJS',               'RUB',                11.3395, 11.3395, 11.3395, true,           '2022-04-26 07:12:48.899', 'MICEX'      ),
                               ('USD',               'UZS',                10671.0, 10671.0, 10671.0, false,          '2022-04-26 07:12:48.899', 'Bloomberg'  ),
                               ('USD',               'UZS',                10671.0, 10671.0, 10671.0, false,          '2022-04-26 07:12:48.899', 'Elektron'   ),
                               ('UZS',               'RUB',                10671.0, 10671.0, 10671.0, false,          '2022-04-26 07:12:48.899', 'MICEX'      ),
                               ('USD',               'KGS',                84.7772, 84.7772, 84.7772, false,          '2022-04-26 07:12:48.899', 'Bloomberg'  ),
                               ('USD',               'KGS',                84.3132, 84.3132, 84.3132, false,          '2022-04-26 05:12:48.899', 'Elektron'   ),
                               ('KGS',               'RUB',                84.3132, 84.3132, 84.3132, false,          '2022-04-26 05:12:48.899', 'MICEX'      ),
                               ('USD',               'MDL',                17.62,   17.62,   17.62,   true,           '2022-04-26 07:12:48.899', 'Bloomberg'  ),
                               ('USD',               'MDL',                17.62,   17.62,   17.62,   true,           '2022-04-26 07:12:48.899', 'Elektron'   ),
                               ('MDL',               'RUB',                17.62,   17.62,   17.62,   true,           '2022-04-26 07:12:48.899', 'MICEX'      ),
                               ('USD',               'AMD',                456.0,   456.0,   456.0,   true,           '2022-05-31 13:53:09.535', 'Bloomberg'  ),
                               ('USD',               'AMD',                456.0,   456.0,   456.0,   true,           '2022-05-31 13:53:09.535', 'Elektron'   ),
                               ('AMD',               'RUB',                456.0,   456.0,   456.0,   true,           '2022-05-31 13:53:09.535', 'MICEX'      ),
                               ('USD',               'AZN',                1.678,   1.678,   1.678,   true,           '2022-05-31 13:53:09.535', 'Bloomberg'  ),
                               ('USD',               'AZN',                1.678,   1.678,   1.678,   true,           '2022-05-31 13:53:09.535', 'Elektron'   ),
                               ('AZN',               'RUB',                1.678,   1.678,   1.678,   true,           '2022-05-31 13:53:09.535', 'MICEX'      ),
                               ('USD',               'BYN',                2.3456,  2.3456,  2.3456,  true,           '2022-05-31 13:53:09.535', 'Bloomberg'  ),
                               ('USD',               'BYN',                2.3456,  2.3456,  2.3456,  true,           '2022-05-31 13:53:09.535', 'Elektron'   ),
                               ('BYN',               'RUB',                2.3456,  2.3456,  2.3456,  true,           '2022-05-31 13:53:09.535', 'MICEX'      ),
                               ('USD',               'GEL',                3.1234,  3.1234,  3.1234,  true,           '2022-05-31 13:53:09.535', 'Bloomberg'  ),
                               ('USD',               'GEL',                3.1234,  3.1234,  3.1234,  true,           '2022-05-31 13:53:09.535', 'Elektron'   ),
                               ('GEL',               'RUB',                3.1234,  3.1234,  3.1234,  true,           '2022-05-31 13:53:09.535', 'MICEX'      ),
                               ('USD',               'KZT',                402.98,  402.98,  402.98,  true,           '2022-05-31 13:53:09.535', 'Bloomberg'  ),
                               ('USD',               'KZT',                402.98,  402.98,  402.98,  true,           '2022-05-31 13:53:09.535', 'Elektron'   ),
                               ('KZT',               'RUB',                402.98,  402.98,  402.98,  true,           '2022-05-31 13:53:09.535', 'MICEX'      );
--endregion

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
insert into t_rds_selector (id, sender_id, receiver_id, rate_type, currency_pair_id, rds_id)
values                     (98, 10003,     10011,       'BUY',     99,               94    ),
                           (97, 1000054,   1000055,     'SELL',    100,              94    ),
                           (99, 10227,     10225,       'SELL',    98,               94    );

-- -- t_bic_length
-- insert into t_bic_length (country_code, bic_length)
-- values                   (TR, 8);
--
--
-- -- t_participant_bic
-- insert into t_participant_bic (id, participant_id, country_code, bic, required_extras)
-- values                        (1, 1000055, KG, 00100099, receiver_first_name);
--

/*todo: нужно подумать какие из низ раскомментить чтобы и те и те кейсы прогонялись в автотестах
insert into t_participant_balance (id,                                 participant_id, settlement_participant_id, online_balance, minimum_balance, participant_balance_history_id)
values                            (nextval('seq_participant_balance'), 0,              10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 101,            10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10003,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10005,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10006,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10009,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10029,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10007,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10010,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10036,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10008,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30001,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30002,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30003,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30004,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30005,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30006,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30007,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 30008,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10025,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10225,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10325,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10425,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10525,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10026,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000011,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10227,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10327,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10427,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 10527,          10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000021,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000022,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000023,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000052,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000053,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 3005001,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 3005002,        10011,                     1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000023,        1000023,                   1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000021,        1000021,                   1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000053,        1000023,                   1,              1,               null                          ),
                                  (nextval('seq_participant_balance'), 1000022,        1000022,                   1,              1,               null                          );*/

--platform features

--dummy for test
insert into t_participant_property (id, participant_id, prop_name)
values (-997, 0, 'feature_dummy_for_test');
insert into t_participant_property (id, participant_id, prop_name)
values (-998, 1, 'feature_dummy_for_test_per_participant');

insert into transfer (id,   originator_reference_number,                                                                      originator_signature, platform_reference_number,                                                                        platform_signature, originator_id, receiver_id, payment_amount_sum, payment_amount_currency, display_fee_amount_sum, display_fee_amount_currency, fee_amount_sum, fee_amount_currency, settelment_amount_sum, settelment_amount_currency, receiving_amount_sum, receiving_amount_currency, check_date, transfer_date, settelment_date, comment, conversion_rate_buy_id, conversion_rate_sell_id, transfer_state,    error_code, receiver_fee_amount_sum, receiver_fee_amount_currency, received_date, intermediary_fee_amount_sum, intermediary_fee_amount_currency, ext_check_request_id, ext_check_response_id,                  ext_confirm_request_id, ext_confirm_response_id, contract_flow_id, payment_purpose, contract_flow_history_id)
values               (-335, 'orn_-335',                                                                                       'qwe',                'prn_-335',                                                                                       'asd',              631,           6633,        658,                'RUB',                   null,                   null,                        0.02,           'RUB',               9.80,                  'RUB',                      12.84,                'KGS',                     now(),      null,          null,            null,    null,                   3830,                    'CHECK_PENDING',   100,        0.03,                    'RUB',                        null,          null,                        null,                             null,                 '7980f8ab-6d4d-4d35-b4ae-d4df3cc2e136', null,                   null,                    58,               null,            null                    ),
                     (-336, 'orn_-336',                                                                                       'qwe',                'prn_-336',                                                                                       'asd',              631,           6633,        658,                'RUB',                   null,                   null,                        0.02,           'RUB',               9.80,                  'RUB',                      12.84,                'KGS',                     now(),      null,          null,            null,    null,                   3830,                    'CONFIRM_PENDING', 100,        0.03,                    'RUB',                        null,          null,                        null,                             null,                 '7980f8ab-6d4d-4d35-b4ae-d4df3cc2e136', null,                   null,                    58,               null,            null                    ),
                     (4105, '100_200_100_0_10009_0_e3624b97-e287-459c-a14a-97e4961a7180841acaa5-245b-43d6-9f18-b4f0c82a79bf', 'qwe',                '100_200_100_0_10009_0_e3624b97-e287-459c-a14a-97e4961a7180841acaa5-245b-43d6-9f18-b4f0c82a79bf', 'asd',              631,           649,         10,                 'RUB',                   null,                   null,                        0.02,           'RUB',               9.80,                  'RUB',                      12.84,                'KGS',                     now(),      null,          null,            null,    null,                   3830,                    'CHECKED',         100,        0.03,                    'RUB',                        null,          null,                        null,                             null,                 '7980f8ab-6d4d-4d35-b4ae-d4df3cc2e136', null,                   null,                    58,               null,            null                    ),
                     (4106, 'd63c82cf-a810-45a8-911d-c292aeb32e87', null, null, null, 6651, 6652, 100, 'RUB', null, null, 0.05, 'RUB', 95.00, 'RUB', 12.84,'KGS', now(), null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null)
;

--platform features

--for debug only for gpb - some cases in ConfirmSenderRequestV3Test will fail with error != 237 that's what we need
--insert into t_participant_property (id, participant_id, prop_name) values (-994, 0, 'feature_gpb_remove_mapping_237_code');

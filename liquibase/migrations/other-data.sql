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
                       (109, 'SMEOUT',    'ABC-19', now(),      '2038-11-20 14:00:00.000000', 'ACTIVE')
;

insert into t_contract (id,  type,       number,                 start_date,                   end_date, status,   participant_id)
values                 (14,  'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 1000011       ),
                       (111, 'INCOMING', 'ПЛ-АЛИ-ТА-1-11082022', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 30008         ),
                       (1,   'INCOMING', 'ПЛ-АЛИ-ТА-1-11082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 101           ),
                       (2,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 10003         ),
                       (3,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 10005         ),
                       (4,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 10007         ),
                       (5,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 10010         ),
                       (6,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 10036         ),
                       (10,  'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 30003         ),
                       (12,  'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 30005         ),
                       (13,  'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 30006         ),
                       (11,  'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 30004         ),
                       (9,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 30002         ),
                       (8,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 30001         ),
                       (7,   'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 10008         ),
                       (60,  'INCOMING', 'ПЛ-УНИ-УЗ-1-06082021', '2022-11-17 17:34:04.088063', null,     'ACTIVE', 10111         )
;

insert into t_contract_participant (contract_id, participant_id)
values                             (2,           10003         ),
                                   (2,           10011         ),
                                   (14,          30007         ),
                                   (14,          10011         ),
                                   (3,           10005         ),
                                   (3,           10011         ),
                                   (4,           10007         ),
                                   (4,           10011         ),
                                   (5,           10010         ),
                                   (5,           10011         ),
                                   (6,           10036         ),
                                   (6,           10011         ),
                                   (7,           10008         ),
                                   (7,           10011         ),
                                   (8,           30001         ),
                                   (8,           10011         ),
                                   (9,           30002         ),
                                   (9,           10011         ),
                                   (10,          30003         ),
                                   (10,          10011         ),
                                   (12,          30005         ),
                                   (12,          10011         ),
                                   (13,          30006         ),
                                   (13,          10011         ),
                                   (11,          30004         ),
                                   (11,          10011         ),
                                   (101,         1000021       ),
                                   (101,         1000022       ),
                                   (101,         1000023       ),
                                   (101,         10025         ),
                                   (101,         1000052       ),
                                   (101,         1000053       )
;


alter sequence customer_seq restart with 1000;
--SELECT setval('customer_seq', (select MAX(id) from customer), true);

--region contracts


insert into customer (id,     participant_id, email,         full_name,             registration_data, account_mask, display_name, currencies, identification_id, full_name_lat     )
values               (-1023,  1000023,        null,          null,                  null,              null,         null,         null,       -111100,           null              ),
                     (-10234, 1000023,        null,          null,                  null,              null,         null,         null,       -111101,           null              ),
                     (-1053,  1000053,        null,          'Ашот Уллу Кыйял',     null,              null,         'Ашот К.',    null,       -112900,           'Ashot Ullu Kiyal'),
                     (-10534, 1000053,        null,          'Ашот Уллу Кыйял',     null,              null,         'Ашот К.',    null,       -112901,           'Ashot Ullu Kiyal'),
                     (6633,   103250,         '79000000456', 'Махмуд Ахмедович У.', null,              null,         'Махмуд У.',  'TJS',      -112900,           'Azamat Suvorov'  ),
                     (6651,   10011,         '79112223344', 'Виктор Черномырдин.', null,              null,         'Виктор Ч.',  'TJS',      -112900,           'Victor Chernomyrdin'),
                     (6652,   10006,         '79115556677', 'Кирилл Бойцов', null,              null,         'Кирилл Б.',  'TJS',      -112900,           'Kirill Boytsov')
;

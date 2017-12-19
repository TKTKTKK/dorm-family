-- 初次培训项目code
update tb_common_code  set codetype='TRAIN_PROGRAM_FIRST' where uuid in ('2017120900000004','2017120900000005','2017120900000006','2017120900000007','2017120900000008');

-- 现场培训项目
INSERT INTO tb_common_code VALUES ('2017121900000001', null, null, 'TRAIN_PROGRAM_SCENE', 'USER_ATTENTION', '使用的注意事项', null,'', '1', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');
INSERT INTO tb_common_code VALUES ('2017121900000002', null, null, 'TRAIN_PROGRAM_SCENE', 'USER_SEPARATION', '何时使用离合分离', null,'', '2', '2014-11-30 21:44:31', 'sys', '2014-11-30 21:44:31', 'sys', '1', '0');

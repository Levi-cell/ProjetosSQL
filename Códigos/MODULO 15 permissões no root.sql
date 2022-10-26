SELECT * FROM mysql.user;

USE SGPM;

CREATE USER 'felippe'@'localhost' IDENTIFIED BY '123456'; #cria usuario felipe

GRANT SELECT ON sgpm.* TO 'felippe'@'localhost'; #permissão para felipe consultar o banco sgpm

CREATE ROLE 'engenharia'@'localhost'; # cria o papel chamado engenharia 
GRANT SELECT, INSERT ON *.* TO 'engenharia'@'localhost'; #permissão para o usuario poder consultar e inserir em qualque banco de dados do root
GRANT 'engenharia'@'localhost' TO 'felippe'@'localhost'; # associar o papel para felipe 

SET GLOBAL activate_all_roles_on_login = TRUE;

#############plano de acesso######

CREATE USER  'lucas' identified BY '123456'; 
CREATE USER 'sgpm_interface' identified BY '123456';

CREATE ROLE 'consulta';
CREATE ROLE 'operação';

GRANT SELECT ON sgpm.* TO 'consulta';
GRANT SELECT,ALTER, INSERT ON sgpm.* TO 'operação';

GRANT 'consulta' TO 'lucas';
GRANT "operaçâo" to "sgpm_interface"
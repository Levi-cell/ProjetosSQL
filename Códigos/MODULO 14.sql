#CONTROLE DE EXECUÇÃO
use sakila;
USE SGPM;
SET autocommit = 0;

INSERT INTO sgpm.departamentos (nome, cidade_escritorio) VALUES ("Analytics", "Belo Horizonte");

SELECT * FROM departamentos;

Commit;
#########################
SET autocommit = 0;

INSERT INTO sgpm.departamentos (nome, cidade_escritorio) VALUES ("Business Analytics", "Recife");

ROLLBACK;

SELECT * FROM departamentos;

#VÁRIAVEISSS#####

SET @id_pessoa := 10; #váriavel de referência no where

SELECT * FROM sakila.customer 
WHERE customer_id <= @id_pessoa;

#PROCEDIMENTOS ARMAZENADOS
use sakila;
DELIMITER $$

CREATE PROCEDURE retorna_clientes ()
BEGIN

SELECT first_name, last_name
   FROM sakila.customer 
  ORDER BY first_name;

END$$
DELIMITER ;

CALL retorna_clientes;

CALL film_in_stock(30, 1, @viavel_saida);

SELECT @variavel_saida;

SELECT inventory_in_stock(34)
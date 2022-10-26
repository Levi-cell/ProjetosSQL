
##QUESTÃO 1

use bibliotecaria;
DELIMITER $$
CREATE PROCEDURE inserção_autor (c_CPF_a VARCHAR(255), n_nome VARCHAR(255))
BEGIN
	START TRANSACTION;
	INSERT INTO autor (CPF_a, nome) VALUES (c_CPF_a, n_nome);
  
END$$ 
DELIMITER ;
CALL inserção_autor ('324.121.923-73','Joo Paulo');
COMMIT;

##QUESTÃO 2

DELIMITER $$
CREATE PROCEDURE coonsul_autor (IN c_codigo INT, OUT n_nome Varchar(255))
BEGIN
	
	SELECT coonsul_autor
	FROM autor
    WHERE codigo=c_codigo;
  
	
    SELECT COUNT(coonsul_autor)
    FROM autor
    WHERE codigo=c_codigo
    INTO n_nome;

END$$ 
DELIMITER ;	

CALL coonsul_autor(1, @saida);
SELECT @saida;




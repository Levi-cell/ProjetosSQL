###### modulo 15 atividade plano de acesso

#usuarios
CREATE USER 'João'@'localhost' identified by 'raposa_feliz';
CREATE USER 'Pedro'@'localhost' identified by 'lobo_feliz';

#Papeis
CREATE ROLE 'pesquisador'@'localhost';
GRANT SELECT on bibliotecaria.* TO 'pesquisador'@'localhost';

CREATE ROLE 'modificador'@'localhost';
GRANT ALTER, INSERT on bibliotecaria.* TO 'modificador'@'localhost';

#Associando cada papel ao seu respectivo usúario

GRANT 'pesquisador'@'localhost' TO 'João'@'localhost';
GRANT 'modificador'@'localhost' TO 'Pedro'@'localhost';

/*
Dúvida:
qual a diferença entre eu usar o @'localhost' e não usar
exemplo: usar 'pesquisador' ao em vez de 'pesquisador'@'localhost'
ou também para o usúario usar 'João' ao vez de 'João'@'localhost' 
*/
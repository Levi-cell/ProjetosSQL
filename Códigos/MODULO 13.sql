USE SGPM;

INSERT INTO 
departamentos(id_departamento, nome, cidade_escritorio)
VALUES(1, "Marketing", "São Paulo");

INSERT INTO 
departamentos(id_departamento, nome, cidade_escritorio)
VALUES(2, "Vendas", "São Paulo");

INSERT INTO 
departamentos(nome, cidade_escritorio)
VALUES("Suporte", "Rio de Janeiro");

SELECT * FROM departamentos;

use mentorama;

SELECT * FROM cesta_de_frutas;

UPDATE cesta_de_frutas
SET preco_unitario = 0.9 * preco_unitario
WHERE tipo_da_fruta IN ("banana", "maçã");

########################################## AULA 6 EXEMPLO#########################

USE SGPM;

# inserir dados na tabela departamento:

INSERT INTO departamentos (id_departamento,nome, cidade_escritorio)
    VALUES (default, 'Vendas', 'São Paulo'),
           (default, 'Marketing', 'São Paulo'),
           (default, 'Recursos Humanos','São Paulo'),
           (default, 'Tecnologia', 'São Paulo'),
           (default, 'Financeiro', 'São Paulo'),
           (default, 'Sucesso de Clientes', 'São Paulo'),
           (default, 'Gestão', 'São Paulo'),
           (default, 'Vendas','Rio de Janeiro'),
           (default, 'Marketing','Rio de Janeiro'),
           (default, 'Gestão','Rio de Janeiro'),
           (default, 'Qualidade','Rio de Janeiro');

####CRUD:
#1-Create
#2- Read
#3- Update
#4- Delete

/*
##################################################ATIVIDADE##########################
Questão 1
*/

USE bibliotecaria;

#começando a adicionar dados pelas tabelas sem chaves estrangeiras 

#1
INSERT INTO genero (codigo, nome)
    VALUES (NULL, 'Romance'),
		   (NULL, 'Ação'),
           (NULL, 'Literatura'),
           (NULL, 'Terror'),
           (NULL, 'Ficção'),
           (NULL, 'Fantasia'),
           (NULL, 'Internacional'),
           (NULL, 'Teatral'),
           (NULL, 'Virtual'),
           (NULL, 'Encenado');
SELECT * from genero;

#2
INSERT INTO perfil(prazo, limite, nome)
	VALUES ('2022-08-20', 3, 'raposa anônima'),
           ('2022-08-21', 4, 'lobo anônimo'),
           ('2022-08-22', 3, 'ovelha anônima'),
           ('2022-08-23', 2, 'sapo anônimo'),
           ('2022-08-24', 1, 'gatinho anônimo'),
           ('2022-08-25', 5, 'lula anônima'),
           ('2022-08-26', 3, 'cachorro anônimo'),
           ('2022-08-27', 5, 'carangueijo anônimo'),
           ('2022-08-28', 6, 'ratinho anônimo'),
           ('2022-08-29', 2, 'peixe anônimo');
SELECT * FROM perfil;

#3
INSERT INTO autor(CPF_a, nome)
    VALUES ('034.561.963-56', 'Eduardo'),
           ('031.521.983-73', 'Lucas'),
           ('033.531.953-42', 'Pedro'),
           ('835.541.993-36', 'Machadão'),
           ('134.561.963-96', 'Carlinhos'),
           ('734.161.973-56', 'Jorge'),
		   ('324.461.913-46', 'João'),
		   ('344.561.123-26', 'Levi'),
           ('934.561.933-54', 'Anildo'),
           ('167.560.953-76', 'Antônio');
SELECT * from autor;

#4
INSERT INTO editora(registro, nome, cidade)
   VALUES (1, 'etiquets', 'salvador'),
          (2, 'arquivados', 'new york'),
          (3, 'intitulados', 'Paris'),
          (4, 'versales', 'São Paulo'),
          (5, 'albetrs', 'Rio de Janeiro'),
          (6, 'portugol', 'Arkansas'),
          (7, 'javaz', 'Brasília'),
          (8, 'hajax', 'Xangai'),
          (9, 'marcielo', 'Tóqui'),
          (10, 'tatuspresso', 'Quioto');
SELECT * from editora;

#5 aqui começa as tabelas com chave estrangeira 
INSERT INTO livro(isbn, id_genero, id_editora, edicao, valume, valor, titulo)
   VALUES ('178-3-16-148410-0', 1, 1, 24, 3, 24.99, 'narnia'),
          ('278-3-16-148410-0', 2, 2, 23, 5, 25.99, 'Harry porra'),
          ('378-3-36-140410-0', 3, 3, 22, 6, 26.99, 'Senhor dos anais'),
          ('468-3-16-148410-0', 4, 4, 21, 2, 27.99, 'maconha'),
          ('938-3-16-148410-0', 5, 5, 20, 1, 28.99, 'Adam'),
          ('671-3-16-148410-0', 6, 6, 25, 8, 29.99, 'O cubo'),
          ('778-3-16-148410-1', 7, 7, 26, 9, 30.99, 'Mandioca'),
          ('878-3-26-148410-0', 8, 8, 27, 19, 31.99, 'Beiju'),
          ('478-3-16-148410-0', 9, 9, 28, 20, 32.99, 'capitão'),
          ('578-3-16-148410-0', 10, 10, 29, 7, 33.99, 'Ferro');
SELECT * FROM livro
order by id_genero;
 
 #6
 alter table usuario rename column endereco to CEP;
INSERT INTO usuario(CPF, telefone, id_perfil, nome, CEP, email)
   VALUES ('003.000.000-01', '+55 (71)-9.0000-0021', 1, 'Enzo', '00333-551', 'enzo@gmail.com'),
          ('002.000.000-01', '+55 (75)-9.0000-0002', 2, 'Miguel', '00301-621', 'Miguel@gmail.com'),
          ('004.050.000-01', '+55 (76)-9.0000-0003', 3, 'Eduardo', '00330-521', 'Eduardo@gmail.com'),
          ('000.030.000-03', '+55 (77)-9.0000-0031', 4, 'Edmar', '03333-191', 'Edmar@gmail.com'),
          ('000.080.000-02', '+55 (81)-9.0000-0041', 5, 'Edcarlos', '00000-081', 'Edcarlos@gmail.com'),
          ('000.000.001-01', '+55 (11)-9.0000-0501', 6, 'Mário', '00000-061', 'Mário@gmail.com'),
          ('000.000.002-01', '+55 (26)-9.0000-0631', 7, 'Marcos', '00000-051', 'Marcos@gmail.com'),
          ('000.000.004-01', '+55 (36)-9.0000-1231', 8, 'Jociel', '00000-041', 'Jociel@gmail.com'),
          ('000.000.050-01', '+55 (71)-9.0540-0001', 9, 'Maria', '00000-031', 'Maria@gmail.com'),
          ('000.000.070-01', '+55 (71)-9.0340-4041', 10, 'Juiliana', '00000-021', 'Juliana@gmail.com');
SELECT * from usuario order by id_perfil;

#7
INSERT INTO exemplar(isbn_livro, statuss)
   VALUES ('178-3-16-148410-0', 'disponivel'),
          ('278-3-16-148410-0', 'alugado'),
          ('378-3-36-140410-0', 'vendido'),
          ('468-3-16-148410-0', 'vendido'),
          ('938-3-16-148410-0', 'alugado'),
          ('671-3-16-148410-0', 'alugado'),
          ('778-3-16-148410-1', 'alugado'),
          ('878-3-26-148410-0', 'alugado'),
          ('478-3-16-148410-0', 'vendido'),
          ('578-3-16-148410-0', 'disponivel');
SELECT * FROM exemplar;

#8
#modifiquei a tabela emprestimo no outro arquivo para aceitar valores NULL
INSERT INTO emprestimo(id_exemplar, CPF_usuario, data_saida, data_entrega, prazo1)
   VALUES (1, '003.000.000-01', '2022-07-10','2022-07-13', 2),
          (2, '002.000.000-01', '2022-07-12', '2022-08-05', 25),
          (3, '004.050.000-01', '2022-07-14', '0000-00-00', 0),
          (4, '000.030.000-03', '2022-07-14', '0000-00-00', 0),
          (5, '000.080.000-02', '2022-07-26', '2022-08-06', 15),
          (6, '000.000.001-01', '2022-07-27', '2022-08-07', 15),
          (7, '000.000.002-01', '2022-07-28', '2022-08-08', 15),
          (8, '000.000.004-01', '2022-07-29', '2022-08-09', 15),
          (9, '000.000.050-01', '2022-07-29', '0000-00-00', 0),
          (10,'000.000.070-01', '2022-07-13','2022-07-20',10);
SELECT * FROM emprestimo;

INSERT INTO autoria(isbn_livro, id_autor)
   VALUES ('178-3-16-148410-0', 1),
          ('278-3-16-148410-0', 2),
          ('378-3-36-140410-0', 3),
          ('468-3-16-148410-0', 4),
          ('938-3-16-148410-0', 5),
          ('671-3-16-148410-0', 6),
          ('778-3-16-148410-1', 7),
          ('878-3-26-148410-0', 8),
          ('478-3-16-148410-0', 9),
          ('578-3-16-148410-0', 10);
SELECT * FROM autoria;

/*
Primeira consulta:
A ideia dessa consultar é saber a quantidade de exemplares para cada status 
*/
       
Select statuss,count(isbn_livro) From exemplar
group by statuss
order by 2 desc;

/*
Segunda consulta:
A ideia aqui é juntar as algumas informações de livros com usuário
*/

SELECT li.titulo, u.nome from usuario u
INNER JOIN emprestimo e on e.CPF_usuario=CPF
INNER JOIN exemplar ex on ex.codigo=e.id_exemplar
INNER JOIN livro li on li.isbn=ex.isbn_livro;

/*
Terceira consulta:
A ideia aqui é pegar o nome dos cliente, e o mês dos emprestimos, junto com o titulo dos livros
 fazendo uma contagem em ordem dos emprestismos, ou seja ordernar em ordem crescente o mês de retirada de cada livro, e com a contagem
 saber qual foi retirado primeiro naquele mês ( no mês de julho, 7)
*/
WITH clientes as 
(
Select nome as cliente,
       CPF
FROM usuario
)
SELECT c.cliente as nome_cliente, 
       MONTH(e.data_saida) as Mês_empréstimo,  
       li.titulo as título_livro,
       ROW_NUMBER() OVER() as Ordem_dos_emprestimos
From clientes c
INNER JOIN emprestimo e on e.CPF_usuario=c.CPF
INNER JOIN exemplar ex on ex.codigo=e.id_exemplar
INNER JOIN livro li on li.isbn=ex.isbn_livro
WHERE MONTH(e.data_saida)=7
Order by 2 asc;



	   

       
         
        
         
       





























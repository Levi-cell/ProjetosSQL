CREATE DATABASE BIBLIOTECARIA;

USE BIBLIOTECARIA;

CREATE TABLE autor(
  
  codigo int not null identity primary key,
  CPF_a Varchar(14) not null UNIQUE,
  nome varchar(25) not null,

);

CREATE TABLE genero(

  codigo int not null identity primary key,
  nome varchar(25) not null,

);

CREATE TABLE editora(

  codigo int not null identity primary key,
  registro int not null UNIQUE,
  nome varchar(25) not null,
  cidade varchar(25) not null,

);

CREATE TABLE livro(
   
  isbn varchar(17) not null primary key,
  id_genero int not null,
  id_editora int not null,
  edicao int not null,
  valume int not null,
  valor smallmoney not null,
  titulo varchar(25) not null,
  Constraint fk_livro_genero foreign key(id_genero)
  references genero(codigo),
  Constraint fk_livro_editora foreign key(id_editora)
  references editora(codigo),

);

CREATE TABLE autoria(

  isbn_livro varchar(17) not null,
  id_autor int not null,
  Constraint fk_autoria_livro foreign key(isbn_livro)
  references livro(isbn),
  Constraint fk_autoria_autor foreign key(id_autor)
  references autor(codigo),

);

CREATE TABLE usuario(

  CPF Varchar(14) not null  primary key,
  telefone varchar(25) not null UNIQUE,
  id_perfil int not null,
  nome varchar(25) not null,
  endereco varchar(25) not null,
  email varchar(50) not null,
  Constraint fk_usuario_perfil foreign key(id_perfil)
  references perfil(codigo),
  
);

CREATE TABLE perfil(

  codigo int not null identity primary key,
  prazo date not null,
  limite int not null,
  nome varchar(25) not null,

);

CREATE TABLE exemplar(

  codigo int not null identity primary key,
  isbn_livro varchar(17) not null,
  statuss varchar(25) not null,
  Constraint fk_exemplar_livro foreign key(isbn_livro)
  references livro(isbn),

);

CREATE TABLE emprestimo(

  codigo int not null identity primary key,
  id_exemplar int not null,
  CPF_usuario Varchar(14) not null,
  data_saida date not null,
  data_entrega date not null,
  prazo1 int not null,
  Constraint fk_emprestimo_exemplar foreign key(id_exemplar)
  references exemplar(codigo),
  Constraint fk_emprestimo_usuario foreign key(CPF_usuario)
  references usuario(CPF),

);
------------inserindo valores:

INSERT INTO editora(nome,cidade,registro) values('varsales','salvador',1);
INSERT INTO editora(nome,cidade,registro)values('disney','Santo antonio de Jesus',2);
INSERT INTO editora(nome,cidade,registro)values('pixas','São Paulo',3);
INSERT INTO editora(nome,cidade,registro)values('pivas','Alagoinhas',4);
iNSERT INTO editora(nome,cidade,registro)values('traskovia','New York',5);
INSERT INTO editora(nome,cidade,registro)values('Petrobras','Anildo city',6);

SELECT * from editora;

INSERT INTO genero(nome) values('romance');
INSERT INTO genero(nome) values('drama');
INSERT INTO genero(nome) values('ficção');
INSERT INTO genero(nome) values('ação');
INSERT INTO genero(nome) values('terror');
INSERT INTO genero(nome) values('suspense');

SELECT * from genero;

INSERT INTO livro(isbn,id_genero,id_editora,edicao,valume,valor,titulo)
values('924-65-92999-02-4',1,1,17,8,20,'Crônicas de um mal amado');
INSERT INTO livro(isbn,id_genero,id_editora,edicao,valume,valor,titulo)
values('234-61-93123-05-1',2,2,4,5,30,'Não vá por esse caminho');
INSERT INTO livro(isbn,id_genero,id_editora,edicao,valume,valor,titulo)
values('123-32-94323-09-0',3,3,6,1,45,'Interestelar');
INSERT INTO livro(isbn,id_genero,id_editora,edicao,valume,valor,titulo)
values('452-52-12000-02-4',4,4,2,1,15,'Corrida brutal');
INSERT INTO livro(isbn,id_genero,id_editora,edicao,valume,valor,titulo)
values('052-15-35459-06-3',5,5,1,1,35,'Na calada da noite');
INSERT INTO livro(isbn,id_genero,id_editora,edicao,valume,valor,titulo)
values('812-29-58321-07-2',6,6,2,6,25,'A travessia');

SELECT * from livro;

INSERT INTO autor(CPF_a,nome) values('023.253.683-53','Alexandre Virela');
INSERT INTO autor(CPF_a,nome) values('034.692.682-12','Peter Jordan');
INSERT INTO autor(CPF_a,nome) values('923.831.321-53','Oliver Martin');
INSERT INTO autor(CPF_a,nome) values('691.912.345-44','Pedro Oliveira');
INSERT INTO autor(CPF_a,nome) values('458.351.683-40','Mary Marine');
INSERT INTO autor(CPF_a,nome) values('140.341.694-45','Lucas Araújo');

SELECT * from autor;

INSERT INTO autoria(isbn_livro,id_autor) values('924-65-92999-02-4',1);
INSERT INTO autoria(isbn_livro,id_autor) values('234-61-93123-05-1',2);
INSERT INTO autoria(isbn_livro,id_autor) values('123-32-94323-09-0',3);
INSERT INTO autoria(isbn_livro,id_autor) values('452-52-12000-02-4',4);
INSERT INTO autoria(isbn_livro,id_autor) values('052-15-35459-06-3',5);
INSERT INTO autoria(isbn_livro,id_autor) values('812-29-58321-07-2',6);

SELECT * from autoria;

INSERT INTO perfil(prazo,limite,nome) values('03/04/2021',3,'Raposa anônima');
INSERT INTO perfil(prazo,limite,nome) values('05/01/2021',4,'Lobo anônimo');
INSERT INTO perfil(prazo,limite,nome) values('04/03/2021',2,'Lula anônima');
INSERT INTO perfil(prazo,limite,nome) values('29/06/2021',1,'Sardinha anônima');
INSERT INTO perfil(prazo,limite,nome) values('12/11/2021',5,'Gato anônimo');
INSERT INTO perfil(prazo,limite,nome) values('01/08/2021',3,'Cachorro anônimo');

SELECT * from perfil;

INSERT INTO exemplar(isbn_livro,statuss) values('924-65-92999-02-4','disponível');
INSERT INTO exemplar(isbn_livro,statuss) values('234-61-93123-05-1','vendido');
INSERT INTO exemplar(isbn_livro,statuss) values('123-32-94323-09-0','Alugado');
INSERT INTO exemplar(isbn_livro,statuss) values('452-52-12000-02-4','Alugado');
INSERT INTO exemplar(isbn_livro,statuss) values('052-15-35459-06-3','vendido');
INSERT INTO exemplar(isbn_livro,statuss) values('812-29-58321-07-2','disponível');

SELECT * from exemplar;

INSERT INTO usuario(CPF,telefone,id_perfil,nome,endereco,email)
values('028.524.593-90','(75)99123-5689',1,'Lucas','45812-000','Lucas@gov.com');
INSERT INTO usuario(CPF,telefone,id_perfil,nome,endereco,email)
values('064.512.561-05','(74)99453-9839',2,'Pedro','46712-000','Pedrosv@gmail.com');
INSERT INTO usuario(CPF,telefone,id_perfil,nome,endereco,email)
values('823.642.592-24','(71)93452-6483',3,'Alisson','63949-000','Alisson@email.com');
INSERT INTO usuario(CPF,telefone,id_perfil,nome,endereco,email)
values('123.563.125-02','(45)93521-9821',4,'Yasmin','82394-000','Yasminim@outlook.com');
INSERT INTO usuario(CPF,telefone,id_perfil,nome,endereco,email)
values('561.492.689-45','(55)94562-6783',5,'Adailton','46814-000','Adailton@windows.com');
INSERT INTO usuario(CPF,telefone,id_perfil,nome,endereco,email)
values('491.259.329-68','(75)93682-9024',6,'Melissa','85021-000','Melissa@amazon.com');

SELECT * from usuario;

INSERT INTO emprestimo(id_exemplar,CPF_usuario,data_saida,data_entrega,prazo1)
values(1,'028.524.593-90','01/05/2021','15/05/2021',14);
INSERT INTO emprestimo(id_exemplar,CPF_usuario,data_saida,data_entrega,prazo1)
values(2,'064.512.561-05','05/01/2021','15/01/2021',10);
INSERT INTO emprestimo(id_exemplar,CPF_usuario,data_saida,data_entrega,prazo1)
values(3,'823.642.592-24','04/06/2021','10/06/2021',6);
INSERT INTO emprestimo(id_exemplar,CPF_usuario,data_saida,data_entrega,prazo1)
values(4,'123.563.125-02','23/07/2021','29/07/2021',6);
INSERT INTO emprestimo(id_exemplar,CPF_usuario,data_saida,data_entrega,prazo1)
values(5,'561.492.689-45','10/05/2021','21/05/2021',11);
INSERT INTO emprestimo(id_exemplar,CPF_usuario,data_saida,data_entrega,prazo1)
values(6,'491.259.329-68','14/03/2021','29/03/2021',15);

SELECT * from emprestimo;
SELECT * from usuario;
SELECT * FROM exemplar;
SELECT * FROM perfil;
SELECT * FROM editora;
SELECT * FROM autor;
SELECT * FROM autoria;
SELECT * FROM livro;
SELECT * FROM genero;

------Selecione o código e nome dos autores com código entre 1 e 4.

Select codigo,nome from autor where codigo<4 and codigo>1 order by 1 asc;
                   --ou--
Select codigo,nome from autor where codigo<4 and codigo>1 order by codigo asc;
---prof 1
SELECT codigo,nome from autor where codigo between 1 and 4;

------Selecione código e nome dos autores onde o código esteja fora do intervalo 1 e 4.

Select codigo,nome from autor where codigo>4 order by nome asc;
---prof 2
SELECT codigo,nome from autor where codigo not between 1 and 4;

-------Selecione ISBN e titulo dos livros que começam com o titulo JA.

Select isbn,titulo from livro where titulo= 'JA'; 
                    ---ou 
Select isbn,titulo from livro where titulo like 'JA%'; 

-------Selecione ISBN, TITULO e EDIÇÃO dos livros com a editora na lista (1,2,3,4).

Select li.isbn,li.titulo,li.edicao, edi.nome from livro li
INNER JOIN
editora edi on li.id_editora=edi.codigo where codigo<=4;
---PROF
SELECT isbn,titulo,edicao from livro where edicao in(1,2,3,4)

---prof 1

SELECT isbn,titulo,edicao from livro where edicao >=1 and edicao<=4

----Selecione ISBN, TITULO e EDIÇÃO dos livros que a editora não esteja na lista (1,2,3,4).

Select li.isbn,li.titulo,li.edicao, edi.nome from livro li
INNER JOIN
editora edi on li.id_editora=edi.codigo where codigo>4;

--Prof

SELECT isbn,titulo,edicao from livro where edicao not in(1,2,3,4)


----Selecione código e nome dos autores cujo código seja 1 E o nome Hebert.

Select codigo,nome from autor where codigo=1 and nome='Hebert';	

---Selecione código e nome dos autores cujo código seja 1 OU o nome Hebert.

Select codigo,nome from autor where codigo=1 or nome='hebert'

---Exiba a quantidade de livros emprestados( vou colocar alugao)
                    ---- juntarei tabela emprestimo. exemplar e livros


Select statuss, count (*) as 'qtd de livros alugados' from exemplar 
where statuss='alugado' group by statuss;

Select em.id_exemplar,li.isbn,ex.statuss, count(*) as 'qtde de livros alugados' from exemplar ex 
INNER JOIN emprestimo em on em.id_exemplar=ex.codigo
INNER JOIN livro li on ex.isbn_livro=li.isbn where ex.statuss='alugado' 
group by ex.statuss,li.isbn,em.id_exemplar;  ---- tentativa falha/sem sentido

Select  count(*) from exemplar ex  
INNER JOIN emprestimo em on em.id_exemplar=ex.codigo
INNER JOIN livro li on ex.isbn_livro=li.isbn  where ex.statuss='alugado'
group by ex.statuss,li.isbn,em.id_exemplar

Select em.id_exemplar,li.isbn,ex.statuss from exemplar ex
INNER JOIN emprestimo em on em.id_exemplar=ex.codigo
INNER JOIN livro li on ex.isbn_livro=li.isbn where statuss='alugado'
group by ex.statuss,li.isbn,em.id_exemplar


-----Exiba a quantidade de livros emprestados(alugados) onde o cpf seja igual ou parecido a 123

Select em.CPF_usuario,ex.statuss ,  count (*) as 'qtd de livros alugados' from exemplar ex
INNER JOIN emprestimo em on em.id_exemplar=ex.codigo 
where ex.statuss='alugado' and em.CPF_usuario like '%123%' group by ex.statuss, em.CPF_usuario;

---Exiba a data de saída dos empréstimos cujo a data de entrega seja nula ( ou um valor que eu coloque).

Select data_entrega,data_saida from emprestimo where month(data_entrega)=05;

--Exiba a soma dos livros ( do valor ) né ?

Select SUM(valor) as ' valor total ' from livro;

---Exiba a média dos livros ( do valor)

SELECT AVG(valor) as ' média do valor' from livro;

--Exiba o livro com menor valor.

SELECT  MIN(valor) as 'livro mais barato' from livro;

--Exiba o livro com maior valor.

SELECT MAX(valor) as 'livro mais caro' from livro;

--Exiba a quantidade de livros cadastrados.

SELECT  count(isbn) as '  qtd livros cadastrados ' from livro;

SELECT count(statuss) as'qtd livros alugados'  from exemplar  where statuss='alugado'; 

USE BIBLIOTECARIA;
SELECT count(distinct statuss) from exemplar;

SELECT distinct statuss from exemplar;





-------------------------------------- ATIVIDADE DO PROFESSOR------------------------------------------------------



use biblioteca
go

-- Selecione o código e nome dos autores com código entre 1 e 4.
select codigo, nome
from autor
where codigo between 1 and 4

select codigo, nome
from autor
where codigo >= 1 and codigo <= 4

-- Selecione código e nome dos autores onde o código 
-- esteja fora do intervalo 1 e 4.
select codigo, nome
from autor 
where codigo not between 1 and 4

-- Selecione ISBN e titulo dos livros que começam com o titulo JA.
select isbn, titulo
from livro
where titulo like 'JA%'

-- Selecione ISBN, TITULO e EDIÇÃO dos livros com a editora na lista (1,2,3,4).
select isbn, titulo, edicao
from livro
where edicao in(1,2,3,4)

select isbn, titulo, edicao
from livro
where edicao >= 1 and edicao <= 4

Select li.isbn,li.titulo,li.edicao, edi.nome from livro li
INNER JOIN
editora edi on li.id_editora=edi.codigo where codigo<=4;

-- Selecione ISBN, TITULO e EDIÇÃO dos livros 
-- que a editora não esteja na lista (1,2,3,4).
select isbn, titulo, edicao
from livro
where edicao not in(1,2,3,4)

-- Selecione código e nome dos autores cujo código seja 1 E o nome Hebert.
select codigo, nome
from autor
where codigo = 1 and nome = 'Hebert'

-- Selecione código e nome dos autores cujo código seja 1 OU o nome Hebert.
select codigo, nome
from autor
where codigo = 1 or nome = 'Hebert'

-- Exiba a quantidade de livros emprestados.
select count(*)
from emprestimo
where data_entrega is null
go

select count(*)
from exemplar ex
inner join emprestimo em on em.id_exemplar = ex.codigo
where em.data_entrega is null

-- Exiba a quantidade de livros emprestados onde o cpf seja igual a 123.
select count(*)
from emprestimo
where cpf_usuario = 123

-- Exiba a data de saída dos empréstimos cujo a data de entrega seja nula.
select data_saida
from emprestimo
where data_entrega is null

-- Exiba a soma dos livros.
select sum(valor) as 'Soma'
from livro

-- Exiba a média dos livros.
select AVG(valor) as 'Media'
from livro

-- Exiba o livro com menor valor.
select MIN(valor) as 'Menor'
from livro

-- Exiba o livro com maior valor.
select MAX(valor) as 'Maior'
from livro

select titulo, MAX(valor) as 'Maior'
from livro
group by titulo

-- Exiba a quantidade de livros cadastrados.
select count(*)
from livro

select usu.nome
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario

select * from usuario

select nome, data_saida
from 
usuario usu left join emprestimo emp on emp.cpf_usuario = usu.cpf

select nome, data_saida
from usuario usu
right join emprestimo emp on emp.cpf_usuario = usu.cpf

select nome, data_saida
from 
usuario usu right join emprestimo emp on emp.cpf_usuario = usu.cpf

select nome, data_saida
from 
emprestimo emp right join usuario usu on emp.cpf_usuario = usu.cpf
where emp.data_saida is not null

select nome, data_saida
from emprestimo emp
full outer join usuario usu on usu.cpf = emp.cpf_usuario
go

create or alter view vw_relatorio
as
select usu.nome as 'Usuario', usu.telefone, emp.data_saida, emp.prazo,
	   per.nome as 'perfil', exe.status, li.titulo, li.valor,
	   ge.nome as 'genero', edi.nome as 'editora', atr.nome as 'autor'
from emprestimo emp 
inner join usuario usu on usu.cpf = emp.cpf_usuario
inner join perfil per on per.codigo = usu.id_perfil
inner join exemplar exe on exe.codigo = emp.id_exemplar
inner join livro li on li.isbn = exe.isbn_livro
inner join genero ge on ge.codigo = li.id_genero
inner join editora edi on edi.codigo = li.id_editora
inner join autoria aut on aut.isbn_livro = li.isbn
inner join autor atr on atr.codigo = aut.id_autor


select *
from vw_relatorio

drop database BIBLIOTECARIA

---------------------------------------ATIVIDADE JOIN------------------------------------
use BIBLIOTECARIA
go
----Exiba o nome do usuário e a quantidade de empréstimos realizados.

SELECT usu.nome,em.CPF_usuario, count(em.CPF_usuario) as'quantidade de emprestimo' from usuario usu
INNER JOIN emprestimo em on em.CPF_usuario=usu.CPF 
group by usu.nome,em.CPF_usuario--- so tenho 6 registros, e nenhum realizou mais que 1 emprestimo( meu caso)

--Exiba o titulo do livro e o valor total dos seus exemplares.

SELECT li.titulo, 
count(ex.codigo)as 'número de exemplares', 
SUM(li.valor)'soma de todos os exemplares' 
from livro li
INNER JOIN exemplar ex on ex.isbn_livro=li.isbn
group by li.titulo; ---- novamente aqui só temos um exemplar de cada titulo( meu caso )

---Exiba o nome do autor e a quantidade de livros da sua autoria.

SELECT au.nome,count(ai.isbn_livro) as 'número de livro escritos por fulano'
from autor au
INNER JOIN autoria ai on ai.id_autor=au.codigo
group by au.nome -- novamente todos autores só fizeram 1 tipo de livro

-----Exiba a data do empréstimo e a quantidade de livros por data.

SELECT em.data_saida, count(ex.isbn_livro) as 'exemplares emprestados no dia'
from emprestimo em
INNER JOIN exemplar ex on em.id_exemplar=ex.codigo
group by em.data_saida --- novamente 1 exemplar para cada titulo, e apenas um exemplar foi pego em cada data
---- sim minha bibliotecaria é pobre 

-----Exiba data do empréstimo, o nome do usuário, o perfil do usuário de todos com ou sem empréstimos.

SELECT em.data_saida, usu.nome, p.nome as'nome perfil' from emprestimo em
INNER JOIN usuario usu on em.CPF_usuario=usu.CPF
RIGHT JOIN perfil p on usu.id_perfil=p.codigo

--Exiba o nome de todos os autores e o titulo dos livros de sua autoria, caso o autor não tenha livro exibir 
--somente o nome.

SELECT au.nome, count(li.titulo) as 'qtd de livros',li.titulo, ai.id_autor from autor au
INNER JOIN autoria ai on au.codigo=ai.id_autor
INNER JOIN livro li on li.isbn=ai.isbn_livro
group by au.nome, ai.id_autor, li.titulo

--Exiba data do empréstimo, nome do usuário, perfil do usuário, status do exemplar, isbn do livro, valor do livro,
--- nome do gênero, nome da editora.


CREATE or alter view relatório 
as
SELECT em.data_saida, us.nome as'usario', p.nome as 'Nick Name', ex.statuss,
li.isbn, li.valor, ge.nome as 'genero', edi.nome as 'editora' 
from livro li
INNER JOIN editora edi on li.id_editora=edi.codigo
INNER JOIN genero ge on li.id_genero=ge.codigo
INNER JOIN exemplar ex on ex.isbn_livro=li.isbn
INNER JOIN emprestimo em on em.id_exemplar=ex.codigo
INNER JOIN usuario us on us.CPF=em.CPF_usuario
INNER JOIN perfil p on p.codigo=us.id_perfil

SELECT * FROM relatório
	



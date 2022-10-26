use biblioteca
go

-- select básico
select * from autor;
select nome, cpf from autor;

/*
	> maior que
	< menor que
	>= maior igual
	<= menor igual
	<> diferente
	= igual
*/

select * from autor
where codigo >= 8;

/*
	AND
	condicao1 and condicao2
	    V             V     =   V
		V             F     =   F
		F             V     =   F
		F             F     =   F

	OR
	condicao1 or condicao2
	    V            V   =  V
		V            F   =  V
		F            V   =  V
		F            F   =  F
*/

select * from autor
where codigo = 8 and nome = 'João Eduardo';

select * from autor
where codigo = 8 or nome = 'João Eduard';

select * from autor
order by nome desc

select codigo from autor
order by codigo desc

-- Funções de agregações
SUM = SOMA
AVG = MEDIA
MAX = MAIOR VALOR
MIN = MENOR VALOR

select MAX(valor) as 'Maior Valor'
from livro

select MIN(valor) as 'Menor valor'
from livro

select AVG(valor) as 'Media'
from livro

select count(*) as 'Quantidade cadastrada'
from livro

select sum(valor) as 'Total'
from livro

select * from livro

Agrupamento

select * from autor;

Anildo
Anildo
Vivian
Vivian
Ricardo
Ricardo
Ricardo

select nome, count(*) as 'qtd'
from autor
where codigo = 1
group by nome
order by nome desc

select nome, count(*) as 'qtd'
from autor
group by nome
having count(*) > 2
order by nome desc

Having

Junções
INNER JOIN

select * from autor;
select * from livro;
select * from editora;

select li.isbn, li.titulo, li.valor, edi.nome as 'editora'
from livro li
inner join editora edi on li.id_editora = edi.codigo

select a.cpf, a.nome as 'autor', li.titulo, li.valor, li.isbn,
	   edi.nome as 'editora', ge.nome as 'genero'
from autor a
inner join autoria au on a.codigo = au.id_autor
inner join livro li on li.isbn = au.isbn_livro
inner join editora edi on edi.codigo = li.id_editora
inner join genero ge on ge.codigo = li.id_genero


select usu.nome, count(*) as 'Qtd', usu.cpf
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario
group by usu.nome, usu.cpf

select usu.nome, sum(li.valor) as 'total'
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario
inner join exemplar exem on exem.codigo = emp.id_exemplar
inner join livro li on li.isbn = exem.isbn_livro
group by usu.nome
order by usu.nome

select usu.nome, li.valor, li.titulo, emp.data_saida
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario
inner join exemplar exem on exem.codigo = emp.id_exemplar
inner join livro li on li.isbn = exem.isbn_livro

select * from usuario




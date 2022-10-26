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

SELECT * from emprestimo;
SELECT * from usuario;
SELECT * FROM exemplar;
SELECT * FROM perfil;
SELECT * FROM editora;
SELECT * FROM autor;
SELECT * FROM autoria;
SELECT * FROM livro;
SELECT * FROM genero;
use biblioteca
go


--Select Group by e JOINS

-- Exiba o nome do usuário e a quantidade de empréstimos realizados.
select usu.nome, count(*) as 'qtd'
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario
group by usu.nome
go

SELECT usu.nome,em.CPF_usuario, 
	count(em.CPF_usuario) as'quantidade de emprestimo' 
from usuario usu
INNER JOIN emprestimo em on em.CPF_usuario=usu.CPF
group by usu.nome,em.CPF_usuario
go

-- Exiba o titulo do livro e o valor total dos seus exemplares.
select li.titulo, sum(li.valor) as 'Total'
from livro li
inner join exemplar exe on exe.isbn_livro = li.isbn
group by li.titulo
go

-- Exiba o nome do autor e a quantidade de livros da sua autoria.
select aut.nome, count(*) 'Qtd'
from autoria atr
inner join autor aut on aut.codigo = atr.id_autor
group by aut.nome
go

SELECT au.nome,
count(ai.isbn_livro) as 'número de livro escritos por fulano'
from autor au
INNER JOIN autoria ai on ai.id_autor=au.codigo
group by au.nome
go

-- Exiba a data do empréstimo e a quantidade de livros por data.

select emp.data_saida, count(*) 'Qtd'
from exemplar exe
inner join emprestimo emp on emp.id_exemplar = exe.codigo
group by data_saida

SELECT em.data_saida, 
	count(ex.isbn_livro) as 'quantidade'
from emprestimo em
INNER JOIN exemplar ex on em.id_exemplar=ex.codigo
group by em.data_saida


-- Exiba data do empréstimo, o nome do usuário, 
-- o perfil do usuário de todos com ou sem empréstimos.
select emp.data_saida, usu.nome as 'usuario', pe.codigo as 'perfil'
from perfil pe
left join usuario usu on usu.id_perfil = pe.codigo
left join emprestimo emp on emp.cpf_usuario = usu.cpf
go

SELECT em.data_saida, usu.nome, 
p.nome as'nome perfil' 
from emprestimo em
right JOIN usuario usu on em.CPF_usuario=usu.CPF
LEFT JOIN perfil p on usu.id_perfil=p.codigo
go

select * from usuario


-- Exiba o nome de todos os autores 
-- e o titulo dos livros de sua autoria, 
-- caso o autor não tenha livro exibir somente o nome.
select aut.nome, li.titulo
from autor aut
left join autoria atr on atr.id_autor = aut.codigo
left join livro li on li.isbn = atr.isbn_livro
go

-- Exiba data do empréstimo, nome do usuário, 
-- perfil do usuário, status do exemplar, 
-- isbn do livro, valor do livro, nome do gênero, nome da editora.

select emp.data_saida, usu.nome, per.nome as 'perfil'
	   ,exe.status, exe.isbn_livro, li.valor
	   ,ge.nome as 'genero', edi.nome as 'editora'
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario
inner join perfil per on per.codigo = usu.id_perfil
inner join exemplar exe on exe.codigo = emp.id_exemplar
inner join livro li on li.isbn = exe.isbn_livro
inner join genero ge on ge.codigo = li.id_genero
inner join editora edi on edi.codigo = li.id_editora
go




select emp.data_saida, usu.nome, pe.codigo as 'perfil', 
	exe.status, li.isbn, li.valor, ge.nome, edi.nome
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario
inner join perfil pe on pe.codigo = usu.id_perfil
inner join exemplar exe on exe.codigo = emp.id_exemplar
inner join livro li on li.isbn = exe.isbn_livro
inner join genero ge on ge.codigo = li.id_genero
inner join editora edi on edi.codigo = li.id_editora
go

-- Utilizar o select anterior crie uma VIEW.
create or alter view vw_relatorio
as 
select emp.data_saida, usu.nome, per.nome as 'perfil'
	   ,exe.status, exe.isbn_livro, li.valor
	   ,ge.nome as 'genero', edi.nome as 'editora'
from emprestimo emp
inner join usuario usu on usu.cpf = emp.cpf_usuario
inner join perfil per on per.codigo = usu.id_perfil
inner join exemplar exe on exe.codigo = emp.id_exemplar
inner join livro li on li.isbn = exe.isbn_livro
inner join genero ge on ge.codigo = li.id_genero
inner join editora edi on edi.codigo = li.id_editora
go
--

-- Selecione o código e nome dos autores com código entre 1 e 4.
select codigo, nome
from autor
where codigo between 1 and 4

select codigo, nome
from autor
where codigo >=1 and codigo <=4 


-- Selecione código e nome dos autores onde o código 
-- esteja fora do intervalo 1 e 4.
select codigo, nome
from autor
where codigo not between 1 and 4

-- Selecione ISBN e titulo dos livros que começam com o titulo JA.
select isbn, titulo
from livro 
where titulo like 'JA%'

--Selecione ISBN, TITULO e EDIÇÃO 
-- dos livros com a editora na lista (1,2,3,4).
select isbn, titulo, edicao
from livro
where id_editora in(1,2,3,4)
go

-- Selecione ISBN, TITULO e EDIÇÃO dos livros 
-- que a editora não esteja na lista (1,2,3,4).
select isbn, titulo, edicao
from livro
where id_editora not in(1,2,3,4)
go

-- Selecione código e nome dos autores cujo código seja 1 E o nome Hebert.
select codigo, nome
from autor
where codigo = 1 and nome = 'Hebert'
go

-- Selecione código e nome dos autores cujo código seja 1 OU o nome Hebert.
select codigo, nome
from autor
where codigo = 1 or nome = 'Hebert'
go

-- Exiba a quantidade de livros emprestados.
select count(*) as 'qtd'
from emprestimo emp
inner join exemplar exe on exe.codigo = emp.id_exemplar
inner join livro li on li.isbn = exe.isbn_livro
go

--Exiba a quantidade de livros emprestados onde o cpf seja igual a 123.
select count(*) as 'qtd'
from emprestimo
where cpf_usuario = 123
go

-- Exiba a data de saída dos empréstimos cujo a data de entrega seja nula.
select data_saida
from emprestimo
where data_entrega is null
go


-- Exiba a soma dos livros.
select sum(valor) as 'soma'
from livro

-- Exiba a média dos livros.
select avg(valor) as 'media'
from livro

-- Exiba o livro com menor valor.
select min(valor) as 'menor'
from livro

select top 1 valor
from livro
order by valor asc
go

-- Exiba o livro com maior valor.
select max(valor) as 'maior'
from livro

-- Exiba a quantidade de livros cadastrados.
select count(*) as 'qtd'
from livro

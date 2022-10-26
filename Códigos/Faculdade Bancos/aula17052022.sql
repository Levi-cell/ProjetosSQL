/*
	Revisão SELECT
*/

use biblioteca
go

alter table usuario
alter column cpf bigint not null

select * from usuario

select distinct nome from usuario

select * from usuario
where nome = 'Jonatas'

select * from autor
where codigo >= 10

select * from autor
where codigo >= 10 and nome = 'Daniela'

AND
codigo >= 10 and nome = 'Daniela'
	V                  V      = V
	V                  F      = F
	F                  V      = F
	F                  F      = F

select * from autor
where codigo >= 10 OR nome = 'Daniela'

codigo >= 10 OR nome = 'Daniela'
     V                V    =  V
	 F                V    =  V
	 V                F    =  V
	 F                F    =  F
>
<
>=
<=
=
<>

select * from autor
where codigo not between 1 and 10

select * from emprestimo
where data_entrega between '01/05/2022' and '31/05/2022'

select * from emprestimo
where year(data_entrega) = 2022

select * from emprestimo
where month(data_saida) = 03

select * from emprestimo
where day(data_entrega) = 01

select * from autor
where nome not like '%an'

select * from autor
where nome like 'He%'

select * from autor
where nome like '%er%'

select * from usuario
where cpf like '%6'

% no inicio, pega os caracteres finais
% no fim, pega os caracteres iniciais
% no inicio e no fim, pega qualquer parte da palavra

select * from usuario
where cpf is not null

select * from emprestimo
where data_entrega is null

select * from autor
where codigo in(1,10)

select * from autor
where codigo not in(1,10)

select nome from autor
order by nome desc

select nome from autor
order by nome

select nome, count(*) as 'qtd' from autor
group by nome

select count(nome) as 'qtd'
from autor

-- Exibir a quantidade de livros emprestados
select count(*) 
from emprestimo 
where data_entrega is null

select *
from emprestimo 
where data_entrega is null

select sum(valor) as 'total'
from livro

select AVG(valor) as 'media'
from livro

select titulo, MAX(valor) as 'Maior valor'
from livro
group by titulo

select MIN(valor) as 'menor'
from livro

select AVG(distinct valor) as 'media'
from livro

select titulo, AVG(valor)
from livro
group by titulo
HAVING AVG(valor) > 50


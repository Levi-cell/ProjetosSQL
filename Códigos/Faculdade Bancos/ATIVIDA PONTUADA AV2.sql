USE LOC_vieic2;
--Exiba o total de todas as manuten��es.

SELECT SUM(pre�o) as 'total' from manuten��o;

--Exiba o maior valor das manuten��es.

SELECT MAX(pre�o) as'maior valor' from manuten��o;

--Exiba o menor valor das manuten��es.

SELECT MIN(pre�o) as ' menor valor ' from manuten��o;

--Exiba a media dos valores das manuten��es

SELECT AVG(pre�o) ' m�dia' from manuten��o;

--Exiba a soma dos valores das manuten��es por nome da oficina.

SELECT SUM(m.pre�o), o.nome as 'cliente' from manuten��o m
INNER JOIN oficina o on m.id_ofi=o.codigo
group by o.nome;

--Exiba nome do cliente e o total da manuten��o.

SELECT SUM(m.pre�o), c.nome as'cliente' from manuten��o m
INNER JOIN carro car on car.codigo=m.id_carro
INNER JOIN aloca��o aloc on aloc.id_carro=car.codigo
INNER JOIN cliente c on c.id_cliente=aloc.id_cliente
group by c.nome;

--Exiba o nome do cliente, data sa�da da aloca��o, data entrega da aloca��o, placa do carro, ano do carro, cor do carro, 
--descri��o da manuten��o, valor da manuten��o, nome da oficina, valor di�ria da categoria. 
--de todos os clientes cuja o nome comecem com as letras DA.
SELECT
c.nome, o.nome, cat.valor_di�ria,
aloc.dt_saida, aloc.dt_entrega, 
car.placa, car.ano, car.cor, 
m.descri_manut, m.pre�o FROM cliente c 
LEFT JOIN aloca��o aloc on aloc.id_cliente=c.id_cliente
INNER JOIN carro car on aloc.id_carro=car.codigo
INNER JOIN manuten��o m on m.id_carro=car.codigo
INNER JOIN oficina o on o.codigo=m.id_ofi
INNER JOIN categoria cat on cat.codigo=car.id_categoria
where c.nome like 'DA%';




--Exiba o nome de todos os clientes que terminam com as letras LO.

SELECT nome from cliente where nome like '%LO';


----Exiba a placa do carro e o total dos valores da di�ria do m�s de maio.

SELECT car.PLACA, SUM(c.Valor_di�ria) as'total da di�ria em maio'
FROM categoria c 
INNER JOIN carro car on car.id_categoria=c.codigo
INNER JOIN aloca��o aloc on aloc.id_carro=car.codigo
WHERE month(dt_entrega)= 5
group by car.PLACA
 

---Exiba a quantidade de carros que est�o alocados e n�o foram entregues.

SELECT count(avarias_situa��o) from carro
where avarias_situa��o=' n�o entregue';
--ou melhor--
SELECT count(dt_saida) as'entregues' from aloca��o
where dt_entrega is null


---Exiba a quantidade de carros alocados que foram entregues.

SELECT count(avarias_situa��o) as'entregues' from carro
where avarias_situa��o='entregue';
--ou melhor--
SELECT count(dt_entrega)'entregues' from aloca��o;

--Qual a media dos valores das manuten��es por modelo do veiculo.

SELECT AVG(ma.pre�o) as'm�dia', car.modelo from manuten��o ma
INNER JOIN carro car on car.codigo=ma.id_carro
group by car.modelo;

--Exiba nome do cliente, data sa�da das loca��es de todos os clientes cuja o nome  seja igual a Vitor ou 
--cpf tenha uma sequ�ncia 123.

SELECT c.nome, aloc.dt_saida from cliente c
INNER JOIN aloca��o aloc on aloc.id_cliente=c.id_cliente
where c.nome='Vitor'or CPF like '%123%'


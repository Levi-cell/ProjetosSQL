USE LOC_vieic2;
--Exiba o total de todas as manutenções.

SELECT SUM(preço) as 'total' from manutenção;

--Exiba o maior valor das manutenções.

SELECT MAX(preço) as'maior valor' from manutenção;

--Exiba o menor valor das manutenções.

SELECT MIN(preço) as ' menor valor ' from manutenção;

--Exiba a media dos valores das manutenções

SELECT AVG(preço) ' média' from manutenção;

--Exiba a soma dos valores das manutenções por nome da oficina.

SELECT SUM(m.preço), o.nome as 'cliente' from manutenção m
INNER JOIN oficina o on m.id_ofi=o.codigo
group by o.nome;

--Exiba nome do cliente e o total da manutenção.

SELECT SUM(m.preço), c.nome as'cliente' from manutenção m
INNER JOIN carro car on car.codigo=m.id_carro
INNER JOIN alocação aloc on aloc.id_carro=car.codigo
INNER JOIN cliente c on c.id_cliente=aloc.id_cliente
group by c.nome;

--Exiba o nome do cliente, data saída da alocação, data entrega da alocação, placa do carro, ano do carro, cor do carro, 
--descrição da manutenção, valor da manutenção, nome da oficina, valor diária da categoria. 
--de todos os clientes cuja o nome comecem com as letras DA.
SELECT
c.nome, o.nome, cat.valor_diária,
aloc.dt_saida, aloc.dt_entrega, 
car.placa, car.ano, car.cor, 
m.descri_manut, m.preço FROM cliente c 
LEFT JOIN alocação aloc on aloc.id_cliente=c.id_cliente
INNER JOIN carro car on aloc.id_carro=car.codigo
INNER JOIN manutenção m on m.id_carro=car.codigo
INNER JOIN oficina o on o.codigo=m.id_ofi
INNER JOIN categoria cat on cat.codigo=car.id_categoria
where c.nome like 'DA%';




--Exiba o nome de todos os clientes que terminam com as letras LO.

SELECT nome from cliente where nome like '%LO';


----Exiba a placa do carro e o total dos valores da diária do mês de maio.

SELECT car.PLACA, SUM(c.Valor_diária) as'total da diária em maio'
FROM categoria c 
INNER JOIN carro car on car.id_categoria=c.codigo
INNER JOIN alocação aloc on aloc.id_carro=car.codigo
WHERE month(dt_entrega)= 5
group by car.PLACA
 

---Exiba a quantidade de carros que estão alocados e não foram entregues.

SELECT count(avarias_situação) from carro
where avarias_situação=' não entregue';
--ou melhor--
SELECT count(dt_saida) as'entregues' from alocação
where dt_entrega is null


---Exiba a quantidade de carros alocados que foram entregues.

SELECT count(avarias_situação) as'entregues' from carro
where avarias_situação='entregue';
--ou melhor--
SELECT count(dt_entrega)'entregues' from alocação;

--Qual a media dos valores das manutenções por modelo do veiculo.

SELECT AVG(ma.preço) as'média', car.modelo from manutenção ma
INNER JOIN carro car on car.codigo=ma.id_carro
group by car.modelo;

--Exiba nome do cliente, data saída das locações de todos os clientes cuja o nome  seja igual a Vitor ou 
--cpf tenha uma sequência 123.

SELECT c.nome, aloc.dt_saida from cliente c
INNER JOIN alocação aloc on aloc.id_cliente=c.id_cliente
where c.nome='Vitor'or CPF like '%123%'


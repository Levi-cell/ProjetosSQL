
use mentorama;
SELECT row_number() OVER (ORDER BY peso DESC) AS numero_fruta, tipo_da_fruta, peso
FROM cesta_de_frutas;

SELECT ROW_NUMBER() OVER () AS numero_fruta, tipo_da_fruta, peso
FROM cesta_de_frutas;

SELECT ROW_NUMBER() OVER (
PARTITION BY tipo_da_fruta ORDER BY peso DESC) 
AS numero_fruta, peso, tipo_da_fruta
FROM cesta_de_frutas;

SELECT * FROM cesta_de_frutas;

SELECT 
  LAG(PESO) OVER () 
AS peso_anterior,peso,
  LEAD(PESO) OVER () 
AS peso_posterios
FROM cesta_de_frutas;

SELECT 
tipo_da_fruta, peso,
SUM(PESO) OVER(
ROWS UNBOUNDED PRECEDING)
AS peso_acumulativo
FROM cesta_de_frutas;

SELECT 
tipo_da_fruta, peso,
SUM(PESO) OVER( 
partition by tipo_da_fruta
ROWS UNBOUNDED PRECEDING)
AS peso_acumulativo
FROM cesta_de_frutas
ORDER BY 1 desc;

SELECT 
customer_id, rental_date,
ROW_NUMBER () OVER (PARTITION BY customer_id ORDER BY rental_date ASC)
AS n_aluguel,
ROW_NUMBER () OVER (PARTITION BY customer_id ORDER BY rental_date DESC)
AS n_ultimo_aluguel,
LAG(rental_date) OVER (PARTITION BY customer_id) AS data_ultimo_aluguel
FROM sakila.rental 
ORDER BY customer_id;

/*
Criando grupos de frutas leves e pesadas
*/
SELECT tipo_da_fruta,
       peso,
       NTILE(2) OVER (ORDER BY peso)
       AS grupo_fruta, 
       (CASE WHEN peso<=0.40 then "leve"
       ELSE "pesada" END) AS tipo
FROM cesta_de_frutas;






/*
Criando 4 grupos com base em preco_unitario
*/

SELECT tipo_da_fruta,
       preco_unitario,
	   NTILE(4) OVER ( ORDER BY preco_unitario)
FROM cesta_de_frutas;

/*
Criando 4 grupos com base em preço_total
*/

SELECT tipo_da_fruta,
       preco_total,
	   NTILE(4) OVER ( ORDER BY preco_total DESC)
FROM cesta_de_frutas;

SELECT 
 ROW_NUMBER () OVER (ORDER BY tipo_da_fruta) AS funcao_1,
 RANK () OVER (ORDER BY tipo_da_fruta) AS funcao_2,
 DENSE_RANK () OVER (ORDER BY tipo_da_fruta) as funcao_3,
 tipo_da_fruta
FROM cesta_de_frutas
ORDER BY tipo_da_fruta;

/*
QUESTÃO 1
*/
use sakila;

SELECT c.email,
	   p.customer_id,
	   SUM(p.amount) as total_pago,
       (CASE WHEN SUM(p.amount)>128.70 THEN "Especial"
       WHEN SUM(p.amount)>110.73 THEN "Fiel"
       WHEN SUM(p.amount)>94.77 THEN "Ocasional"
       ELSE "Iniciante" END) AS classificação
FROM payment p
INNER JOIN customer c on p.customer_id=c.customer_id
GROUP BY 2
ORDER BY 3 desc;

/*
QUESTÃO 1 DE OUTRA FORMA
*/
use sakila;

WITH aux1 AS
(
SELECT p.customer_id,
	   c.email,
       SUM(p.amount) AS total_pago
FROM payment p
LEFT JOIN customer c on p.customer_id=c.customer_id
GROUP BY customer_id)

,aux2 AS
(
SELECT *,
NTILE(4) OVER(ORDER BY total_pago DESC)
AS Grupo_consumidor FROM aux1)


SELECT *,(CASE
WHEN Grupo_consumidor=1 THEN "Especial"
WHEN Grupo_consumidor=2 THEN "Fiel"
WHEN Grupo_consumidor=3 THEN "Ocasional"
WHEN Grupo_consumidor=4 THEN "Iniciante"
END) AS Classificação FROM aux2;

/*
QUESTÃO 2
*/
WITH loja1 as(
SELECT s.store_id as loja1,
       p.payment_date as data1,
       amount as valor1,
       SUM(amount) OVER ( ORDER BY p.payment_date ROWS UNBOUNDED PRECEDING ) as acumulativo1,
       ROW_NUMBER() OVER () AS contagem1
FROM payment p
INNER JOIN staff s on p.staff_id=s.staff_id
where (p.payment_date between "2005-07-01" and "2005-07-31") and (s.store_id=1) 
ORDER BY 2 ASC)

,loja2 as(
SELECT s.store_id as loja2,
       p.payment_date as data2,
       amount as valor2,
       SUM(amount) OVER ( ORDER BY p.payment_date ROWS UNBOUNDED PRECEDING ) as acumulativo2,
	    ROW_NUMBER() OVER () AS contagem2
FROM payment p
INNER JOIN staff s on p.staff_id=s.staff_id
where (p.payment_date between "2005-07-01" and "2005-07-31") and (s.store_id=2) 
ORDER BY 2 ASC)

SELECT l1.loja1, l1.data1, l1.valor1, l1.acumulativo1,
       contagem1, contagem2,
       l2.loja2, l2.data2, l2.valor2, l2.acumulativo2
       FROM loja1 l1
       INNER JOIN loja2 l2 on l1.contagem1=l2.contagem2;

/*
QUESTÃO 2 DE OUTRA FORMA
*/       
	   
SELECT s.store_id AS id_loja,
       p.amount as valor,
       p.payment_date as data_pagamento,
       SUM(p.amount) OVER(PARTITION BY s.store_id
ORDER BY p.payment_date ROWS UNBOUNDED PRECEDING)
AS Valor_acumulativo
FROM store s
LEFT JOIN staff sa USING (store_id)
LEFT JOIN payment p  USING (staff_id)
WHERE payment_date BETWEEN "2005-07-01" AND "2005-07-31"
ORDER BY Valor_acumulativo ASC;










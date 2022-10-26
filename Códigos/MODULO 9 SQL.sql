use sakila;

/*
Questão 1)

Letra A
*/
SELECT 
f.title AS film_name,
i.film_id AS id_film, 
count(r.rental_id) AS Qnt_alugueis
FROM rental r
INNER JOIN inventory i on i.inventory_id=r.inventory_id
INNER JOIN film f on f.film_id=i.film_id
GROUP BY 1
ORDER BY 3 desc;

/*
letra B
*/

SELECT 
f.title AS film_name,
i.film_id AS id_film,
count(i.film_id) AS Qnt_disponiveis
FROM inventory i
INNER JOIN film f on f.film_id=i.film_id
GROUP by 1
ORDER by 3 desc;

/*
letra C
*/

create temporary table soma_percentual as( #fiz como tabela temporaria para poder conferir se a soma do percentual dava 100% mesmo

#tabela auxiliar para quantidade de filmes alugados. obs: para rodar a tabela tire o comando create temporary

WITH aux_rental as 
(SELECT 
f.title AS film_name,
i.film_id AS id_film, 
count(r.rental_id) AS Qnt_alugueis
FROM rental r
INNER JOIN inventory i on i.inventory_id=r.inventory_id
INNER JOIN film f on f.film_id=i.film_id
GROUP BY 1
ORDER BY 3 desc)

#tabela auxiliar para quantidade de filmes disponiveis :

,aux_disponivel as
(SELECT 
f.title AS film_name,
i.film_id AS id_film,
count(i.film_id) AS Qnt_disponiveis
FROM inventory i
INNER JOIN film f on f.film_id=i.film_id
GROUP by 1
ORDER by 3 desc)

#junção das tabelas auxiliares:

SELECT 
aux.film_name as "nome do filme",
aux.id_film as "codigo do filme",
aux.Qnt_disponiveis as "quantidade disponível",
aux1.Qnt_alugueis as "Quantos foram alugados",
(aux1.Qnt_alugueis/16044)*100 as perc #porcentagem da qtd de alugueis de cada filme em relação ao total de alugueis
FROM aux_disponivel aux 
INNER JOIN aux_rental aux1 on aux.id_film=aux1.id_film
GROUP BY 1
ORDER BY 5 desc);

# SIM DE FATO OS TITULOS MAIS ALUGADOS CONRRESPONDEM DE FATO AOS QUE TEM MAIOR NúMERO DE ITENS DISPONÍVEIS

SELECT SUM(perc) from soma_percentual; # deu 100.0073

select count(rental_id) from rental; #o total de alugueis é 16044

/*
QUESTÃO 2
Dúvida, antes de mais nada, me diz uma coisa, tem outra forma de fazer essa questão sem usar CTEs?, se sim, o senhor pode demonstrar
com um exemplo ?
*/
use sakila;

WITH loja AS
(
SELECT 
     ca.name AS categoria, 
     count(r.rental_id) AS vendas,
     (CASE WHEN store_id=1 THEN "LOJA 1" ELSE "LOJA 2" END) AS qual_loja
FROM category ca
	 INNER JOIN film_category fc
    on fc.category_id=ca.category_id
     INNER JOIN film f
    on f.film_id=fc.film_id
     INNER JOIN inventory i 
    on i.film_id=f.film_id
     INNER JOIN rental r
    on r.inventory_id=i.inventory_id
GROUP BY 1,3)



,qtd_disponivel AS
(
SELECT ca.name AS categoria,
       COUNT(i.inventory_id) AS 'quant_disponivel'
  FROM inventory i
	   INNER JOIN film f
       on f.film_id=i.film_id
       INNER JOIN film_category fc
       ON f.film_id = fc.film_id
       INNER JOIN category ca
       ON ca.category_id = fc.category_id
       LEFT JOIN (SELECT inventory_id,
                         return_date
                    FROM rental
                   GROUP BY 1) comp
       ON i.inventory_id = comp.inventory_id
 WHERE comp.return_date IS NOT NULL # só estão disponivéis os que foram entregues
 GROUP BY 1
 ORDER BY 2 DESC
 )
 
 ,sales as
 (SELECT
 ca.name AS categoria,
    SUM(p.amount) AS total_sales
  FROM payment AS p
    INNER JOIN rental AS r ON p.rental_id = r.rental_id
    INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
	INNER JOIN film AS f ON i.film_id = f.film_id
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS ca ON fc.category_id = ca.category_id
GROUP BY ca.name
ORDER BY total_sales DESC) #peguei do DER


SELECT sa.categoria,
       sa.total_sales,
       qtd.quant_disponivel,
       lj.vendas,
       lj.qual_loja,
       AVG(f.rental_rate) AS media_aluguel,
       AVG(f.replacement_cost) AS media_resposição
FROM sales sa
INNER JOIN qtd_disponivel qtd on sa.categoria=qtd.categoria
INNER JOIN loja lj on lj.categoria=qtd.categoria
INNER JOIN category c on c.name=lj.categoria
INNER JOIN film_category fc on fc.category_id=c.category_id
INNER JOIN film f on f.film_id=fc.film_id
GROUP by 1,5
ORDER BY 2 DESC;

/* 
QUESTÃO 2 de outra foram
*/

WITH loja_1 AS
(
SELECT 
     ca.name AS categoria, 
     count(r.rental_id) AS vendas_loja1
FROM category ca
	 INNER JOIN film_category fc
    on fc.category_id=ca.category_id
     INNER JOIN film f
    on f.film_id=fc.film_id
     INNER JOIN inventory i 
    on i.film_id=f.film_id
     INNER JOIN rental r
    on r.inventory_id=i.inventory_id
    where store_id=1
GROUP BY 1)


,loja_2 AS
(
SELECT 
     ca.name AS categoria, 
     count(r.rental_id) AS vendas_loja2
FROM category ca
	 INNER JOIN film_category fc
    on fc.category_id=ca.category_id
     INNER JOIN film f
    on f.film_id=fc.film_id
     INNER JOIN inventory i 
    on i.film_id=f.film_id
     INNER JOIN rental r
    on r.inventory_id=i.inventory_id
    where store_id=2
GROUP BY 1)

,qtd_disponivel AS
(
SELECT ca.name AS categoria,
       COUNT(i.inventory_id) AS 'quant_disponivel'
  FROM inventory i
	   INNER JOIN film f
       on f.film_id=i.film_id
       INNER JOIN film_category fc
       ON f.film_id = fc.film_id
       INNER JOIN category ca
       ON ca.category_id = fc.category_id
       LEFT JOIN (SELECT inventory_id,
                         return_date
                    FROM rental
                   GROUP BY 1) comp
       ON i.inventory_id = comp.inventory_id
 WHERE comp.return_date IS NOT NULL # só estão disponivéis os que foram entregues
 GROUP BY 1
 ORDER BY 2 DESC
 )
 
 ,sales as
 (SELECT
 ca.name AS categoria,
    SUM(p.amount) AS total_sales
  FROM payment AS p
    INNER JOIN rental AS r ON p.rental_id = r.rental_id
    INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
	INNER JOIN film AS f ON i.film_id = f.film_id
    INNER JOIN film_category AS fc ON f.film_id = fc.film_id
    INNER JOIN category AS ca ON fc.category_id = ca.category_id
GROUP BY ca.name
ORDER BY total_sales DESC) #peguei do DER


SELECT sa.categoria,
       sa.total_sales,
       qtd.quant_disponivel,
       lj1.vendas_loja1,
       lj2.vendas_loja2,
       AVG(f.rental_rate) AS media_aluguel,
       AVG(f.replacement_cost) AS media_reposição
FROM sales sa
INNER JOIN qtd_disponivel qtd on sa.categoria=qtd.categoria
INNER JOIN loja_1 lj1 on lj1.categoria=qtd.categoria
INNER JOIN loja_2 lj2 on lj2.categoria=lj1.categoria
INNER JOIN category c on c.name=lj2.categoria
INNER JOIN film_category fc on fc.category_id=c.category_id
INNER JOIN film f on f.film_id=fc.film_id
GROUP by 1
ORDER BY 2 DESC;










  














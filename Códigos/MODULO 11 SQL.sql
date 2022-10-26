use sakila;

## DATA
select payment_id,
       payment_date,
       DATE(payment_date) as data,
       unix_timestamp(payment_date) as segundos
FROM payment;

SELECT DATEDIFF(CURDATE(), "1990-01-03") AS idade_dias,
       DATEDIFF(CURDATE(), "1990-01-03")/365 AS idade_anos;

SELECT NOW() AS hoje,
       DATE_SUB(NOW(), INTERVAL 1 DAY) AS ontem,
       DATE_ADD(NOW(), INTERVAL 1 DAY) AS amanha,
       DATE_SUB(NOW(), INTERVAL 1 MONTH) AS mes_passado,
       DATE_ADD(NOW(), INTERVAL 1 WEEK) AS semana_que_vem,
       DATE_ADD(NOW(), INTERVAL 1 YEAR) AS ano_que_vem;
       
SELECT EXTRACT(DAY FROM CURDATE() ) AS dia_de_hoje,
       EXTRACT(YEAR FROM CURDATE()) AS ano_atual,
       YEAR(CURDATE()) AS ano_atual;
       
       
SELECT DATE_FORMAT(CURDATE(), "%y-%m-01") AS mes_atual,
       DATE_FORMAT(CURDATE(), "%y-01-01") AS ano_atual;
       
SELECT EXTRACT(DAY FROM CURDATE() ) AS dia_de_hoje,
	   EXTRACT(YEAR FROM CURDATE()) AS ano_atual_extracao_1,
	   YEAR(CURDATE()) AS ano_atual_extraca_2,
	   MONTH(CURDATE()) AS mes_atual_extracao,
	   DAY(CURDATE()) AS dia_atual_extracao,
	   DATE_FORMAT(CURDATE(), "%Y") AS ano_atual_extracao_3,
	   DATE_FORMAT(CURDATE(), "%y-%m-01") AS mes_atual,
	   DATE_FORMAT(CURDATE(), "%y-01-01") AS ano_atual_trunc;	
       
	SELECT EXTRACT(WEEK FROM CURDATE()) AS semana_atual,
		   DATE_SUB(CURDATE(), INTERVAL DAYOFWEEK(CURDATE()) -1 DAY),
           DATE_SUB(CURDATE(), INTERVAL WEEKDAY(CURDATE()) -1 DAY);
           

 ## TEXTO

 SELECT CONCAT(first_name, " ", last_name) as full_name
 FROM staff;
 
 SELECT CONCAT_WS(" ", first_name, last_name) as full_name
 FROM staff;
 
 SELECT REVERSE(first_name) AS nome_contrario,
		REVERSE(last_name) AS sobrenome_contrario
FROM sakila.staff;

SELECT last_name,
	   LEFT(last_name, 3) AS esq,
       RIGHT(first_name, 2) AS dir,
       MID(last_name, 2, 6) AS meio
FROM staff;

	SELECT last_name,
		   REPLACE(last_name, "e", "I") AS subst
	FROM staff;
	
    
    SELECT last_name,
           TRIM(last_name) AS 2_lados,
           RTRIM(last_name) AS direita,
           LTRIM(last_name) AS esqueda
FROM staff;

 SELECT first_name,
		LPAD(first_name, "->") AS esqueda,
		RPAD(first_name, ">-") AS direita	
FROM staff;

 WITH aux as (SELECT title,
       LEFT(title, 3),
       substr(title, 2, 6),
       LEFT(title, 7) as bom	
FROM film)

SELECT RIGHT(BOM,6) from aux;

## EXPRESSÕES REGULARES

#retornar todos os filmes com atores cujo nome contém 'DAN'
#(pode ser DANNY, DANIEL, DAN, etc.)

SELECT * FROM film_list
WHERE REGEXP_LIKE(actors, "DAN");

#descobrir filmes que tenham professores na descrição

SELECT * FROM film_list
WHERE REGEXP_LIKE(description, "Teacher");

SELECT * FROM film_list 
WHERE description LIKE "%Teacher%";

#descobrir filmes com Trailers sendo a primeria feature especial

SELECT * FROM film
WHERE REGEXP_LIKE(special_features, "^Trailer");

SELECT * FROM film
WHERE special_features LIKE "Trailer%";

/*
Questão 1
a)
*/
Select count(r.rental_id) as qtd_alugueis,
       MONTH(r.rental_date) as mês_maio,
       s.store_id as loja
FROM rental r
LEFT JOIN staff sa on sa.staff_id=r.staff_id
INNER JOIN store s on sa.staff_id=s.manager_staff_id
group by 3;

/*
b)
*/
SELECT * FROM payment;

SELECT MONTH(p.payment_date) as mês,
	   count(p.amount) as total_arrecadado
FROM payment p
group by 1
ORDER BY 1 desc;

/*
c)
rapaz essa letra C é estranha se eu fizer só a consulta : 
*/

SELECT * FROM RENTAL;

SELECT EXTRACT(WEEK FROM rental_date) as semana,
       count(rental_id) as qtd_alugueis
FROM rental
WHERE MONTH(rental_date)<=6 and MONTH(rental_date)>=5
group by 1
order by 2 desc;	

#ou

SELECT WEEK(rental_date) as semana,
       count(rental_id) as qtd_alugueis
FROM rental
WHERE MONTH(rental_date)<=6 and MONTH(rental_date)>=5
group by 1
ORDER BY 2 desc ;

/*
Questão 2
*/
use sakila;

WITH cliente_fieis as 
(
Select customer_id as cliente, 
       count(rental_id) as qtd_alugueis
FROM rental
WHERE month(rental_date)=5
group by 1
having count(rental_id)>=2
order by 1
)

, diferença_data as
(
Select c.store_id as loja,
       cf.cliente,
       r.rental_date as data,
	   DATEDIFF(r.rental_date,(LAG(r.rental_date) OVER(PARTITION BY cf.cliente
ORDER BY r.rental_date ASC))) as diferença_data
FROM rental r
INNER JOIN cliente_fieis cf on cf.cliente=r.customer_id
INNER JOIN customer c on c.customer_id=r.customer_id)

SELECT loja,
       AVG(diferença_data) as "número médios de dias que um cliente fiel leva pra fazer outro aluguel naquela loja no mês de maio"
From diferença_data
group by 1
	   
;

###OU essas duas formas tem diferença média de alguns decimos entre se, é normal ? ou eu fiz algo errado ?

WITH clientes_fixos AS
(
SELECT COUNT(rental_id) AS 'alugueis',
       customer_id AS 'clientes'
  FROM rental
 WHERE rental_date >= '2005-05-01'
	   AND rental_date <= '2005-05-31'
 GROUP BY 2
 HAVING COUNT(rental_id) >=2
 ORDER BY 2
 ),

diferenca_aluguel AS 

(SELECT t3.store_id AS 'loja',
       t2.clientes,
       t1.rental_date,
       DATEDIFF(t1.rental_date, (LAG(t1.rental_date) OVER(PARTITION BY t2.clientes ORDER BY t1.rental_date ASC))) AS 'diferenca'
  FROM rental AS t1
       INNER JOIN clientes_fixos AS t2
       ON t1.customer_id = t2.clientes
       INNER JOIN sakila.customer AS t3
       ON t1.customer_id = t3.customer_id)

SELECT loja,
       AVG(diferenca)
  FROM diferenca_aluguel
 GROUP BY loja; 
 
 /*
 QUESTÃO 3
 */
 
 Select title as filme,
	    rating as classificação_inidicativa
 from film
 WHERE REGEXP_LIKE(rating,"PG") OR REGEXP_LIKE(rating,"PG-13");
 
 #### OU a forma abaixo foi a que o colega fez, precisava ele de tudo isso ou não ? kkkk
 
 WITH consulta AS
(
SELECT rating REGEXP "PG" OR "PG-13" AS 'result',
       rating,
       film_id
  FROM film
)

SELECT (CASE
          WHEN result = 1 THEN title
          ELSE NULL
		END) AS 'titulo',
        t2.rating AS 'categoria'
  FROM film AS t1
	   INNER JOIN consulta AS t2
       ON t1.film_id = t2.film_id
HAVING titulo IS NOT NULL;

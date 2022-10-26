-- Create database and set it as default
CREATE DATABASE IF NOT EXISTS mentorama;
USE mentorama;

-- Create table with data types
CREATE TABLE IF NOT EXISTS cesta_de_frutas (
  tipo_da_fruta VARCHAR(15),
  cor VARCHAR(20),
  redonda BOOL,
  preco_unitario DECIMAL(5,2),
  peso DECIMAL(5,2),
  preco_total DECIMAL(5,2)
);

-- Make sure table is empty
TRUNCATE TABLE cesta_de_frutas;

-- Insert table values
INSERT INTO cesta_de_frutas VALUES
  ('maçã', 'vermelha', TRUE, 1.25, 0.6, 0.75),
  ('maçã', 'vermelha', TRUE, 1.25, 0.55, 0.69),
  ('maçã', 'verde', TRUE, 1.15, 0.4, 0.46),
  ('banana', 'amarela', FALSE, 0.75, 0.7, 0.53),
  ('banana', 'amarela', FALSE, 0.75, 0.75, 0.56),
  ('laranja', 'laranja', TRUE, 1.45, 0.5, 0.73),
  ('laranja', 'laranja', TRUE, 1.45, 0.45, 0.65),
  ('lima', 'amarela', FALSE, 2.25, 0.2, 0.45),
  ('lima', 'amarela', FALSE, 2.25, 0.22, 0.5),
  ('lima', 'amarela', FALSE, 2.25, 0.19, 0.43),
  ('limão', 'verde', TRUE, 2.4, 0.18, 0.43),
  ('limão', 'verde', TRUE, 2.4, 0.17, 0.41)
;


 SELECT * from cesta_de_frutas;
 
Select distinct tipo_da_fruta from cesta_de_frutas;

SELECT  tipo_da_fruta, count(*) as'quantidade', AVG(PESO) as "media de peso", AVG(preco_unitario) as "media do preço",AVG(preco_total) as " media total"
from cesta_de_frutas  
where tipo_da_fruta="maçã" or tipo_da_fruta="lima" or tipo_da_fruta="laranja" or tipo_da_fruta="banana" or tipo_da_fruta="limão" 
group by 1;

SELECT cor, count(*) as'quantidade' from cesta_de_frutas group by cor;

SELECT count(distinct tipo_da_fruta) as " qtd de tipos" from cesta_de_frutas;

SELECT COUNT(tipo_da_fruta),MAX(peso),MIN(peso) From cesta_de_frutas;

SELECT SUM(preco_total) as'total' from cesta_de_frutas;

SELECT AVG(preco_unitario) as "media" from cesta_de_frutas;

SELECT STDDEV(peso) from cesta_de_frutas;

SELECT GROUP_CONCAT(cor) from cesta_de_frutas where cor="amarela";

SELECT tipo_da_fruta, group_concat(cor) from mentorama.cesta_de_frutas group by 1;



Drop database mentorama;	







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
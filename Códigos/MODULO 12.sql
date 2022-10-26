/*
Criando o banco de dados sgpm
*/

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS sgpm;

-- Definir como padrão do MySQL Workbench
USE sgpm;

-- Criar a tabela de Departamentos
CREATE TABLE IF NOT EXISTS sgpm.departamentos (
	id_departamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255),
    cidade_escritorio VARCHAR(255)
)
COMMENT "Tabela que armazena departamentos da empresa";

-- Criar a tabela de Pessoas
CREATE TABLE IF NOT EXISTS sgpm.pessoas (
	id_pessoa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_departamento INT NOT NULL,
    nome VARCHAR(255),
    sobrenome VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    data_contratacao DATE,
    data_nascimento DATE,
    ativa BOOL,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
) 
COMMENT "Tabela que armazena pessoas contratadas pela empresa";

-- Criar a tabela de Salários
CREATE TABLE IF NOT EXISTS sgpm.salarios (
	id_salario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_pessoa INT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    valor DECIMAL(6,2),
    FOREIGN KEY (id_pessoa) REFERENCES pessoas(id_pessoa)
)
COMMENT "Tabela que armazena salários de pessoas de acordo com sua contratação";
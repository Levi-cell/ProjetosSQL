/*
Projeto modulo 12
*/
CREATE DATABASE BIBLIOTECARIA;

USE BIBLIOTECARIA;

CREATE TABLE if not exists autor(

  codigo int not null AUTO_INCREMENT primary key,
  CPF_a Varchar(255) not null UNIQUE,
  nome varchar(255) not null

) COMMENT "Aqui estão os registros do ator";

CREATE TABLE if not exists genero(

  codigo int not null AUTO_INCREMENT primary key,
  nome varchar(255) not null

) COMMENT "Aqui estão os registros do genero do livro";

CREATE TABLE if not exists editora(

  codigo int not null AUTO_INCREMENT primary key,
  registro int not null UNIQUE,
  nome varchar(255) not null,
  cidade varchar(255) not null

)COMMENT "Aqui registra as informações da editora do livro";

CREATE TABLE if not exists livro(
   
  isbn varchar(255) not null primary key,
  id_genero int not null,
  id_editora int not null,
  edicao int not null,
  valume int not null,
  valor decimal(6,2) not null,
  titulo varchar(255) not null,
  Constraint fk_livro_genero foreign key(id_genero)
  references genero(codigo),
  Constraint fk_livro_editora foreign key(id_editora)
  references editora(codigo)

)COMMENT "Aqui tem as informações do livro o qual recebe como chave primaria o isbn que não é auto incremente, é posto manualmente";

CREATE TABLE if not exists autoria(

  isbn_livro varchar(255) not null,
  id_autor int not null,
  Constraint fk_autoria_livro foreign key(isbn_livro)
  references livro(isbn),
  Constraint fk_autoria_autor foreign key(id_autor)
  references autor(codigo)

)COMMENT "Aqui é uma tabela extra que interpreta a relação de cardinalidade M_N entre livro e autor, regra da faculdade";

CREATE TABLE if not exists usuario(

  CPF Varchar(255) not null  primary key,
  telefone varchar(255) not null UNIQUE,
  id_perfil int not null,
  nome varchar(255) not null,
  endereco varchar(255) not null,
  email varchar(255) not null,
  Constraint fk_usuario_perfil foreign key(id_perfil)
  references perfil(codigo)
  
)COMMENT "Aqui é as informações do usuario cadastrado na bibliotecaria  ";

CREATE TABLE if not exists perfil(

  codigo int not null AUTO_INCREMENT primary key,
  prazo date not null,
  limite int not null,
  nome varchar(255) not null

)COMMENT "Aqui é as informações do perfil, é gerado quando um usuario pega um exemplar, ou seja faz um emprestimo
um usuario pode ter vários perfis";

CREATE TABLE if not exists exemplar(

  codigo int not null AUTO_INCREMENT primary key,
  isbn_livro varchar(255) not null,
  statuss varchar(255) not null,
  Constraint fk_exemplar_livro foreign key(isbn_livro)
  references livro(isbn)

)COMMENT "Aqui é as informações de um exemplar de um determinado livro";

CREATE TABLE if not exists emprestimo(

  codigo int not null AUTO_INCREMENT primary key,
  id_exemplar int not null,
  CPF_usuario Varchar(255) not null,
  data_saida date,
  data_entrega date,
  prazo1 int not null,
  Constraint fk_emprestimo_exemplar foreign key(id_exemplar)
  references exemplar(codigo),
  Constraint fk_emprestimo_usuario foreign key(CPF_usuario)
  references usuario(CPF)
  
  

)COMMENT "Aqui é as informações do emprestimo quando o usuario pega um livro";

/*
# QUESTÃO 1: 

#a)Cada tabela representa é um campo-entidade que guarda registros e linhas 


#b)Se relacionam com cardinalidades diferentes, e por meio do comando constraints, uma linha é a mesma em todas as tabelas
a diferença é que ela guarda diferente informações em diferentes tabelas-entidades

#c)CPF, isbn, data_entrega, prazo, todos os tipos de informações com todos tipos de váriavéis

#d)tipo texto, número e data. em alguns casos pode ter smallmoney porém o workbench não reconhece

#e)São 9 colunas, dentre essas 9 colunas só recebem o constraint aquelas que tem chave estrangeiras, as primerias colunas a receberam dados
são sempre aquelas que não tem chave estrangeira. e dentre chave estrangeira temos aquelas como  : id_exemplar, id_perfil, id_autor e etc

#QUESTÃO 2:Apenas usei create table, constraint foreign key references, int not null, primary key, AUTO_INCREMENT e alguns outro comandos de
declaração de váriavel como date

#QUESTÃO 3: Os dados podem ser inseridos manualmente, começando pelas tabelas que não tem chaves estrangeiras apartir do comando:
INSERT INTO VALUES. mas também pode ser automatizado a inserção de dados por algum software, como atendimento bot, utilizando API e etc
o que já pode ser um processo mais trabalhoso ou pago, porém uma vez feito de forma correta os dados vão entrar pra sempre sem nenhum trabalho
agora o software precisa ser feito de forma que os dados entrem em ordem nas tabelas sem a chave estrangeira primeiro e depois seja complementado
a informação em tabelas com chave estrangeira, se essa ordem não for estabelecida no código , então vai dar erro

#OBSERVAÇÃO: esse é um projeto que fiz na faculdade em outra plataforma apenas revisei e adaptei pro workbench, está tudo bem detalhado
espero que seja considerado pois é um DATABASE grande de 9 colunas, entendo que as respostas são mais como guia e não são de fato a avaliação

/*
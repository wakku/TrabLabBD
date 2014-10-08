CREATE SEQUENCE CLIENTE_ID_CLIENTE_SEQ;
CREATE SEQUENCE VENDA_ID_VENDA_SEQ;
CREATE SEQUENCE ENDERECO_ID_ENDERECO_SEQ;
CREATE SEQUENCE FRETE_ID_FRETE_SEQ;
CREATE SEQUENCE VISUALIZACAO_ID_VISUALIZACAO_SEQ;
CREATE SEQUENCE COMENTARIO_ID_COMENTARIO_SEQ;
CREATE SEQUENCE AVALIACAO_ID_AVALIACAO_SEQ;
CREATE SEQUENCE PRODUTO_ID_PRODUTO_SEQ;
CREATE SEQUENCE PRODUTO_FORNECEDOR_ID_PRODUTO_FORNECEDOR_SEQ;
CREATE SEQUENCE FORNECEDOR_ID_FORNECEDOR_SEQ;
CREATE SEQUENCE CATEGORIA_ID_CATEGORIA_SEQ;
CREATE SEQUENCE PRECO_ID_PRECO_SEQ;
CREATE SEQUENCE PROMOCAO_ID_PROMOCAO_SEQ;

--DROP TABLE CLIENTE_ID_CLIENTE_SEQ CASCADE;
--DROP TABLE VENDA_ID_VENDA_SEQ CASCADE;
--DROP TABLE ENDERECO_ID_ENDERECO_SEQ CASCADE;
--DROP TABLE FRETE_ID_FRETE_SEQ CASCADE;
--DROP TABLE VISUALIZACAO_ID_VISUALIZACAO_SEQ CASCADE;
--DROP TABLE COMENTARIO_ID_COMENTARIO_SEQ CASCADE;
--DROP TABLE AVALIACAO_ID_AVALIACAO_SEQ CASCADE;
--DROP TABLE PRODUTO_ID_PRODUTO_SEQ CASCADE;
--DROP TABLE PRODUTO_FORNECEDOR_ID_PRODUTO_FORNECEDOR_SEQ CASCADE;
--DROP TABLE FORNECEDOR_ID_FORNECEDOR_SEQ CASCADE;
--DROP TABLE CATEGORIA_ID_CATEGORIA_SEQ CASCADE;
--DROP TABLE PRECO_ID_PRECO_SEQ CASCADE;
--DROP TABLE PROMOCAO_ID_PROMOCAO_SEQ CASCADE;

CREATE TABLE CLIENTE(
  id_cliente integer DEFAULT NEXTVAL ('CLIENTE_ID_CLIENTE_SEQ') PRIMARY KEY,
  nome_cliente char varying(70) NOT NULL,
  cpf char(11) NOT NULL unique,
  telefone char varying (15),
  email char varying (40),
  id_endereco integer REFERENCES endereco(id_endereco) NOT NULL
);

CREATE TABLE ENDERECO(
  id_endereco integer DEFAULT NEXTVAL ('ENDERECO_ID_ENDERECO_SEQ') PRIMARY KEY,
  logradouro char varying(50) NOT NULL,
  numero char varying(6) NOT NULL,
  complemento char varying(30),
  cidade char varying(30) NOT NULL,
  estado char(2) NOT NULL
);

CREATE TABLE FRETE(
  id_frete integer DEFAULT NEXTVAL ('FRETE_ID_FRETE_SEQ')PRIMARY KEY,
  cep_inicio char(8) NOT NULL,
  cep_final char(8) NOT NULL,
  preco integer DEFAULT 0
);

CREATE TABLE VENDA(
  id_venda bigint DEFAULT NEXTVAL ('VENDA_ID_VENDA_SEQ')PRIMARY KEY,
  id_cliente integer REFERENCES cliente(id_cliente) NOT NULL,
  id_frete integer REFERENCES cliente(id_cliente) NOT NULL,
  produtos integer[] NOT NULL,
  dia_hora timestamp DEFAULT now()
);

CREATE TABLE VISUALIZACAO(
  id_visualizacao integer DEFAULT NEXTVAL ('VISUALIZACAO_ID_VISUALIZACAO_SEQ') PRIMARY KEY,
  id_cliente integer REFERENCES cliente(id_cliente) NOT NULL,
  id_produto bigint REFERENCES produto(id_produto) NOT NULL,
  dia_hora timestamp DEFAULT now()
);

CREATE TABLE COMENTARIO(
  id_comentario integer DEFAULT NEXTVAL ('COMENTARIO_ID_COMENTARIO_SEQ')PRIMARY KEY,
  id_cliente integer REFERENCES cliente(id_cliente) NOT NULL,	
  cometario char varying(1000) NOT NULL
);

CREATE TABLE AVALIACAO(
  id_avaliacao integer DEFAULT NEXTVAL('AVALIACAO_ID_AVALIACAO_SEQ') PRIMARY KEY,
  id_cliente integer REFERENCES cliente(id_cliente) NOT NULL,
  nota smallint check (nota > 0) check (nota < 5),
  comentario char varying(1000)
);

CREATE TABLE PRODUTO(
  id_produto bigint DEFAULT NEXTVAL('PRODUTO_ID_PRODUTO_SEQ') PRIMARY KEY,
  imagem oid,
  id_categoria integer REFERENCES categoria(id_categoria),
  em_estoque integer check (em_estoque > 0),
  minimo_em_estoque integer check (minimo_em_estoque > 0),
  maximo_em_estoque integer check (maximo_em_estoque > 0)
);

CREATE TABLE PRODUTO_FORNECEDOR(
  id_produto bigint DEFAULT NEXTVAL('PRODUTO_FORNECEDOR_ID_PRODUTO_FORNECEDOR_SEQ') PRIMARY KEY,
  id_fornecedor integer REFERENCES fornecedor(id_fornecedor) NOT NULL
);

CREATE TABLE FORNECEDOR(
  id_fornecedor integer DEFAULT NEXTVAL (' FORNECEDOR_ID_FORNECEDOR_SEQ') PRIMARY KEY,
  nome_fornecedor integer NOT NULL,
  cnpj char(14) NOT NULL unique,
  telefone char varying (15),
  email char varying (40),
  id_endereco integer REFERENCES endereco(id_endereco) NOT NULL
);

CREATE TABLE CATEGORIA(
  id_categoria integer DEFAULT NEXTVAL ('CATEGORIA_ID_CATEGORIA_SEQ')PRIMARY KEY,
  descricao char varying(100) NOT NULL
);

CREATE TABLE PRECO(
  id_preco bigint DEFAULT NEXTVAL ('PRECO_ID_PRECO_SEQ') PRIMARY KEY,
  id_produto bigint REFERENCES produto(id_produto) NOT NULL,
  preco integer NOT NULL check(preco > 0)
);

CREATE TABLE PROMOCAO(
  id_promocao integer DEFAULT NEXTVAL ('PROMOCAO_ID_PROMOCAO_SEQ') PRIMARY KEY,
  id_produto bigint REFERENCES produto(id_produto) NOT NULL,
  preco integer NOT NULL check (preco > 0)
);

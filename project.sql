create sequence USUARIO_ID_USUARIO_SEQ;
create sequence CLIENTE_ID_CLIENTE_SEQ;
create sequence COMPRA_ID_COMPRA_SEQ;
create sequence ENDERECO_ID_ENDERECO_SEQ;
create sequence FRETE_ID_FRETE_SEQ;
create sequence VISUALIZACAO_ID_VISUALIZACAO_SEQ;
create sequence COMENTARIO_ID_COMENTARIO_SEQ;
create sequence AVALIACAO_ID_AVALIACAO_SEQ;
create sequence PRODUTO_ID_PRODUTO_SEQ;
create sequence PRODUTO_FORNECEDOR_ID_PRODUTO_FORNECEDOR_SEQ;
create sequence FORNECEDOR_ID_FORNECEDOR_SEQ;
create sequence CATEGORIA_ID_CATEGORIA_SEQ;
create sequence PRECO_ID_PRECO_SEQ;
create sequence PROMOCAO_ID_PROMOCAO_SEQ;

--DROP TABLE CLIENTE_ID_CLIENTE_SEQ CASCADE;
--DROP TABLE COMPRA_ID_COMPRA_SEQ CASCADE;
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

create table USUARIO(
	id_usuario int primary key default nextval ('USUARIO_ID_USUARIO_SEQ'),
	login varchar(20) not null unique,
	senha varchar(20) not null,
	nome varchar(70) not null,
	cpf char(11) not null unique,
	email varchar(40),
	tipo smallint not null
);

create table ADMIN(
	id_admin int primary key references usuario(id_usuario) on update cascade on delete cascade
);

create table CLIENTE(
	id_cliente int primary key references usuario(id_usuario) on update cascade on delete cascade,
	id_endereco int references endereco(id_endereco) not null on update cascade on delete cascade
);

create table ENDERECO(
	id_endereco int primary key default nextval ('ENDERECO_ID_ENDERECO_SEQ'),
	logradouro varchar(50) not null,
	numero varchar(6) not null,
	cep char(8) not null,
	bairro varchar(30) not null,
	cidade varchar(30) not null,
	estado char(2) not null
);

create table COMPRA(
	id_venda int primary key default nextval ('COMPRA_ID_COMPRA_SEQ'),
	data timestamp default now(),
	cliente int references cliente(id_cliente) not null on update cascade on delete cascade,
	frete decimal(5,2),
	nota_fiscal int,
    preco decimal(5,2),
    promocao
	dia_hora timestamp default now()
);

create table VISUALIZACAO(
	id_visualizacao bigint default nextval ('VISUALIZACAO_ID_VISUALIZACAO_SEQ') primary key,
	cliente int references cliente(id_cliente) not null on update cascade on delete cascade,
	produto int references produto(id_produto) not null on update cascade on delete cascade,
	data timestamp default now()
);

create table AVALIACAO(
	id_avaliacao int default nextval('AVALIACAO_ID_AVALIACAO_SEQ') primary key,
	cliente int references cliente(id_cliente) not null on update cascade on delete cascade,
	produto int references produto(id_produto) not null on update cascade on delete cascade,
	nota smallint check (nota between 0 and 5),
	comentario varchar(1000)
);

create table PRODUTO(
	id_produto int primary key default nextval('PRODUTO_ID_PRODUTO_SEQ'),
	cod_barras int not null unique,
    nome varchar(30) not null,
    descricao text 
	imagem oid,
	categoria varchar(100) not null,
	estoque int check (estoque >= 0),
	preco decimal(5,2) not null check (preco > 0)
);

create table LIVRO(
	id_livro int primary key references produto(id_produto),
    autor varchar(200) not null,
	editora varchar(80) not null
);

create table CD(
	id_cd int primary key references produto(id_produto),
	artista varchar(200) not null,
	gravadora varchar(80) not null
);

create table DVD(
	id_dvd int primary key references produto(id_produto),
	genero varchar(200) not null,
	classificacao int
);

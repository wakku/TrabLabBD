create sequence USUARIO_ID_USUARIO_SEQ;
create sequence COMPRA_ID_COMPRA_SEQ;
create sequence ENDERECO_ID_ENDERECO_SEQ;
create sequence VISUALIZACAO_ID_VISUALIZACAO_SEQ;
create sequence AVALIACAO_ID_AVALIACAO_SEQ;
create sequence PRODUTO_ID_PRODUTO_SEQ;


create table USUARIO(
	id_usuario int primary key default nextval ('USUARIO_ID_USUARIO_SEQ'),
	login varchar(20) not null unique,
	senha varchar(20) not null,
	nome varchar(70) not null,
	cpf char(11) not null unique,
	email varchar(40),
	tipo smallint not null
);

create table TELEFONE(
    usuario int references usuario(id_usuario) on update cascade on delete cascade,
    telefone varchar(15),
    primary key (usuario, telefone)
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
	nota_fiscal int not null,
    preco_total decimal(5,2) not null check (preco > 0),
    promocao decimal(2,2),
	data timestamp default now()
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
    descricao varchar (1000), 
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

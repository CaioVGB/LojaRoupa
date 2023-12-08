show databases;

create database dbEstiloVip;

use dbEstiloVip;

create table fornecedores (
idFornecedor int primary key auto_increment ,
nomeFornecedor varchar(50) not null,
cnpjFornecedor varchar(20) not null,
telefoneFornecedor varchar(20),
emailFornecedor varchar(50) not null unique,
cep varchar(9),
enderecoFornecedor varchar(100),
numeroEndereco varchar(10),
bairro varchar(40),
cidade varchar(40),
estado varchar(2)
);

insert into fornecedores(nomeFornecedor, cnpjFornecedor, emailFornecedor, telefoneFornecedor, cep, enderecoFornecedor, numeroEndereco, bairro, cidade, estado) values ("Caio", "76.465.508/0001-87", "contato@caio.com.br", "(11) 6537-6155", "48291-040", "Rua das Figueiras", "789", "Mairiporã", "Guarulhos", "SP");

select * from fornecedores;

create table produtos (
idProduto int primary key auto_increment,
nomeProduto varchar(50) not null,
descricaoProduto text,
tamanhoProduto enum ("PP","P","M","G","GG","XG"),
precoProduto decimal (10,2) not null,
estoqueProduto int not null,
categoriaProduto enum ("Camisetas", "Bermudas e Shorts", "Calças", "Moletons", "Jaquetas"),
idFornecedor int not null,
foreign key (idFornecedor) references fornecedores(idFornecedor)
);

insert into produtos(nomeProduto, descricaoProduto, tamanhoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Camiseta", "Camiseta com estampa de caveira", "M", "59.90", 50, "Camisetas", 1);

insert into produtos(nomeProduto, descricaoProduto, tamanhoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Calça Jogger", "Calça de sarja preta com bolso lateral", "G", "99.90", 40, "Calças", 1);

insert into produtos(nomeProduto, descricaoProduto, tamanhoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Moletom Canguru", "Moleton com estampa de super-heroi", "G", "129.90", 30, "Moletons", 1);

insert into produtos(nomeProduto, descricaoProduto, tamanhoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Jaqueta", "Jaqueta de couro preta", "G", "399.90", 30, "Jaquetas", 1);

insert into produtos(nomeProduto, descricaoProduto, tamanhoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Bermuda Rasgada", "Bermuda jeans com rasgos", "GG", "69.90", 20, "Bermudas e Shorts", 1);

select * from produtos where categoriaProduto = "Camisetas";

select * from produtos where precoProduto < 100.00 order by precoProduto asc;

create table clientes (
idCliente int primary key auto_increment,
nomeCliente varchar(50),
cpfCliente varchar(15) not null unique,
telefoneCliente varchar(20),
emailCliente varchar(50) unique,
cep varchar(9),
enderecoCliente varchar(100),
numeroEndereco varchar(10),
bairro varchar(40), 
cidade varchar(40),
estado varchar(2)
);

insert into clientes (nomeCliente, cpfCliente, telefoneCliente, emailCliente, cep, enderecoCliente, numeroEndereco, bairro, cidade, estado) values ("Antonio", "768.456.123-93", "(11) 5669-7811", "antoniomultimarcas@gmail.com", "72260-807", "Rua Taijapuru", "779", "Moema", "Sao Paulo", "SP");

select * from clientes;

create table pedidos (
idPedido int primary key auto_increment,
dataPedido timestamp default current_timestamp,
statusPedido enum ("Pendente", "Finalizado", "Cancelado"),
idCliente int not null,
foreign key (idCliente) references clientes(idCliente)
);

insert into pedidos (statusPedido, idCliente) values ("Finalizado", 1);

select * from pedidos inner join clientes on pedidos.idCliente = clientes.idCliente;

create table itensPedidos (
idItensPedidos int primary key auto_increment,
idPedido int not null,
foreign key (idPedido) references pedidos(idPedido),
idProduto int not null,
foreign key (idProduto) references produtos(idProduto),
quantidade int not null
);

insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 1, 2);

insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 2, 1);

select clientes.nomeCliente, clientes.cpfCliente, clientes.emailCliente, pedidos.idPedido, pedidos.statusPedido, pedidos.dataPedido,
produtos.nomeProduto, produtos.tamanhoProduto, produtos.precoProduto, itensPedidos.quantidade from
clientes inner join pedidos on clientes.idCliente = pedidos.idCliente inner join
itensPedidos on itensPedidos.idPedido = pedidos.idPedido inner join produtos
on itensPedidos.idProduto = produtos.idProduto;

select sum(produtos.precoProduto * itensPedidos.quantidade) as Total from produtos inner join itensPedidos on produtos.idProduto = itensPedidos.idProduto where idPedido = 1;

select * from produtos where descricaoProduto like '%Camiseta%';


select * from produtos where categoriaProduto = 'Camisetas' and tamanhoProduto like 'M' and precoProduto <= 69.90;

update itensPedidos inner join produtos on itensPedidos.idProduto = produtos.idProduto
set produtos.estoqueProduto = produtos.estoqueProduto - itensPedidos.quantidade
where itensPedidos.quantidade > 0;

select * from produtos;
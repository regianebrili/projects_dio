drop database ecommerce;

-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- TABELA CLIENTE
create table clients(
	idClient int auto_increment primary key,
    fName varchar(10),
    mInit char(3),
    lName varchar(20),
    CPF char(11) not null,
    address varchar(255),
    constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment=1;
desc clients;

-- TABELA PRODUTO
create table product(
	idProduct int auto_increment primary key,
    pName varchar(255),
    classificationKids bool default false,
    category enum('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliation float default 0,
	value float default 0,
    size varchar(10)
);
alter table product auto_increment=1;
desc product;

-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionados ao pagamento
-- create table payments(
-- 	idClient int,
--  idPayment int,
--  typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
--  limitAvailable float,
--  primary key(idClient, idPayment)
-- );

-- TABELA PEDIDO
create table orders(
	idOrders int auto_increment primary key,
    idOrdersClient int,
    ordersStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em Processamento',
    ordersDescritpion varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrdersClient) references clients(IdClient)
);
alter table orders auto_increment=1;
desc orders;

-- TABELA ESTOQUE
create table storage(
	idStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table storage auto_increment=1;
desc storage;

-- TABELA FORNECEDOR
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;
desc supplier;

-- TABELA VENDEDOR
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    sellerName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);
alter table seller auto_increment=1;
desc seller;

-- RELAÇÃO ENTRE PRODUTO E VENDEDOR
create table productSeller(
    idPSEproduct int,
	idPSEseller int,
    pseQuantity int default 1,
    primary key (idPSEseller, idPSEproduct),
	constraint fk_product_product foreign key (idPSEproduct) references product(idProduct),
    constraint fk_product_seller foreign key (idPSEseller) references seller(idSeller)
);
alter table productSeller auto_increment=1;
desc productSeller;

-- RELAÇÃO ENTRE PRODUTO E PEDIDO
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productOrder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productOrder_order foreign key (idPOorder) references orders(idOrders)
);
desc productOrder;

-- RELAÇÃO ENTRE PRODUTO E ESTOQUE
create table productStorage(
	idPSTproduct int,
    idPSTstorage int,
    pstLocation varchar(255) not null,
    primary key (idPSTproduct, idPSTstorage),
    constraint fk_productStorage_product foreign key (idPSTproduct) references product(idProduct),
    constraint fk_productStorage_location foreign key (idPSTstorage) references storage(idStorage)
);
desc productStorage;

-- RELAÇÃO ENTRE PRODUTO E FORNECEDOR
create table productSupplier(
	idPSUsupplier int,
    idPSUproduct int,
    psuQuantity int not null,
    primary key (idPSUsupplier, idPSUproduct),
    constraint fk_productSupplier_product foreign key (idPSUproduct) references product(idProduct),
    constraint fk_productSupplier_supplier foreign key (idPSUsupplier) references supplier(idSupplier)
);
desc productSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';






















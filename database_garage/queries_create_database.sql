drop database garage;

-- criação do banco de dados para o cenário de E-commerce
create database garage;
use garage;

-- TABELA CLIENTE
create table clients(
	idClient int auto_increment primary key,
    Name varchar(10),
    CPF char(11) not null,
    Phone varchar(255),
    constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment=1;
desc clients;

-- TABELA MODELO
create table model(
	idModel int auto_increment primary key,
	manufacturer varchar(45) not null,
	model varchar(45) not null
);
alter table model auto_increment=1;
desc model;

-- TABELA VEÍCULO
create table vehicles(
	idVehicle int auto_increment primary key,
	idVehicleClient int,
	idVehicleModel int,
    yearManufacture char(9),
    license char(7),
    color varchar(45),
	constraint fk_vehicle_client foreign key (idVehicleClient) references clients(idClient),
	constraint fk_vehicle_model foreign key (idVehicleModel) references Model(idModel)
);
alter table vehicles auto_increment=1;
desc vehicles;

-- TABELA PROFISSIONAL
create table professional(
	idProfessional int auto_increment primary key,
	name varchar(255),
	CPF char(11),
	CNPJ char(15),
	department varchar(45),
	outsourced boolean,
	constraint unique_cpf_professional unique (CPF),
    constraint unique_cnpj_professional unique (CNPJ)
);
alter table professional auto_increment=1;
desc professional;

-- TABELA PEÇAS
create table parts(
	idParts int auto_increment primary key,
	description varchar(255),
	measures char(3),
	unitaryValue float
);
alter table parts auto_increment=1;
desc parts;

-- TABELA SERVIÇO
create table service(
	idService int auto_increment primary key,
	description varchar(45),
	detail blob,
	unitaryValue float,
	estimatedTime time,
	complexity enum ('Baixa', 'Intermediária', 'Alta', 'Especialista')
);
alter table service auto_increment=1;
desc service;

-- TABELA ORDEM DE SERVIÇO
create table serviceOrder(
	idServiceOrder int auto_increment primary key,
	idSOvehicle int,
    issueDate date not null,
    approvalDate date,
    amount float default 0,
    status enum ('Em Análise', 'Em andamento', 'Aguardando Terceiro', 'Aguardando Aprovação', 'Concluído') default 'Em Análise',
	estimatedDelivery date,
    constraint fk_serviceOrder_vehicle foreign key (idSOvehicle) references vehicles(idVehicle)
);
alter table serviceOrder auto_increment=1;
desc serviceOrder;

-- TABELA ITENS DA ORDEM DE SERVIÇO
create table ServiceOrderItems(
    idServiceOrderItems int auto_increment primary key,
	idIserviceOrder int,
    description blob,
	partsValue float,
	serviceValue float,
	initDate date,
	endDate date,
	statusItem enum('Não iniciado', 'Em andamento', 'Aguardando Terceiro', 'Concluído'),
	constraint fk_serviceOrderItems_serviceOrder foreign key (idIserviceOrder) references serviceOrder(idServiceOrder)
);
alter table ServiceOrderItems auto_increment=1;
desc ServiceOrderItems;

-- RELAÇÃO ENTRE ITENS DA ORDEM DE SERVIÇO E PEÇAS
create table partsOfOrder(
	idPOparts int,
    idPOitem int,
    poQuantity int default 1,
    poValue float default 0,
    primary key (idPOparts, idPOitem),
    constraint fk_partsOfOrder_parts foreign key (idPOparts) references parts(idParts),
    constraint fk_partsOfOrder_item foreign key (idPOitem) references ServiceOrderItems(idServiceOrderItems)
);
desc partsOfOrder;

-- RELAÇÃO ENTRE ITENS DE SERVIÇO E SERVIÇO
create table serviceOfOrder(
	idSOservice int,
    idSOitem int,
	soValue float default 0,
    primary key (idSOservice, idSOitem),
    constraint fk_serviceOfOrder_service foreign key (idSOservice) references service(idService),
    constraint fk_serviceOfOrder_item foreign key (idSOitem) references ServiceOrderItems(idServiceOrderItems)
);
desc serviceOfOrder;

-- RELAÇÃO ENTRE PROFISSIONAIS E ORDEM DE SERVIÇO
create table professionalOrder(
	idPOprofessional int,
    idPOorderItem int,
	responsible boolean,	
    primary key (idPOprofessional, idPOorderItem),
    constraint fk_professionalOrder_professional foreign key (idPOprofessional) references professional(idProfessional),
    constraint fk_professionalOrder_orderItem foreign key (idPOorderItem) references ServiceOrderItems(idServiceOrderItems)
);
desc professionalOrder;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'garage';





















create table vehicles(  idVehicle int auto_increment primary key,  idVehicleClient int,  idVehicleModel int,     yearManufacture char(9),     license char(7),     color varchar(45)  constraint fk_vehicle_client foreign key (idVehicleClient) references clients(idClient)  constraint fk_vehicle_model foreign key (idVehicleModel) references Model(idModel) )

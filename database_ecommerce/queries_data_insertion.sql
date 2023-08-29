-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients (fName, mInit, lName, CPF, address)
	   values ('Maria', 'M', 'Silva', 123456789, 'rua silva de prata 29, Carangola - Cidade das Flores'),
			  ('Matheus', 'O', 'Pimentel', 987654321, 'rua alameda 289, Centro - Cidade das Flores'),
              ('Ricardo', 'F', 'Silva', 456789123, 'avenida alameda vinha 1009, Centro - Cidade das Flores'),
              ('Julia', 'S', 'França', 789123456, 'rua laranjeiras 861, Centro - Cidade das Flores'),
              ('Roberta', 'G', 'Assis', 98765431, 'avenida koller 19, Centro - Cidade das Flores'),
              ('Isabela', 'M', 'Cruz', 654789123, 'rua alameda das flores 28, Centro - Cidade das Flores');
              
select * from clients;              
              
-- idProduct, pName, classificationKids, caterogy('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis'), avaliation, size
insert into product (pName, classificationKids, category, avaliation, size)
	   values ('Fone de Ouvido', false, 'Eletrônico', '4', null),
			  ('Barbie Elsa', true, 'Brinquedos', '3', null),
			  ('Body Carters', true, 'Vestuário', '5', null),
			  ('Microfone Vedo - Youtuber', false, 'Eletrônico', '4', null),
			  ('Sofá Retrátil', false, 'Móveis', '3', '3x57x80'),
              ('Farinha de Arroz', false, 'Alimentos', '2', null),
              ('Fire Stick Amazon', false, 'Eletrônico', '3', null);
              
select * from product;

-- idOrdr, idOrdersClient, ordersStatus, ordersDescription, sendValues, paymentCash
insert into orders (idOrdersClient, ordersStatus, ordersDescritpion, sendValue, paymentCash)
	   values (1, default, 'compra via aplicativo', null, 1),
			  (2, default, 'compra via aplicativo', 50, 0),
              (3, 'Confirmado', null, null, 1),
              (4, default, 'compra via web site', 150, 0),
              (2, default, 'compra via aplicativo', null, 1);
       
select * from orders;

-- storageLocation, quantity
insert into storage (storageLocation, quantity)
	   values ('Rio de Janeiro', 1000),
			  ('Rio de Janeiro', 500),
              ('São Paulo', 10),
              ('São Paulo', 100),
              ('São Paulo', 10),
              ('Brasília', 60);
              
select * from storage;

-- idSupplier, socialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact)
	   values ('Almeida e filhos', 123456789123456, '21985474'),
              ('Eletrônicos Silva', 854519649143457, '21985484'),
              ('Eletrônicos Valma', 934567893934695, '21975474');
              
select * from supplier;

-- idSeller, socialName, AbstName, CNPJ, CPF, location, contact
insert into seller (socialName, SellerName, CNPJ, CPF, location, contact)
	   values ('Tech Eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
              ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
              ('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);
              
select * from seller;

-- idPSEproduct, idPSEseller, prodQuantity
insert into productSeller (idPSEproduct, idPSEseller, pseQuantity)
	   values (6, 1, 80),
			  (7, 2, 10);
              
select * from productSeller;

-- idPOproduct, idPOorder, poQuantity, poStatus ('Disponível', 'Sem estoque')
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
       values (1, 1, 2, null),
			  (2, 1, 1, null),
              (3, 2, 1, null);
              
select * from productOrder;

-- idPSTproduct, idPSTstorage, pstLocation
insert into productStorage (idPSTproduct, idPSTstorage, pstLocation)
	   values (1, 1, 'Rio Claro'),
			  (2, 3, 'Parati'),
              (3, 6, 'Brasília');

select * from productStorage;

-- idPSUsupplier, idPSUproduct, quantity
insert into productSupplier (idPSUsupplier, idPSUproduct, psuQuantity)
	   values (1, 1, 500),
			  (1, 2, 400),
              (2, 4, 633),
              (3, 3, 5),
              (2, 5, 10);

select * from productSupplier;
             
select count(*) from clients;
select * from clients c, orders o where c.idClient = o.idOrdersClient;
select fName, lName, idOrders, ordersStatus from clients c, orders o where c.idClient = o.idOrdersClient;
select concat(fName, ' ', lName) as Client, idOrders as Orders, ordersStatus as Status from clients c, orders o where c.idClient = o.idOrdersClient;

select count(*) from clients c, orders o
where c.idClient = o.idOrdersClient
group by c.idClient;

select * from clients
left outer join orders on idClient = idOrdersClient;

-- recuperação de pedidos com produto associado
select * from clients c
inner join orders o ON c.idClient = o.idOrdersClient
inner join productOrder p ON p.idPOorder = o.idOrders;

-- recuperar quantos pedidos foram realizados pelos clientes
select c.idClient, fName, count(*) as Number_of_orders from clients c
inner join orders o ON c.idClient = o.idOrdersClient
group by idClient;

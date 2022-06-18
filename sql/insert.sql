DROP DATABASE IF EXISTS `sql_bitsydb`;
CREATE DATABASE `sql_bitsydb`; 
USE `sql_bitsydb`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;


INSERT INTO seller(`email`, `password`, `shop_name`, `phone`) VALUES
	('a@gmail.com', 'ab', 'Core Factors', 1111111111),
	('b@gmail.com', 'cd', 'Dynatronics', 2222222222),
	('c@gmail.com', 'ef', 'Eco Garden', 3333333333),
	('d@gmail.com', 'gh', 'Etchen', 4444444444),
    ('e@gmail.com', 'ij', 'Fruity', 5555555555),
    ('f@gmail.com', 'kl', 'Desco', 6666666666),
    ('g@gmail.com', 'mn', 'Gallery', 7777777777),
    ('h@gmail.com', 'op', 'Dressify', 8888888888),
    ('i@gmail.com', 'qr', 'Cravers', 9999999999),
    ('j@gmail.com', 'st', 'Clothina', 1212121212);

INSERT INTO product(`item_name`, `seller_id`, `quantity`, `price`) VALUES
	('a', 1, 12, 23.15), ('b', 2, 11, 35.99),
	('c', 3, 13, 32.54), ('d', 4, 11, 13.42),
    ('e', 5, 15, 41.76), ('f', 6, 17, 67.08),
    ('g', 7, 16, 43.11), ('h', 8, 18, 24.13),
    ('i', 9, 14, 87.01), ('j', 10, 16, 99.99),
    ('test', 1, 0, 23.15);
    

INSERT INTO customer(`email`) VALUES
	('a@yahoo.com'), ('b@yahoo.com'),
    ('c@yahoo.com'), ('d@yahoo.com'),
    ('e@yahoo.com'), ('f@yahoo.com'),
    ('g@yahoo.com'), ('h@yahoo.com'),
    ('i@yahoo.com'), ('j@yahoo.com');

INSERT INTO guest(`customer_id`, `email`) VALUES
	('2', 'b@yahoo.com'), ('7', 'g@yahoo.com'),
    ('9', 'i@yahoo.com');

INSERT INTO registered_user(`customer_id`, `email`, `password`, `member_since`, `liked_item`) VALUES
	('1', 'a@yahoo.com', 'ab', '1999-01-22', 'test'),
    ('3', 'c@yahoo.com', 'ef', '2022-02-22', 'c'),
    ('4', 'd@yahoo.com', 'gh', '2021-03-22', 'd'),
    ('5', 'e@yahoo.com', 'ij', '2000-04-22', 'e' ),
    ('6', 'f@yahoo.com', 'kl', '2009-05-22', 'f'),
    ('8', 'h@yahoo.com', 'op', '2014-06-22', 'j'),
    ('10', 'j@yahoo.com', 'st', '2004-07-22', 'h');



INSERT INTO shopping_cart(`product_id`, `customer_id`, `quantity`, `size`) VALUES
	('1', '1', 11, 'S'), ('6', '7', 15, NULL),
    ('2', '2', 13, NULL), ('7', '8', 7, 'XS'),
    ('3', '1', 21, 'M'), ('8', '8', 1, NULL),
    ('4', '5', 2, 'M'), ('9', '8', 1, 'XXL'),
    ('5', '6', 1, 'L'), ('10', '10', 2, NULL);
    
    

INSERT INTO `orders`(`customer_id`, `product_id`, `date_created`, `tracking_num`) VALUES
	('1', '1', '2022-02-22', '1240'), ('2', '2', '2022-02-22', '1241'),
    ('3', '3', '2022-02-22', '1242'), ('4', '4', '2022-02-22', '1243'),
    ('5', '5', '2022-02-22', '1244'), ('5', '6', '2022-02-22', '1245'),
    ('7', '7', '2022-02-22', '1246'), ('9', '8', '2022-02-22', '1247'),
    ('10', '9', '2022-02-22', '1248'), ('10', '10', '2022-02-22', '1249'), ('8', '2', '2022-02-22', '1241');


INSERT INTO `order_summary`(`order_id`, `quantity`, `price`, `date_paid`) VALUES
	('1', '11', '254.65', '2022-02-22'), ('2', '15', '539.85', '2022-02-22'),
    ('3', '13', '423.02', '2022-02-23'), ('4', '7', '93.94', '2022-02-22'),
    ('5', '21', '876.96', '2022-02-22'), ('6', '1', '67.08', '2022-02-23'),
    ('7', '2', '86.22', '2022-02-22'), ('8', '1', '24.13', '2022-02-22'),
    ('9', '1', '87.01', '2022-02-24'), ('10', '2', '199.98', '2022-02-27');

INSERT INTO postal_code(`postal_num`, `city`) VALUES
	('1000', 'asdf'), ('1001', 'escd'),
    ('1002', 'aedsf'), ('1003', 'asxcc'),
    ('1004', 'akihn'), ('1005', 'tunb'),
    ('1006', 'bghvet'), ('1007', 'iuytg'),
    ('1008', 'sdertg'), ('1009', 'poijmn');

INSERT INTO payment(`card_num`, `credit_debit`, `exp_date`, `security_code`, `street_name`, `postal_num`) VALUES
	('12345', 'debit', '2011-09-11', '021', '96 flower rd.', '1000'),
    ('12545', 'credit', '2024-09-11', '453', '12 Walt Whitman St.', '1001'),
    ('12234', 'credit', '2043-09-11', '247', '7462C Fordham St.', '1002'),
    ('27345', 'credit', '2025-09-11', '124', '90 Willow Avenue', '1003'),
    ('67345', 'debit', '2034-09-11', '032', '610 Orchard Road', '1004'),
    ('45645', 'credit', '2023-09-11', '164', '786 Silver Spear Dr.', '1005'),
    ('54376', 'debit', '2029-09-11', '763', '9821 N. New Saddle St.', '1006'),
    ('86972', 'credit', '2044-09-11', '165', '823 Pheasant Court', '1007'),
    ('21356', 'credit', '2025-09-11', '932', '786 Silver Spear Dr.', '1008'),
    ('65479', 'debit', '2031-09-11', '637', '49 Shipley Drive', '1009');

INSERT INTO `invoice_info`(`order_id`, `card_num`, `street_name`, `postal_num`) VALUES
	('1', '12345', '96 flower rd.', '1000'),
    ('2', '12545', '12 Walt Whitman St.', '1001'),
    ('3', '12234', '7462C Fordham St.', '1002'),
    ('4', '27345', '90 Willow Avenue', '1003'),
    ('5', '67345', '610 Orchard Road', '1004'),
    ('6', '45645', '786 Silver Spear Dr.', '1005'),
    ('7', '54376', '9821 N. New Saddle St.', '1006'),
    ('8', '86972', '823 Pheasant Court', '1007'),
    ('9', '21356', '786 Silver Spear Dr.', '1008'),
    ('10', '65479', '49 Shipley Drive', '1009');

INSERT INTO delivery_address(`customer_id`, `street_name`, `postal_num`) VALUES
	('1', '96 flower rd.', '1000'),
    ('2', '12 Walt Whitman St.', '1001'),
    ('3', '7462C Fordham St.', '1002'),
    ('4', '90 Willow Avenue', '1003'),
    ('5', '610 Orchard Road', '1004'),
    ('6', '786 Silver Spear Dr.', '1005'),
    ('7', '9821 N. New Saddle St.', '1006'),
    ('8', '823 Pheasant Court', '1007'),
    ('9', '786 Silver Spear Dr.', '1008'),
    ('10', '49 Shipley Drive', '1009');
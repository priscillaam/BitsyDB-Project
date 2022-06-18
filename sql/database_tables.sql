DROP DATABASE IF EXISTS `sql_bitsydb`;
CREATE DATABASE `sql_bitsydb`; 
USE `sql_bitsydb`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `seller` (
  `seller_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `shop_name` varchar(50) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `seller` VALUES (1,'a','a@gmail.com','ab','Core Factors',1111111111);
INSERT INTO `seller` VALUES (2,'b','b@gmail.com','cd','Dynatronics',2222222222);
INSERT INTO `seller` VALUES (3,'c','c@gmail.com','ef','Eco Garden',3333333333);
INSERT INTO `seller` VALUES (4,'d','d@gmail.com','gh','Etchen',4444444444);
INSERT INTO `seller` VALUES (5,'e','e@gmail.com','ij','Fruity',5555555555);
INSERT INTO `seller` VALUES (6,'f','f@gmail.com','kl','Desco',6666666666);
INSERT INTO `seller` VALUES (7,'g','g@gmail.com','mn','Gallery',7777777777);
INSERT INTO `seller` VALUES (8,'h','h@gmail.com','op','Dressify',8888888888);
INSERT INTO `seller` VALUES (9,'i','i@gmail.com','qr','Cravers',9999999999);
INSERT INTO `seller` VALUES (10,'j','j@gmail.com','st','Clothina',1212121212);


CREATE TABLE `product` (
  `product_id` int(200) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(128) NOT NULL UNIQUE,
  `seller_id` tinyint(4) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  `price` decimal(9,2) NOT NULL default '0.00',
  PRIMARY KEY (`product_id`,`item_name`),
  KEY `FK_seller_id` (`seller_id`),
  CONSTRAINT `FK_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `product` VALUES (120,'a',1,12,23);
INSERT INTO `product` VALUES (121,'b',2,11,35);
INSERT INTO `product` VALUES (122,'c',3,13,32);
INSERT INTO `product` VALUES (123,'d',4,11,13);
INSERT INTO `product` VALUES (124,'e',5,15,41);
INSERT INTO `product` VALUES (125,'f',6,17,67);
INSERT INTO `product` VALUES (126,'g',7,16,43);
INSERT INTO `product` VALUES (127,'h',8,18,24);
INSERT INTO `product` VALUES (128,'i',9,14,87);
INSERT INTO `product` VALUES (129,'j',10,16,99);

CREATE TABLE `customer` (
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `customer` VALUES ('a@yahoo.com','Eric','12345678');
INSERT INTO `customer` VALUES ('b@yahoo.com','N/A','N/A');
INSERT INTO `customer` VALUES ('c@yahoo.com','Tony','34567890');
INSERT INTO `customer` VALUES ('d@yahoo.com','Billy','45678901');
INSERT INTO `customer` VALUES ('e@yahoo.com','Kevin','56789012');
INSERT INTO `customer` VALUES ('f@yahoo.com','Dennis','67890123');
INSERT INTO `customer` VALUES ('g@yahoo.com','N/A','N/A');
INSERT INTO `customer` VALUES ('h@yahoo.com','Henry','89012345');
INSERT INTO `customer` VALUES ('i@yahoo.com','N/A','N/A');
INSERT INTO `customer` VALUES ('j@yahoo.com','Doris','11234567');

CREATE TABLE `shopping_cart` (
  `product_id` int(200) NOT NULL,
  `email` varchar(50) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  `size` varchar(6) NOT NULL,
  PRIMARY KEY (`email`),
  KEY `FK_email` (`email`),
  KEY `FK_product_id` (`product_id`),
  CONSTRAINT `FK_email` FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `shopping_cart` VALUES (120,'a@yahoo.com',12,'M');
INSERT INTO `shopping_cart` VALUES (121,'b@yahoo.com',11,'L');
INSERT INTO `shopping_cart` VALUES (122,'c@yahoo.com',13,'M');
INSERT INTO `shopping_cart` VALUES (123,'d@yahoo.com',11,'S');
INSERT INTO `shopping_cart` VALUES (124,'e@yahoo.com',15,'M');
INSERT INTO `shopping_cart` VALUES (125,'f@yahoo.com',17,'L');
INSERT INTO `shopping_cart` VALUES (126,'g@yahoo.com',16,'S');
INSERT INTO `shopping_cart` VALUES (127,'h@yahoo.com',18,'S');
INSERT INTO `shopping_cart` VALUES (128,'i@yahoo.com',14,'M');
INSERT INTO `shopping_cart` VALUES (129,'j@yahoo.com',16,'L');


CREATE TABLE `guest` (
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`email`),
  KEY `FK_email` (`email`),
  FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `guest` VALUES ('b@yahoo.com');
INSERT INTO `guest` VALUES ('g@yahoo.com');
INSERT INTO `guest` VALUES ('i@yahoo.com');

CREATE TABLE `registered_user` (
  `email` varchar(50) NOT NULL,
  `item_name` varchar(128) NOT NULL,
  `order_id` int(11) NOT NULL,
  `password` varchar(50) NOT NULL,
  `member_since` date NOT NULL,
  PRIMARY KEY (`email`),
  KEY `FK_email` (`email`),
  CONSTRAINT `FK_item_name1`  FOREIGN KEY (`item_name`) REFERENCES `product` (`item_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (`email`) REFERENCES `customer` (`email`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `registered_user` VALUES ('a@yahoo.com','a',110,'ab','1999-01-22');
INSERT INTO `registered_user` VALUES ('c@yahoo.com','c',111,'ef','2022-02-22');
INSERT INTO `registered_user` VALUES ('d@yahoo.com','d',113,'gh','2021-03-22');
INSERT INTO `registered_user` VALUES ('e@yahoo.com','e',114,'ij','2000-04-22');
INSERT INTO `registered_user` VALUES ('f@yahoo.com','f',115,'kl','2009-05-22');
INSERT INTO `registered_user` VALUES ('h@yahoo.com','h',117,'op','2014-06-22');
INSERT INTO `registered_user` VALUES ('j@yahoo.com','j',119,'st','2004-07-22');




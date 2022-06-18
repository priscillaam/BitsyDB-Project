DROP DATABASE IF EXISTS `sql_bitsydb`;
CREATE DATABASE `sql_bitsydb`; 
USE `sql_bitsydb`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;


CREATE TABLE `seller` (
	`seller_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Primary key, ID of seller',
	`email` varchar(50) NOT NULL COMMENT 'email of seller account',
	`password` varchar(50) NOT NULL COMMENT 'password of seller account',
	`shop_name` varchar(50) NOT NULL COMMENT 'seller shop name',
	`phone` varchar(50) DEFAULT NULL COMMENT 'phone number of seller account',
  
	PRIMARY KEY (`seller_id`)
);


CREATE TABLE `product` (
	`product_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key, id of product',
	`item_name` varchar(50) NOT NULL UNIQUE COMMENT 'item name of product',
	`seller_id` tinyint(4) NOT NULL COMMENT 'Foreign Key, id of seller',
	`quantity` tinyint(4) NOT NULL default '1' COMMENT 'quantity of products',
	`price` decimal(9,2) NOT NULL default '0.00' COMMENT 'price of product',
  
	PRIMARY KEY (`product_id`, `item_name`),
	CONSTRAINT `FK_seller_id_product` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`) ON DELETE RESTRICT ON UPDATE CASCADE
);
    

CREATE TABLE `customer` (
	`customer_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
	`email` varchar(50) NOT NULL UNIQUE COMMENT 'email of customer',
  
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE `guest` (
	`customer_id` tinyint(4) NOT NULL COMMENT 'Primary key, Foreign key references customer',
	`email` varchar(50) NOT NULL UNIQUE COMMENT 'email of customer',
  
	PRIMARY KEY (`customer_id`),
	CONSTRAINT `FK_customer_id_guest` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `FK_email_guest` FOREIGN KEY (`email`) REFERENCES `customer`(`email`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `registered_user` (
	`customer_id` tinyint(4) NOT NULL COMMENT 'Primary key and foreign key',
	`email` varchar(50) NOT NULL COMMENT 'Foreign Key, references customer',
	`password` varchar(50) NOT NULL COMMENT 'password',
	`member_since` date NOT NULL COMMENT 'date of membership',
    `liked_item` varchar(50) NOT NULL UNIQUE COMMENT 'item name of users liked product',
  
	PRIMARY KEY (`customer_id`),
	CONSTRAINT `FK_customer_id_registered` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `FK_email_registered` FOREIGN KEY (`email`) REFERENCES `customer`(`email`) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE `shopping_cart` (
	`cart_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key, id of the cart item ',
	`product_id` tinyint(4) NOT NULL COMMENT 'Foreign Key, references product, product id of item ',
	`customer_id` tinyint(4) NOT NULL,
	`quantity` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'quantity of item selected',
	`size` varchar(6) COMMENT 'clothing size',
  
	PRIMARY KEY (`cart_id`),
	CONSTRAINT `FK_product_id_cart` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_customer_id_cart`  FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

    
    
CREATE TABLE `orders` (
	`order_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key, ID of order',
	`customer_id` tinyint(4) NOT NULL,
	`product_id` tinyint(4) NOT NULL COMMENT 'Foreign Key, ID of product',
	`date_created` date NOT NULL COMMENT 'data order was created',
	`tracking_num` int(10) NOT NULL COMMENT 'tracking number of order',
  
	PRIMARY KEY (`order_id`),
	CONSTRAINT `FK_product_id_order` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE `order_summary` (
	`order_id` tinyint(4) NOT NULL COMMENT 'Primary Key, ID of order',
    `quantity` tinyint(4) NOT NULL COMMENT 'number of the product',
    `price` decimal(9,2) NOT NULL COMMENT 'total price',
	`date_paid` date NOT NULL COMMENT 'date order was paid',
  
	PRIMARY KEY (`order_id`),
	CONSTRAINT `FK_order_id_summary` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE `postal_code` (
	`postal_num` int(15) NOT NULL UNIQUE COMMENT 'Primary Key, postal code',
	`city` varchar(50) NOT NULL UNIQUE COMMENT 'city of address',
	PRIMARY KEY (`postal_num`)
);

CREATE TABLE `payment` (
	`card_num` int(50) NOT NULL UNIQUE COMMENT 'Primary Key, number of card ',
	`credit_debit` varchar(20) NOT NULL COMMENT 'type of card',
	`exp_date` date NOT NULL COMMENT 'expiration date',
	`security_code` int(50) NOT NULL COMMENT '3 digit security code',
	`street_name` varchar(50) NOT NULL COMMENT 'street name',
	`postal_num` int(15) NOT NULL COMMENT 'Foreign Key, references Postal Code, postal number',
    
	PRIMARY KEY (`card_num`),
	CONSTRAINT `FK_postal_num_payment` FOREIGN KEY (`postal_num`) REFERENCES `postal_code` (`postal_num`) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE `invoice_info` (
  `invoice_id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key, ID of invoice',
  `order_id` tinyint(4) NOT NULL COMMENT 'Foreign Key, references Order, ID of order',
  `card_num` int(50) NOT NULL COMMENT 'Foreign Key, references Card Num, credit card number',
  `street_name` varchar(50) NOT NULL COMMENT 'billing address, street name',
  `postal_num` int(15) NOT NULL COMMENT 'Foreign Key, references Postal Code, billing address, postal number',
  
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `FK_order_id_invoice` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_card_num_invoice` FOREIGN KEY (`card_num`) REFERENCES `payment` (`card_num`) ON UPDATE CASCADE,
  CONSTRAINT `FK_postal_num_invoice` FOREIGN KEY (`postal_num`) REFERENCES `postal_code` (`postal_num`) ON UPDATE CASCADE
);





CREATE TABLE `delivery_address` (
  `customer_id` tinyint(4) NOT NULL UNIQUE COMMENT 'Foreign key references customer',
  `street_name` varchar(50) NOT NULL COMMENT 'billing address, street name',
  `postal_num` int(15) NOT NULL COMMENT 'Foreign Key, references Postal Code, billing address, postal number',
  
  PRIMARY KEY (`customer_id`, `street_name`),
  CONSTRAINT `FK_customer_id_delivery` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_postal_num_delivery` FOREIGN KEY (`postal_num`) REFERENCES `postal_code` (`postal_num`) ON UPDATE CASCADE
);


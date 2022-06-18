USE sql_bitsydb;

-- The system will return query of a users' order summary
SELECT	order_summary.date_paid, orders.tracking_num, shop_name, 
		seller.email, invoice_info.card_num, credit_debit, invoice_info.street_name, invoice_info.postal_num, city
FROM 	order_summary, orders, invoice_info, seller, payment, postal_code, product
WHERE 	order_summary.order_id = orders.order_id AND orders.product_id = product.product_id AND
		order_summary.order_id = invoice_info.order_id AND invoice_info.card_num = payment.card_num AND
        invoice_info.postal_num = postal_code.postal_num;

-- The system will return a query for registered users' if 'liked item(s)' are out of stock 
SELECT	registered_user.email, registered_user.liked_item, product.quantity
FROM	registered_user, product
WHERE	product.item_name = registered_user.liked_item AND
		product.quantity = 0; 

-- functional requirement: no more than 99 items can be placed in shopping cart by customer --
INSERT INTO shopping_cart(`product_id`, `customer_id`, `quantity`, `size`) VALUES
	('1', '2', '100', 'S');

-- functional requirement: no more than 2 orders for 1 customer --     
INSERT INTO `orders`(`customer_id`, `product_id`, `date_created`, `tracking_num`) VALUES
	('1', '1', '2022-02-22', '1240'), ('1', '1', '2022-02-22', '1241');
    
-- functional requirement: no more than 99 items can be listed by a seller --
INSERT INTO product(`item_name`, `seller_id`, `quantity`, `price`) VALUES
	('p1', 1, 12, 23.15), ('p2', 1, 11, 35.99);

-- change quantity of product
UPDATE product
SET item_name = 'new item'
WHERE seller_id = 4;

select *
FROM product;

-- change quantity of product
UPDATE product
SET quantity = 9
WHERE seller_id = 6;

select *
FROM product;

-- Order history for a customer
SELECT    item_name, order_summary.quantity, order_summary.price, date_paid
FROM     sql_bitsydb.orders, sql_bitsydb.order_summary, sql_bitsydb.product
WHERE    customer_id=5 AND
        sql_bitsydb.orders.order_id=sql_bitsydb.order_summary.order_id AND
        sql_bitsydb.orders.product_id=sql_bitsydb.product.product_id;

-- Which seller is responsible for the order
SELECT    shop_name, email, phone
FROM    sql_bitsydb.orders, sql_bitsydb.product, sql_bitsydb.seller
WHERE    order_id=1 AND
        sql_bitsydb.orders.product_id=sql_bitsydb.product.product_id AND
        sql_bitsydb.product.seller_id=sql_bitsydb.seller.seller_id;
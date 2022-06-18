USE sql_bitsydb;

-- functional requirement: no more than 99 items can be placed in shopping cart by customer --
DELIMITER $$
CREATE TRIGGER max_cart_item
AFTER INSERT
ON shopping_cart
FOR EACH ROW
BEGIN
  SELECT quantity INTO @cnt
  FROM shopping_cart
  WHERE cart_id=(SELECT cart_id FROM shopping_cart WHERE cart_id=(SELECT MAX(cart_id) FROM shopping_cart));
  IF @cnt > 2 THEN
    CALL sth(); -- raise an error
  END IF;
END
$$
DELIMITER ;

-- functional requirement: no more than 3 orders for 1 customer -- 
DELIMITER $$
CREATE TRIGGER max_order_item
AFTER INSERT
ON `orders`
FOR EACH ROW
BEGIN
  SELECT COUNT(*) INTO @cnt
  FROM `orders`
  WHERE product_id=(SELECT product_id FROM `orders` WHERE order_id=(SELECT MAX(order_id) FROM `orders`))
		AND customer_id=(SELECT customer_id FROM `orders` WHERE order_id=(SELECT MAX(order_id) FROM `orders`));
  IF @cnt > 3 THEN
    CALL sth(); -- raise an error
  END IF;
END
$$
DELIMITER ;

-- functional requirement: no more than 99 items can be listed by a seller --
DELIMITER $$
CREATE TRIGGER max_list_item
AFTER INSERT
ON product
FOR EACH ROW
BEGIN
  SELECT COUNT(*) INTO @cnt
  FROM product
  WHERE seller_id=(SELECT seller_id FROM product WHERE product_id=(SELECT MAX(product_id) FROM product));
  IF @cnt > 99 THEN
    CALL sth(); -- raise an error
  END IF;
END
$$
DELIMITER ;

-- functional requirement: the system allows only registered sellers to list products. --

-- functional requirement: error message when product quantity is less than 10 -- 
DELIMITER $$
CREATE TRIGGER `product_running_low` AFTER UPDATE ON `product` FOR EACH ROW 
BEGIN
IF NEW.quantity < 10 THEN
SIGNAL SQLSTATE '45000'
SET message_text = 'Product running low';
end if;
END
$$
DELIMITER ; 

-- functional requirement: seller can change product info -- 
DELIMITER $$
CREATE PROCEDURE change_product_info()
	BEGIN
		UPDATE product 
        SET item_name = new.item_name,
			product_id=new.product_id,
			quantity=new.quantity,
			price=new.price
        WHERE product_id=old.product_id;
	END;
$$
DELIMITER ; 


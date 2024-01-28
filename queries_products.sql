--$ psql -U username -d dbname -f filename.sql 
--table:products,columns:id,name,price,can_be_returned

--1.Add name “chair”,price 44.00,can_be_returned false
INSERT INTO products (name, price, can_be_returned) VALUES ('chair', 44.00, 'f');
SELECT * FROM products WHERE name='chair';--verify chair is in 

-- 2.Add name "stool",price 25.99,can_be_returned true
INSERT INTO products (name, price, can_be_returned) VALUES ('stool', 25.99, 't');
SELECT * FROM products WHERE name='stool';--verify stool is in 

-- 3.Add name "table",price 124.00,can_be_returned false
INSERT INTO products (name, price, can_be_returned) VALUES ('table', 124.00, 'f');
SELECT * FROM products WHERE name='table';--verify table is in

-- 4.Display everything
SELECT * FROM products;--should be 3

-- 5.Display all names
SELECT name FROM products;

-- 6.Display all names,prices
SELECT name, price FROM products;

-- 7.Add a new product(your choice)
INSERT INTO products (name, price, can_be_returned) VALUES ('hammock', 99.00, 't');
SELECT * FROM products WHERE name='hammock';--verify hammock is in

-- 8.Display products that `can_be_returned`
SELECT * FROM products WHERE can_be_returned;

-- 9.Display products with price < 44.00
SELECT * FROM products WHERE price < 44.00;

-- 10.Display products with price between 22.50 and 99.99
SELECT * FROM products WHERE price BETWEEN 22.50 AND 99.99;

-- 11.There's a sale going on: Everything is $20 off.Update database accordingly
UPDATE products SET price = price - 20;
SELECT * FROM products WHERE name='chair';--chair's price should be 24

-- 12.Sale was good:all products < $25 have sold out.Remove products whose price meet this criteria
DELETE FROM products WHERE price < 25;
SELECT * FROM products WHERE name='chair';--should be none, (because chair's price is 24)

-- 13.Sale is over. For remaining products, increase price by $20
UPDATE products SET price = price + 20;
SELECT * FROM products WHERE name='table';--table's price should be 124

-- 14.There's been a change in company policy,now all products are returnable
UPDATE products SET can_be_returned = 't';
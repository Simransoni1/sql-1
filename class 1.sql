create database user;
drop database user;
drop database testdb;
create database testdb;
use testdb;
create table customers(
customername varchar(255),
contactname varchar(255),
address varchar(255),
city varchar(255),
pincode int,
tel int,
country varchar(255) 
);
ALTER TABLE customers
MODIFY tel VARCHAR(20);

select *  from customers;
insert into 
customers(customername,contactname,address,city,pincode,tel,country)
values

('neha','nehal','modeltown','jaipur',305624,9413134793,'india'),
('priyanshi','maina','nadimohalla','ajmer',306454,9509174211,'usa'),
('neheru','naina','azadmohalla','ajmer',306454,9509154211,'usa'),
('navratan','simran','malviynagar','dehli',302017,9024423260,'uk'),
('ankit','simi','bapunagar','bhilwara',301223,9461917752,'asia'),
('sangeeta','shalu','newlightcoloney','bijiangar',306765,7089876543,'europe'),
('paridhi','navya','shastri nagar','dehli',305624,9876543123,'india'),
('yashika','yaavi','modeltown','jaipur',305456,7654321901,'america'),
('vikas','naina','calcity','dehli',678543,5678904321,'australia')

select * from customers where country='india';

select customername,contactname,address from customers
select customername,contactname,address from customers limit 5;
select * from customers where country = "india" and city="delhi";

select * from customers where city="Delhi" order by pincode;
select * from customers where city="Delhi" order by pincode desc;

set sql_safe_updates = 0;
delete from customers where customername = "nav";
update customers set contactname = "Rishi", city = "cal" where customername="simi";
select * from customers;

select * from customers where city="Delhi" and customername="NIkhil";
select * from customers where not country = "India";
select * from customers where pincode between 12347 and 12349;
select count(customername) from customers;
select max(pincode) as largestprice from customers;
insert into 
customers(customername, contactname, address, city, pincode, tel, country)
values
('Suran', 'Rakesh', 'ashok vihar', 'meerut', null, 9999898989, 'India'),
('Shresth', 'Savita', 'Mohali', 'chandigarh', 12346, 8997654321, 'India'),
('Ram', 'Ramesh', 'irish society', 'cork', null, 9765432198, 'Scotland')



select * from customers;
select * from customers where pincode is null;

select * from customers;
set sql_safe_updates = 0;
UPDATE customers
SET city = 'Unknown'
WHERE city = 'NA'; 
CREATE TABLE orders (
    OrderID int,
    CustomerName varchar(255),
    OrderDate date
);   
INSERT INTO 
orders (OrderID, CustomerName, OrderDate) 
VALUES
(1, 'Nikhil', '2023-01-01'),
(2, 'Navdeep', '2023-02-01'),
(3, 'Meghna', '2023-03-01'),
(4, "Kunal", '2023-04-01');
select * from orders;

INSERT INTO 
orders (OrderID, CustomerName, OrderDate) 
VALUES
(5, 'Ayush', '2023-05-01'),
(6, 'Anshul', '2023-06-01');
UPDATE customers
SET CustomerID = (@id := @id + 1)
ORDER BY customername;

alter table customers auto_increment = 1018; 

#example of primary key in multiple cols
CREATE TABLE orders (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);UPDATE customers
SET CustomerID = (@id := @id + 1)
ORDER BY customername;

alter table customers auto_increment = 1018; 

#example of primary key in multiple cols
CREATE TABLE orders (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
); 
select city, count(*) as numberofcustomers
from customers
group by city;

select country, count(*) as numberofcustomers
from customers
group by country;

-- Retrieving customer names along with total orders made by each customer
SELECT CustomerName, COUNT(OrderID) AS TotalOrders
FROM orders
GROUP BY CustomerName;

select * from orders;

-- Using a subquery to find customers who placed an order after '2023-03-01'
SELECT CustomerName FROM orders WHERE OrderDate > '2023-03-01'

SELECT * FROM orders WHERE OrderDate > '2023-03-01'

SELECT * FROM customers
WHERE customername IN (
	SELECT CustomerName FROM orders WHERE OrderDate > '2023-03-01'
);
- Retrieving customers with orders and displaying total amount of orders placed
SELECT customers.customername, COUNT(orders.OrderID) AS TotalOrders
FROM customers
LEFT JOIN orders ON customers.customername = orders.customername
GROUP BY customers.customername;
 - Using COALESCE to handle null values for customers without orders
SELECT customers.customername, COALESCE(COUNT(orders.OrderID),0) AS TotalOrders
FROM customers
LEFT JOIN orders ON customers.customername = orders.customername
GROUP BY customers.customername;
    CASE 
        WHEN COUNT(orders.OrderID) = 0 THEN 1
        ELSE COUNT(orders.OrderID)
    END AS TotalOrders
FROM customers
LEFT JOIN orders 
    ON customers.customername = orders.customername
GROUP BY customers.customername;
insert into 
customers(customername, contactname, address, city, zipcode, tel, country)
values
('Vanshika', 'Nikhil', NULL , 'jaipur', 12345, 9999898989, 'India')

select * from customers;

-- to replace a null in a column
SELECT customername, COALESCE(address, 'No Address Provided') AS address
SELECT * FROM customers;
SELECT 
    customers.customername, 
    COALESCE(SUM(order_id), 0) AS TotalOrders
FROM customers
LEFT JOIN orders 
    ON customers.customername = orders.customername
GROUP BY customers.customername;

SELECT 
    customers.customername, 
    COALESCE(SUM(CASE WHEN orders.OrderID IS NOT NULL THEN 1 END), 1) AS TotalOrders
FROM customers
LEFT JOIN orders 
    ON customers.customername = orders.customername
GROUP BY customers.customername;
SELECT customers.customername, 
       CASE 
           WHEN COUNT(orders.orderid) = 0 THEN 'No Orders'
           WHEN COUNT(orders.orderid) BETWEEN 1 AND 3 THEN 'Low Volume'
           ELSE 'High Volume'
       END AS OrderCategory
FROM orders
RIGHT JOIN customers ON customers.customername = orders.customername
GROUP BY customers.customername;
-- return only customers whose customername appears in the orders table.
select * from orders;

SELECT *
FROM customers
WHERE customername IN (
    SELECT customername
    FROM orders
);

SELECT DISTINCT *
FROM customers c
INNER JOIN orders o
    ON c.customername = o.customername;

SELECT * FROM customers
WHERE EXISTS (
    SELECT 1 FROM orders WHERE orders.customername = customers.customername
);
use testdb;
--creating a view for frequent customers
create view frequentcustomers as
select customername ,zipcode
from customers;
select * from frequentcustomers;

create view fncustomers as 
select customers.customername,count(orders.orderid) as totalorders
from customers
join orders on customers.customername=orders.customername
group by customers.customername;
select * from fcustomers;
--step1:create a temporary table to store unique rows
-- Step 3: Drop the temporary table
DROP TEMPORARY TABLE temp_customers;

ALTER TABLE customers DROP COLUMN email;

select * from customers;
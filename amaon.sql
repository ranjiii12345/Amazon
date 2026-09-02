create database amazon;


-- TASK 3  SPECFIED CITY
select*from amazon.customers;
select * from customers
where city = "South James";

-- TASK3 FRUITS CATEGORY
select * from amazon.products1;
select * from amazon.products1
where category = "Fruits";

-- TASK4 
-- age cannot be null and >18
select*from amazon.customers
 where age is not NULL or Age > 18;
 
 -- unique constraint for name
alter table amazon.customers
 modify Name varchar(100)unique;
    
    -- TASK5
-- insert 3 rows into the products table using insert statements
select * from amazon.products1;
insert into amazon.Products1(ProductID,ProductName,Category,PricePerUnit,StockQuantity)
values
(101, 'Apple', 'Fruits',100, 50),
(102, 'Milk', 'Dairy', 200, 100),
(103, 'Rice', 'Grocery',300, 40),
(104, 'Food', 'Meat', 400, 350);


-- TASK6
-- update tha stock quantity of a product where productid matches a specific id
select * from amazon.products1;
set sql_safe_updates=0;
update amazon.Productsname set stoctquantity=500
where ProductID = 101;

-- TASK7
-- delete a supplier from the suppliers table where their city matches a specific values
select * from amazon.suppliers;
delete from amazon.Suppliers 
where City = "South Debra";

-- TASK8
-- add a check constraint to ensure that ratings in the review table are between 1 and 5
select*from amazon.reviews1;
alter table amazon.reviews1 add check (rating between 1 and 5);


-- add a defult constraint for the primerymember column in the customer table(defult values;"no")
select*from amazon.customers;
alter table amazon.customers modify primerMember varchar(100) default "no";

-- TASK 9
-- where claude to find orders placed after 2024-01-01
select*from amazon.orders
where OrderDate>'2024-01-01';


-- having clause to lists product with average ratings greater then 4
select p.productName,r.productID,avg (r.Rating) from amazon.reviews1 as r
right join amazon.products1 as p
on p.productID = r.productID
group by p.productName,r.productID
having avg(Rating>4);


-- group by and order by clauses to rank product by total sales
select orderID,CustomerID,sum(orderAmount)as totalsales from amazon.orders
group by orderID,customerID
order by sum(OrderAmount) desc;

-- Task10

-- calculate each customer's total spending
select*from amazon.orders;
select a.name, c.customerID,sum(o.OrderAmount)as total_amount from amazon.orders as c
right join amazon.customers as a
on c.customerid = a.customerid
group by a.name,c.customerid;


-- rank customers based on their spending 
select CustomerID,sum(orderamount+DeliveryFee),rank()
over(order by sum(OrderAmount+DeliveryFee)desc) as total_amount from amazon.orders
group by customerID;


-- identify customers who have spent more than 5000
select c.name,c.customerid,sum(OrderAmount)as totalamount
from amazon.customers as c
left join amazon.customers as a
on c.CustomerID = a.customerid
group by c.name,c.CustomerID
having sum(a.OrderAmount)>5000
order by sum(a.OrderAmount) desc;


-- task 11

-- join the order and orderdetails table to calculate total revenue per order
SELECT c.orderID,
       o.customerID,
       SUM(o.orderAmount) AS total_amount
FROM amazon.orders AS o
RIGHT JOIN amazon.order_details AS c
    ON o.orderID = c.orderID
GROUP BY c.orderID, o.customerID;


-- find the supplier with the most product in stock
select SupplierID,sum(stockquantity) as total_stock from amazon.products1
group by SupplierID
order by total_stock desc
limit 3;

-- identify customer who placed the most orderin a specific time period
select c.customerID as customerID,c.name as name,o.orderid from amazon.orders as o
left join amazon.customers as c
on c.customerID = o.customerID
group by o.orderID,name
having o.orderID is null;

-- TASK 12

-- product category and supcategory into a new table
SELECT * from amazon.products1;
create table amazon.products1(productsid varchar(100),product_categories
varchar(100),subcategories varchar(100));
insert into amazon.products1 (product_categories,subcategories)
values("meat","sub-meat"),("scacks","sub-snacks-1"),("backery","sub-backery-1"),("dairy","sub-dairy-3");
select*from amazon.products1;

-- create foreigon key to maintain relationship
alter table amazon.products1 add column productID varchar(100);
insert into amazon.products1(productID)
value("0006853b-74cb-44a2-91ed-699aa31c5b5b");
("21dvrf443433-5453frsg-3545ddf"),("08248vfg-92148hjfhf-9835fuv"),("0946fgf-090964b-98hf");

-- task 13

-- 3 product based on sales revenue
select(select sum(orderAmount)as total_sale from amazon.orders
order by total_sale desc),productID,productName from amazon.products1
group by productID,ProductName
limit 3;

-- find customer who havent't placed any order yet.
select customerID from amazon.orders
where orderID is null;

select (select cumstomerID from amazon.orders
where orderID is null),name from amazon.customers;


-- task14

-- city have the highest concentration of primer members
select distinct city,count(primeMember) as count from amazon.customers
group by city
order by count desc;


-- what are the top 3 most frequency ordered category
select category,count(productID) as order_count from amazon.products1
group by category
order by count(productID) desc
limit 3;
 

-- ==========================================
-- Business Analysis Using SQL
-- Dataset: Customers, Orders, OrderDetails, Items
-- ==========================================

-- 1. Listing all tables in the database
-- Purpose: To identify the available tables for analysis
select name 
from sys.tables;


-- 2. Viewing all main tables
-- Purpose: To understand the data structure and determine relationships
select * from Customers;
select * from Items;
select * from OrderDetails;
select * from Orders;


-- 3. Customers with Order IDs
-- Business Question:
-- Which customers have placed orders, and what are their order IDs?

select c.custid, o.orderid 
from Customers c
inner join Orders o
    on c.custid = o.CustID
order by c.custid;


-- 4. Number of orders per customer
-- Business Question:
-- How many orders has each customer placed?

select c.custid, count(o.orderID) as orderpercust
from Customers c
inner join Orders o
    on c.CustID = o.custid
group by c.custid
order by c.custid;


-- 5. Top 10 customers with the highest number of orders
-- Business Question:
-- Who are the top 10 customers by order frequency?

select top 10 c.custid, count(o.orderID) as orderpercust
from Customers c
inner join Orders o
    on c.CustID = o.custid
group by c.custid
order by orderpercust desc;


-- 6. Customers with the highest number of items in a single order
-- Business Question:
-- Which customers placed orders containing the most items?

select top 10 c.custid, o.OrderID, count(od.ItemID) as itemperorder
from Customers c
inner join Orders o
    on c.CustID = o.CustID
inner join OrderDetails od
    on o.OrderID = od.OrderID
group by c.CustID, o.OrderID
order by itemperorder desc;


-- 7. Total sales amount per order
-- Business Question:
-- What is the total amount spent in each order?

select od.orderid, sum(od.quantity * i.UnitPrice) as amount
from OrderDetails od
inner join Items i
    on i.ItemID = od.ItemID
group by od.orderid
order by amount desc;


-- 8. Number of orders per customer (sorted highest to lowest)
-- Business Question:
-- Which customers have placed the most total orders?

select c.custid, count(o.orderid) as nooforder
from Customers c
inner join Orders o
    on c.custid = o.CustID
group by c.CustID
order by nooforder desc;


-- 9. Total amount spent by each customer
-- Business Question:
-- How much has each customer spent in total?

select c.custid, sum(od.quantity * i.UnitPrice) as amount
from Customers c
inner join Orders o
    on c.custid = o.custid
inner join OrderDetails od
    on o.OrderID = od.OrderID
inner join Items i
    on i.ItemID = od.ItemID
group by c.custid
order by c.custid;


-- 10. Top 10 highest-spending customers
-- Business Question:
-- Who are the top 10 customers by total spending?

select top 10 c.custid, sum(od.quantity * i.UnitPrice) as amount
from Customers c
inner join Orders o
    on c.custid = o.custid
inner join OrderDetails od
    on o.OrderID = od.OrderID
inner join Items i
    on i.ItemID = od.ItemID
group by c.custid
order by amount desc;
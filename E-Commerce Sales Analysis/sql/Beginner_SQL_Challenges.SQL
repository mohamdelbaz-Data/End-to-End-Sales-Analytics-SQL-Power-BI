--1 : all customers
SELECT *
FROM customers;

--2 : Name of products
SELECT ProductName
FROM products;

--3 : products above 100$
SELECT *
FROM products
WHERE Price > 100;

--4 : customers by region
SELECT *
FROM customers
WHERE Region = 'الشمالية';

--5 : products by price
SELECT *
FROM products
ORDER BY Price DESC;


--6 : count of customers
SELECT COUNT(*) AS TotalCustomers
FROM customers;


--7 : AVG price of products
SELECT AVG(Price) AS AvgPrice
FROM products;


--8 : higher product
SELECT MAX(Price) AS HighestPrice
FROM products;


--9 : lower product
SELECT MIN(Price) AS LowestPrice
FROM products;


--10 : quantity sales of product
SELECT SUM(Quantity) AS TotalQuantitySold
FROM orderdetails;

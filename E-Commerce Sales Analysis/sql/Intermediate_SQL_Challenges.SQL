--1 : numbers of products in every category
SELECT Category,
       COUNT(*) AS ProductCount
FROM products
GROUP BY Category;


--2 : AVG price for every category
SELECT Category,
       ROUND(AVG(Price),2) AS AvgPrice
FROM products
GROUP BY Category;


--3 :numbers of customer by region
SELECT Region,
       COUNT(*) AS CustomersCount
FROM customers
GROUP BY Region;


--4 : orders with customer name
SELECT
o.OrderID,
c.CustomerName,
o.OrderDate
FROM orders o
JOIN customers c
ON o.CustomerID = c.CustomerID;


--5 : quantity of product in order
SELECT
od.OrderID,
p.ProductName,
od.Quantity
FROM orderdetails od
JOIN products p
ON od.ProductID = p.ProductID;


--6 : total price for every order
SELECT
OrderID,
SUM(Quantity * UnitPrice) AS OrderValue
FROM orderdetails
GROUP BY OrderID;


--7 : Top 10 products
SELECT
p.ProductName,
SUM(od.Quantity) AS TotalSold
FROM orderdetails od
JOIN products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC
LIMIT 10;


--8 : Top customers pay
SELECT
c.CustomerName,
SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID
JOIN orderdetails od
ON o.OrderID = od.OrderID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;


--9 : total sales by region
SELECT
c.Region,
SUM(od.Quantity * od.UnitPrice) AS Sales
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID
JOIN orderdetails od
ON o.OrderID = od.OrderID
GROUP BY c.Region
ORDER BY Sales DESC;


--10 : total sales by category
SELECT
p.Category,
SUM(od.Quantity * od.UnitPrice) AS Sales
FROM products p
JOIN orderdetails od
ON p.ProductID = od.ProductID
GROUP BY p.Category;


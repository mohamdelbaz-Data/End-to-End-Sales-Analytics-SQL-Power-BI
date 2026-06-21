--1 : sales by month
SELECT 
    MONTH(o.OrderDate) AS Month,
    SUM(od.Quantity * od.UnitPrice) AS Sales
FROM
    orders o
        JOIN
    orderdetails od ON o.OrderID = od.OrderID
GROUP BY Month
ORDER BY Month;


--2 : orders by month
SELECT 
    MONTH(OrderDate) AS Month, COUNT(*) AS OrdersCount
FROM
    orders
GROUP BY Month;


--3 : best month sales
SELECT 
    MONTH(o.OrderDate) AS Month,
    SUM(od.Quantity * od.UnitPrice) AS Sales
FROM
    orders o
        JOIN
    orderdetails od ON o.OrderID = od.OrderID
GROUP BY Month
ORDER BY Sales DESC;


--4 : products above AVG
SELECT 
    *
FROM
    products
WHERE
    Price > (SELECT 
            AVG(Price)
        FROM
            products);


--5 : customers pay above AVG
SELECT 
    *
FROM
    (SELECT 
        c.CustomerName,
            SUM(od.Quantity * od.UnitPrice) AS TotalSpent
    FROM
        customers c
    JOIN orders o ON c.CustomerID = o.CustomerID
    JOIN orderdetails od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerName) t
WHERE
    TotalSpent > (SELECT 
            AVG(TotalSpent)
        FROM
            (SELECT 
                SUM(od.Quantity * od.UnitPrice) AS TotalSpent
            FROM
                customers c
            JOIN orders o ON c.CustomerID = o.CustomerID
            JOIN orderdetails od ON o.OrderID = od.OrderID
            GROUP BY c.CustomerID) x);


--6 : customers rank by sales
SELECT
c.CustomerName,
SUM(od.Quantity * od.UnitPrice) AS TotalSpent,
RANK() OVER(
ORDER BY SUM(od.Quantity * od.UnitPrice) DESC
) AS Ranking
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID
JOIN orderdetails od
ON o.OrderID = od.OrderID
GROUP BY c.CustomerName;


--7 : products rank by sales
SELECT
p.ProductName,
SUM(od.Quantity) AS TotalSold,
DENSE_RANK() OVER(
ORDER BY SUM(od.Quantity) DESC
) AS ProductRank
FROM products p
JOIN orderdetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName;


--8 : percentage of sales by category
SELECT
p.Category,
ROUND(
100 * SUM(od.Quantity * od.UnitPrice) /
SUM(SUM(od.Quantity * od.UnitPrice)) OVER(),
2
) AS Percentage
FROM products p
JOIN orderdetails od
ON p.ProductID = od.ProductID
GROUP BY p.Category;


--9 : customers did not order
SELECT 
    c.*
FROM
    customers c
        LEFT JOIN
    orders o ON c.CustomerID = o.CustomerID
WHERE
    o.OrderID IS NULL;


--10 : products did not sold
SELECT 
    p.*
FROM
    products p
        LEFT JOIN
    orderdetails od ON p.ProductID = od.ProductID
WHERE
    od.ProductID IS NULL;


-- Задания для самостоятельной работы

-- 1
SELECT COUNT(*) AS 'Amount', Color
FROM Production.Product as p
WHERE Color IS NOT NULL AND ListPrice >= 30
GROUP BY Color

-- 2
SELECT Color, MIN(ListPrice) AS 'Min Price'
FROM Production.Product
GROUP BY Color
HAVING MIN(ListPrice) > 100

-- 3
SELECT ProductSubcategoryID, COUNT(*) as 'Amount'
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

-- 4
SELECT COUNT(*) AS 'Sales', ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID

-- 5
SELECT COUNT(*) AS 'Sales', ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(*) > 5

-- 6
SELECT COUNT(*) as 'Amount', CustomerID, OrderDate
FROM Sales.SalesOrderHeader as p
GROUP BY p.CustomerID, p.OrderDate
HAVING COUNT(*) > 1

-- 7
SELECT COUNT(*) AS 'Sales', SalesOrderID
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(ProductID) > 3

-- 8
SELECT COUNT(*) AS 'Sales', ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(*) > 3

-- 9
SELECT COUNT(*) AS 'Sales', ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(*) IN (3, 5)

-- 10
SELECT ProductSubcategoryID, COUNT(*) AS 'Amount'
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING COUNT(*) > 10

-- 11
SELECT COUNT(*) AS 'Sales', ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING MIN(OrderQty) = 1 AND MAX(OrderQty) = 1

-- 12
SELECT TOP(1) SUM(OrderQty) as 'Amount', SalesOrderID
FROM Sales.SalesOrderDetail
WHERE OrderQty IS NOT NULL
GROUP BY SalesOrderID
ORDER BY SUM(OrderQty) DESC

-- 13
SELECT TOP(1) WITH TIES SUM(OrderQty * UnitPrice), SalesOrderID
FROM Sales.SalesOrderDetail
WHERE OrderQty IS NOT NULL AND UnitPrice IS NOT NULL
GROUP BY SalesOrderID
ORDER BY SUM(OrderQty * UnitPrice) DESC

-- 14
SELECT COUNT(*) AS 'Amount', ProductSubcategoryID
FROM Production.Product
WHERE Color IS NOT NULL AND ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

-- 15
SELECT COUNT(*) AS 'Amount', Color
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY Color
ORDER BY COUNT(*) DESC

-- 16
SELECT COUNT(*) AS 'Sales', ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING MIN(OrderQty) > 1 AND COUNT(*) > 2
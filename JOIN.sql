SELECT p.ProductID, MAX(s.UnitPrice) as "Max Price"
FROM Production.Product as p JOIN Sales.SalesOrderDetail as s
ON p.ProductID = s.ProductID
WHERE s.UnitPriceDiscount != 0
GROUP BY p.ProductID
ORDER BY MAX(s.UnitPrice) DESC

SELECT *
FROM Sales.SalesOrderDetail as p
WHERE p.UnitPriceDiscount != 0

-- INNER JOIN - убирает из выборки кортежи обеих таблиц, в которых сравниваемое значение равно NULL
-- LEFT JOIN - убирает из выборки кортежи правой таблицы, в которых сравниваемое значение равно NULL
-- RIGHT JOIN - убирает из выборки кортежи левой таблицы, в которых сравниваемое значение равно NULL

-- Примеры запросов с решениями

SELECT p.Name, s.Name
FROM [Production].[Product] AS p INNER JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM [Production].[Product] AS p LEFT JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name
FROM [Production].[Product] AS p RIGHT JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT *
FROM Production.Product

SELECT *
FROM Production.ProductSubcategory

SELECT *
FROM Production.ProductCategory

SELECT p.Name, s.Name
FROM Production.Product as p RIGHT JOIN Production.ProductSubcategory as s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.ListPrice > 100

SELECT p.Name, s.Name
FROM Production.Product as p LEFT JOIN Production.ProductSubcategory as s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.ListPrice > 100

SELECT p.Name, c.Name
FROM Production.Product as p INNER JOIN Production.ProductSubcategory as s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
INNER JOIN Production.ProductCategory as c
ON s.ProductCategoryID = c.ProductCategoryID

SELECT *
FROM Purchasing.ProductVendor

SELECT p.Name, p.ListPrice, v.LastReceiptCost
FROM Production.Product as p JOIN Purchasing.ProductVendor as v
ON p.ProductID = v.ProductID

SELECT p.Name, p.ListPrice, v.LastReceiptCost
FROM Production.Product as p JOIN Purchasing.ProductVendor as v
ON p.ProductID = v.ProductID
WHERE p.ListPrice != 0 AND p.ListPrice < v.LastReceiptCost

SELECT *
FROM Purchasing.Vendor

SELECT COUNT(DISTINCT pv.ProductID)
FROM Purchasing.ProductVendor as pv JOIN Purchasing.Vendor as v
ON pv.BusinessEntityID = v.BusinessEntityID
WHERE v.CreditRating = 1

SELECT v.CreditRating, COUNT(DISTINCT pv.ProductID) as 'Amount'
FROM Purchasing.ProductVendor as pv JOIN Purchasing.Vendor as v
ON pv.BusinessEntityID = v.BusinessEntityID
GROUP BY v.CreditRating

SELECT TOP 3 WITH TIES p.ProductSubcategoryID, COUNT(p.ProductID) as "Amount"
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY p.ProductSubcategoryID
ORDER BY COUNT(p.ProductID) DESC

SELECT TOP 3 WITH TIES s.Name, s.ProductCategoryID, COUNT(DISTINCT p.ProductID) as 'Amount'
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY s.Name, s.ProductCategoryID
ORDER BY COUNT(DISTINCT p.ProductID) DESC

SELECT CAST(COUNT(DISTINCT p.ProductID) as float) / COUNT(DISTINCT p.ProductSubcategoryID) as "Amount"
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL

SELECT COUNT(DISTINCT p.ProductID) / COUNT(DISTINCT p.ProductSubcategoryID) as "Amount"
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL

-- 11
SELECT s.ProductCategoryID, COUNT(DISTINCT p.ProductID) as 'Amount'
FROM Production.Product as p INNER JOIN Production.ProductSubcategory as s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
GROUP BY s.ProductCategoryID

SELECT  COUNT(DISTINCT p.ProductID) / COUNT(DISTINCT s.ProductCategoryID) as 'Amount'
FROM Production.Product as p INNER JOIN Production.ProductSubcategory as s
ON p.ProductSubcategoryID = s.ProductSubcategoryID

-- 12
SELECT s.ProductCategoryID, COUNT(DISTINCT p.Color) as 'Amount'
FROM Production.Product as p INNER JOIN Production.ProductSubcategory as s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
INNER JOIN Production.ProductCategory as c
ON s.ProductCategoryID = c.ProductCategoryID
WHERE p.Color IS NOT NULL
GROUP BY s.ProductCategoryID

-- 13
SELECT AVG(ISNULL(p.Weight, 10))
FROM Production.Product as p

-- 14
SELECT p.Name, DATEDIFF(DAY, p.SellStartDate, ISNULL(p.SellEndDate, GETDATE())) as 'Days in sell'
FROM Production.Product as p
WHERE p.SellStartDate IS NOT NULL

-- 15
SELECT LEN(p.Name) as "Name length", COUNT(*) as "Amount"
FROM Production.Product as p
GROUP BY LEN(p.Name)

-- 16
SELECT *
FROM Purchasing.ProductVendor

SELECT *
FROM Purchasing.Vendor

SELECT v.BusinessEntityID, COUNT(DISTINCT p.ProductSubcategoryID) as 'Amount'
FROM Purchasing.Vendor as v JOIN Purchasing.ProductVendor as pv
    ON v.BusinessEntityID = pv.BusinessEntityID
JOIN Production.Product as p
    ON p.ProductID = pv.ProductID
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY v.BusinessEntityID

-- 17
SELECT p.Name
FROM Production.Product as p INNER JOIN Production.Product as p1
ON p.ProductID = p1.ProductID
WHERE p.ProductID != p1.ProductID AND p.Name = p1.Name

SELECT p.Name
FROM Production.Product as p
GROUP BY p.Name
having COUNT(*) > 1

-- 18
SELECT TOP 10 WITH TIES p.Name, p.ListPrice
FROM Production.Product as p
ORDER BY p.ListPrice DESC

-- 19
SELECT TOP 10 PERCENT WITH TIES p.Name, p.ListPrice
FROM Production.Product as p
ORDER BY p.ListPrice DESC

-- 20
SELECT *
FROM Purchasing.Vendor

SELECT TOP 3 WITH TIES BusinessEntityID, COUNT(DISTINCT ProductID) as 'Amount'
FROM Purchasing.ProductVendor
GROUP BY BusinessEntityID
ORDER BY COUNT(DISTINCT ProductID) DESC

-- Задания для самостоятельной работы

-- 1
SELECT p.Name, s.Name, p.Color, p.ListPrice
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
    ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.Color = 'Red' AND p.ListPrice > 100

-- 2
SELECT s.Name
FROM Production.ProductSubcategory as s
GROUP BY s.Name
HAVING COUNT(*) > 1

-- 3
SELECT c.Name, COUNT(DISTINCT p.ProductID) as 'Amount'
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
    ON p.ProductSubcategoryID = s.ProductSubcategoryID
        INNER JOIN Production.ProductCategory as c
        ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name

-- 4
SELECT s.Name, COUNT(DISTINCT p.ProductID) as 'Amount'
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
    ON p.ProductSubcategoryID = s.ProductSubcategoryID
GROUP BY s.Name

-- 5
SELECT TOP 3 WITH TIES s.Name, s.ProductSubcategoryID, COUNT(p.ProductID) as 'Amount'
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
    ON p.ProductSubcategoryID = s.ProductSubcategoryID
GROUP BY s.Name, s.ProductSubcategoryID
ORDER BY COUNT(p.ProductID)

-- 6
SELECT TOP 1 WITH TIES s.Name, MAX(p.ListPrice) as 'Max Price'
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
    ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.Color = 'Red'
GROUP BY s.Name
ORDER BY MAX(p.ListPrice) DESC

SELECT TOP 1 WITH TIES s.ProductSubcategoryID, MAX(p.ListPrice) as 'Max Price'
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
    ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.Color = 'Red'
GROUP BY s.ProductSubcategoryID
ORDER BY MAX(p.ListPrice) DESC

SELECT TOP 1 WITH TIES s.Name, s.ProductSubcategoryID, MAX(p.ListPrice) as 'Max Price'
FROM Production.Product as p
    INNER JOIN Production.ProductSubcategory as s
    ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.Color = 'Red'
GROUP BY s.ProductSubcategoryID, s.Name
ORDER BY MAX(p.ListPrice) DESC

-- 7
SELECT v.BusinessEntityID, COUNT(pv.ProductID) as 'Amount'
FROM Purchasing.Vendor AS v
    INNER JOIN Purchasing.ProductVendor AS pv
    ON v.BusinessEntityID = pv.BusinessEntityID
GROUP BY v.BusinessEntityID

-- 8
SELECT p.Name, COUNT(DISTINCT v.Name)
FROM Purchasing.Vendor AS v
    INNER JOIN Purchasing.ProductVendor AS pv
    ON v.BusinessEntityID = pv.BusinessEntityID
        INNER JOIN Production.Product AS p
        ON pv.ProductID = p.ProductID
GROUP BY p.Name
HAVING COUNT(DISTINCT v.Name) > 1

SELECT p.Name, p.ProductID, COUNT(DISTINCT v.Name) AS 'Vendors amount'
FROM Purchasing.Vendor AS v
    INNER JOIN Purchasing.ProductVendor AS pv
    ON v.BusinessEntityID = pv.BusinessEntityID
        INNER JOIN Production.Product AS p
        ON pv.ProductID = p.ProductID
GROUP BY p.Name, p.ProductID
HAVING COUNT(DISTINCT v.Name) > 1

-- 9 (по суммарному количеству купленного)
SELECT TOP 1 WITH TIES p.ProductID, p.Name, SUM(pd.OrderQty) as 'Sales Amount'
FROM Production.Product AS p
    INNER JOIN Purchasing.PurchaseOrderDetail as pd
    ON p.ProductID = pd.ProductID
GROUP BY p.Name, p.ProductID
ORDER BY SUM(pd.OrderQty) DESC

-- 10
SELECT TOP 1 WITH TIES c.ProductCategoryID, c.Name, SUM(pd.OrderQty) as 'Sales Amount'
FROM Production.Product AS p
    INNER JOIN Purchasing.PurchaseOrderDetail as pd
    ON p.ProductID = pd.ProductID
        INNER JOIN Production.ProductSubcategory as s
        ON p.ProductSubcategoryID = s.ProductSubcategoryID
            INNER JOIN Production.ProductCategory as c
            ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.ProductCategoryID, c.Name
ORDER BY SUM(pd.OrderQty) DESC

-- 11 (количество уникальных подкатегорий и количество товаров ВСЕГО)
SELECT c.ProductCategoryID, c.Name as 'Category Name', COUNT(DISTINCT p.ProductSubcategoryID) as 'Subcategories Amount', COUNT(p.ProductID) as 'Products Amount'
FROM Production.Product AS p
    INNER JOIN Purchasing.PurchaseOrderDetail as pd
    ON p.ProductID = pd.ProductID
        INNER JOIN Production.ProductSubcategory as s
        ON p.ProductSubcategoryID = s.ProductSubcategoryID
            INNER JOIN Production.ProductCategory as c
            ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.ProductCategoryID, c.Name

-- Проверяем что категория 1 (Bikes) реально не упоминается в продажах
SELECT *
FROM Purchasing.PurchaseOrderDetail as pd
    INNER JOIN Production.Product as p
    ON pd.ProductID = p.ProductID
        INNER JOIN Production.ProductSubcategory as ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE ps.ProductCategoryID = 1

-- Проверяем что в каждой категории действительно столько подкатегорий
SELECT pc.ProductCategoryID, pc.Name, ps.ProductSubcategoryID
FROM Purchasing.PurchaseOrderDetail as pd
    RIGHT JOIN Production.Product as p
    ON pd.ProductID = p.ProductID
        INNER JOIN Production.ProductSubcategory as ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
            INNER JOIN Production.ProductCategory as pc
            ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.ProductCategoryID = 1

SELECT *
FROM Production.Product
WHERE ProductID IS NULL

-- 12
SELECT v.CreditRating, SUM(d.OrderQty) as 'Amount'
FROM Purchasing.Vendor as v
    INNER JOIN Purchasing.ProductVendor as pv
    ON v.BusinessEntityID = pv.BusinessEntityID
        INNER JOIN Purchasing.PurchaseOrderDetail as d
        ON pv.ProductID = d.ProductID
GROUP BY v.CreditRating
ORDER BY SUM(d.OrderQty) DESC
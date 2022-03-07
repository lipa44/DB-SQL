-- 1
SELECT ProductID
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING COUNT(*) > 3

-- 2
SELECT Color, COUNT(*)
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) BETWEEN 2 AND 5

-- проверка 2
SELECT *
FROM Production.Product
WHERE Color = 'White'

-- 3
SELECT ProductSubcategoryID
FROM Production.Product
WHERE Color = 'Red'
GROUP BY ProductSubcategoryID
HAVING COUNT(*) > 2

-- проверка 3
SELECT ProductSubcategoryID, COUNT(*) as 'Amount'
FROM Production.Product
WHERE Color = 'Red'
GROUP BY ProductSubcategoryID

-- 4
SELECT ProductID
FROM Sales.SalesOrderDetail
WHERE UnitPrice - UnitPriceDiscount > 100
GROUP BY ProductID
HAVING COUNT(*) > 3

-- 5
SELECT [Size], COUNT(*) as 'Amount'
FROM Production.Product as p
WHERE [Size] IS NOT NULL AND Color = 'Red'
GROUP BY [Size]
ORDER BY COUNT(*) DESC

-- 6
SELECT Size, COUNT(*) as 'Amount'
FROM Production.Product
WHERE [Size] IS NOT NULL
GROUP BY Size
HAVING COUNT(*) > 10

-- 7
SELECT TOP(1) WITH TIES ProductID, COUNT(*) as 'Amount'
FROM Sales.SalesOrderDetail
WHERE UnitPrice < 100
GROUP BY ProductID
ORDER BY COUNT(*) DESC

-- 8
SELECT TOP(1) WITH TIES COUNT(DISTINCT Color) as 'Colors amount', ProductSubcategoryID
FROM Production.Product
WHERE Color IS NOT NULL AND ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
ORDER BY COUNT(DISTINCT Color) DESC

-- 9
SELECT ProductID, COUNT(*) as 'Amount'
FROM Sales.SalesOrderDetail
WHERE OrderQty < 3
GROUP BY ProductID
HAVING COUNT(*) > 3

-- 10
SELECT TOP(1) WITH TIES ProductCategoryID, COUNT(ProductSubcategoryID) as 'Amount'
FROM Production.ProductSubcategory
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductCategoryID
ORDER BY COUNT(ProductSubcategoryID) DESC

-- 11
SELECT ProductSubcategoryID, COUNT(*) as 'Amount'
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
HAVING COUNT(ProductID) > 5

-- 12
SELECT ProductSubcategoryID, COUNT(*) as 'Amount'
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL AND Color = 'Red'
GROUP BY ProductSubcategoryID
HAVING COUNT(*) > 5
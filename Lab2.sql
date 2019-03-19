-- Lab 2 – Querying Tables with SELECT 
-- Challenge 1: Retrieve Data for Transportation Reports 

-- 1. Retrieve a list of cities 
SELECT DISTINCT City, StateProvince FROM SalesLT.Address

-- 2. Retrieve the heaviest products (TOP 10 PERCENT)
SELECT TOP 10 PERCENT Name 
FROM SalesLT.Product 
ORDER BY Weight DESC

-- 3. Retrieve the heaviest 100 products not including the heaviest ten (ITEMS) 
SELECT TOP 10 Name, Weight
FROM SalesLT.Product 
ORDER BY Weight DESC

SELECT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC
OFFSET 10 ROWS FETCH FIRST 100 ROWS ONLY

-- Challenge 2: Retrieve Product Data 
-- 1. Retrieve product details for product model 1
SELECT Name, Color, [Size] FROM SalesLT.Product 
WHERE ProductModelID = 1

-- 2. Filter products by color and size 
SELECT ProductNumber, Name FROM SalesLT.Product
WHERE Color IN ('black', 'red', 'white') AND [Size] IN ('S', 'M')

SELECT Name, Color, [Size]
FROM SalesLT.Product
WHERE (Color = 'black' OR Color = 'red' OR Color = 'white')
	AND ([Size]='S' OR [Size] ='M');


-- 3. Filter products by product number 
SELECT ProductNumber, Name, ListPrice FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-%'

-- 4. Retrieve specific products by product number 
SELECT ProductNumber, Name, ListPrice FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[A-QS-Z]%-[0-9][0-9]'
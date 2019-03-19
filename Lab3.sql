-- Lab 3 – Querying Multiple Tables with Joins 

-- Challenge 1: Generate Invoice Reports 
-- 1. Retrieve customer orders
SELECT CompanyName FROM SalesLT.Customer
SELECT SalesOrderID, TotalDue FROM SalesLT.SalesOrderHeader 

-- 2. Retrieve customer orders with addresses
-- Solution 1 --
SELECT T1.FirstName, T1.CompanyName, T2.SalesOrderID, T2.TotalDue, 
		T4.AddressLine1, T4.City, T4.CountryRegion, T4.PostalCode, T4.StateProvince
FROM SalesLT.Customer T1
JOIN SalesLT.SalesOrderHeader T2 ON T1.CustomerID = T2.CustomerID
JOIN SalesLT.CustomerAddress T3 ON T2.CustomerID = T3.CustomerID
JOIN SalesLT.Address T4 ON T4.AddressID = T3.AddressID
WHERE T3.AddressType = 'Main Office'
-- Solution 2 --
SELECT T1.FirstName, T1.CompanyName, T2.SalesOrderID, T2.TotalDue, 
		T4.AddressLine1, T4.City, T4.CountryRegion, T4.PostalCode, T4.StateProvince
FROM SalesLT.Customer T1, SalesLT.SalesOrderHeader T2, 
SalesLT.CustomerAddress T3, SalesLT.Address T4
WHERE T1.CustomerID = T2.CustomerID 
	AND T2.CustomerID = T3.CustomerID 
	AND T4.AddressID = T3.AddressID
	AND T3.AddressType = 'Main Office'

-- Challenge 2: Retrieve Sales Data 
-- 1. Retrieve a list of all customers and their orders 
SELECT T1.CompanyName, T1.FirstName, T1.LastName, T2.SalesOrderID, T2.TotalDue
FROM SalesLT.Customer T1
LEFT JOIN SalesLT.SalesOrderHeader T2 ON T1.CustomerID = T2.CustomerID
ORDER BY T2.SalesOrderID DESC

-- 2. Retrieve a list of customers with no address
SELECT T1.CustomerID, T1.FirstName, T1.LastName, T1.CompanyName, T1.Phone, T2.AddressID
FROM SalesLT.Customer T1
LEFT JOIN SalesLT.CustomerAddress T2 ON T1.CustomerID = T2.CustomerID 
WHERE T2.AddressID IS NULL

-- 3. Retrieve a list of customers and products without orders
-- SOLUTION 1 --
SELECT T1.ProductID, T4.CustomerID FROM SalesLT.Product T1
FULL JOIN SalesLT.SalesOrderDetail T2 ON T1.ProductID = T2.ProductID
FULL JOIN SalesLT.SalesOrderHeader T3 ON T2.SalesOrderID = T3.SalesOrderID
FULL JOIN SalesLT.Customer T4 ON T3.CustomerID = T4.CustomerID
WHERE T2.SalesOrderID IS NULL

-- SOLUTION 2 -- 
SELECT * FROM 
(
	-- Product without any orders --
	SELECT T1.ProductID FROM SalesLT.Product T1
	LEFT JOIN SalesLT.SalesOrderDetail T2 ON T1.ProductID = T2.ProductID
	WHERE T2.SalesOrderID IS NULL
) TT1
FULL JOIN 
(
	-- Customer without any orders --
	SELECT T3.CustomerID FROM SalesLT.Customer T3
	LEFT JOIN SalesLT.SalesOrderHeader T4 ON T3.CustomerID = T4.CustomerID
	WHERE T4.SalesOrderID IS NULL
) TT2
ON TT1.ProductID = TT2.CustomerID
ORDER BY TT1.ProductID DESC

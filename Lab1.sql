-- Lab 1 – Introduction to Transact-SQL
-- Challenge 1: Retrieve Customer Data 
-- 1. Retrieve customer details 
SELECT * FROM SalesLT.Customer;

-- 2. Retrieve customer name data
SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer

-- 3. Retrieve customer names and phone numbers 
SELECT SalesPerson, Title + ' ' + FirstName AS CustomerName, Phone
FROM SalesLT.Customer

-- Challenge 2: Retrieve Customer and Sales Data 
-- 1. Retrieve a list of customer companies
SELECT CAST(CustomerID AS VARCHAR(5)) + ':' + CompanyName AS CustomerCompanies
FROM SalesLT.Customer 

-- Challenge 3: Retrieve Customer Contact Details 
-- 1. Retrieve customer contact names with middle names if known 
SELECT FirstName, MiddleName, LastName, FirstName + ISNULL(MiddleName,'') + LastName
FROM SalesLT.Customer

-- Get primary contact details
UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1;

SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

-- Get shipping status
UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;

SELECT SalesOrderID, OrderDate,
    CASE
      WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
      ELSE 'Shipped'
    END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;

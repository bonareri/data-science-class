DROP database onlinestore;

CREATE DATABASE onlinestore;

USE onlinestore;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    RegistrationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Customers
MODIFY CustomerID INT NOT NULL AUTO_INCREMENT;

INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
('Brian',   'Otieno',    'brian.otieno@email.com',     '0712345678'),
('Akinyi',  'Wanjiku',   'akinyi.wanjiku@email.com',   '0723456789'),
('Kevin',   'Mwangi',    'kevin.mwangi@email.com',    '0734567890'),
('Faith',   'Akinyi',    'faith.akinyi@email.com',    '0745678901'),
('Dennis',  'Omondi',    'dennis.omondi@email.com',   '0756789012'),
('Sharon',  'Chebet',    'sharon.chebet@email.com',   '0767890123'),
('Peter',   'Kiptoo',    'peter.kiptoo@email.com',    '0778901234'),
('Mercy',   'Njeri',     'mercy.njeri@email.com',     '0789012345'),
('Samuel',  'Wekesa',    'samuel.wekesa@email.com',   '0790123456'),
('Cynthia', 'Mutheu',    'cynthia.mutheu@email.com',  '0701234567'),
('Melody',  'Bonareri',  'melodybonareri@gmail.com',  '0727125056');

SELECT * FROM Customers;

DESCRIBE Customers;

## Making changes to the structure
## Change a column definition - allow longer phone numbers
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

## Add a new column - add customer status
ALTER TABLE Customers
ADD Status VARCHAR(20) DEFAULT 'Active';

## Remove a column
ALTER TABLE Customers
DROP COLUMN Status;

## Rename a column  - rename Phone - PhoneNumber
ALTER TABLE Customers
RENAME COLUMN Phone TO PhoneNumber;

## Drop UNIQUE constraint
ALTER TABLE Customers
DROP INDEX Email;

## Add UNIQUE constraint
ALTER TABLE Customers
ADD CONSTRAINT uq_customers_email UNIQUE (Email);

## Update existing data after schema change
UPDATE Customers
SET LastName = 'Kamau'
WHERE CustomerID = 1;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0)
);

# Insert sample data

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES
(1, 'Laptop',        'Electronics', 1189.99, 8),
(2, 'Smartphone',    'Electronics', 799.50, 30),
(3, 'Headphones',    'Accessories', 145.75, 45),
(4, 'Desk Chair',    'Furniture',   215.20, 12),
(5, 'Notebook',      'Stationery',  3.25,   120),
(6, 'Pen',           'Stationery',  1.15,   600),
(7, 'Backpack',      'Accessories', 62.40,  35),
(8, 'Monitor',       'Electronics', 310.99, 18),
(9, 'Coffee Mug',    'Kitchen',     11.80,  80),
(10,'Table Lamp',    'Furniture',   47.25,  25),
(11,'Dish Washer',   'Kitchen',     220.00, 15);

# Update structure
ALTER TABLE Products
MODIFY ProductID INT AUTO_INCREMENT;

# Add a “CreatedAt” column to track when products are added:
ALTER TABLE Products
ADD CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

# Add UNIQUE constraint on ProductName per category:
ALTER TABLE Products
ADD CONSTRAINT uq_product UNIQUE (ProductName, Category);

DESCRIBE Products;
SELECT * FROM Products;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
);

INSERT INTO Orders (CustomerID, Status)
VALUES
(1, 'Completed'),
(2, 'Shipped'),
(3, 'Completed'),
(1, 'Completed'),
(5, 'Pending'),
(6, 'Cancelled'),
(7, 'Shipped'),
(8, 'Completed'),
(9, 'Pending'),
(10, 'Completed');

SELECT * FROM Orders;
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0),

    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON DELETE CASCADE,

    FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
        ON DELETE CASCADE
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
-- Order 1 (high-value electronics + accessories)
(1, 1, 1, 1189.99),
(1, 7, 1, 62.40),
(1, 3, 2, 145.75),

-- Order 2 (electronics bundle - slight discount)
(2, 2, 1, 780.00),
(2, 8, 1, 295.00),

-- Order 3 (bulk stationery - realistic office/student purchase)
(3, 5, 20, 3.00),
(3, 6, 50, 1.00),

-- Order 4 (furniture combo)
(4, 4, 1, 210.00),
(4, 10, 1, 45.00),

-- Order 5 (small household purchase)
(5, 9, 4, 10.50),
(5, 5, 6, 3.25),

-- Order 6 (bulk pens - typical Kenyan office/school buying)
(6, 6, 100, 1.00),

-- Order 7 (accessories focused)
(7, 7, 2, 60.00),
(7, 3, 1, 145.75),

-- Order 8 (premium electronics order)
(8, 1, 1, 1150.00),
(8, 8, 1, 300.00),

-- Order 9 (very small budget order)
(9, 9, 2, 11.80),

-- Order 10 (mixed household + appliance)
(10, 11, 1, 210.00),
(10, 10, 1, 47.25);

SELECT * FROM OrderDetails;

## Selecting Specific Columns
## only the names and emails from customers
SELECT FirstName, LastName, Email FROM Customers;

## Using WHERE to Filter Data
SELECT * FROM Customers
WHERE Email = 'emily.davis@email.com';

## Find products that cost more than $500:
SELECT * FROM Products
WHERE Price > 500;

## Find products in stock less than 20 units:
SELECT * FROM Products
WHERE Stock < 20;

## Show products that cost more than 500 AND have less than 20 in stock.
SELECT * FROM Products
WHERE Price > 500 AND Stock < 20;

# Combining AND and OR
# Show products that are Electronics **AND** cost more than 500 OR have Stock less than 20.
SELECT * FROM Products
WHERE (Category = 'Electronics' AND Price > 500) OR Stock < 20;

# ORDER BY Clause
# Sorting Products by Price (Ascending)
SELECT * FROM Products
ORDER BY Price ASC;

# Sorting Products by Price (Descending)
SELECT * FROM Products
ORDER BY Price DESC;

# Limiting Rows
# Show the top 2 most expensive products.
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 2;

# Combining ORDER BY and LIMIT
# Show the cheapest product in the store.
SELECT * FROM Products
ORDER BY Price ASC
LIMIT 1;

# Using DISTINCT to Remove Duplicates
# List all unique product categories.
SELECT DISTINCT Category FROM Products;

# Combine AND/OR with Sorting
# Show products that are Electronics AND cost more than 500, 
# OR products with Stock less than 20, sorted by Price descending.
SELECT * FROM Products
WHERE (Category = 'Electronics' AND Price > 500) OR Stock < 20
ORDER BY Price DESC;

# UPDATE Statement
SELECT * FROM Customers;

# Updating a Customer’s Phone Number - Let’s say **Jane Smith** changed her phone number.
UPDATE Customers
SET PhoneNumber = '0722222333'
WHERE CustomerID = 2;

# Updating Multiple Columns
# Jane also changed her email and last name.
UPDATE Customers
SET Email = 'jane.mwangi@email.com', LastName = 'Mwangi'
WHERE CustomerID = 2;

# Updating Multiple Rows
SELECT * FROM Products;

# Suppose the store decides to **increase the price of all Electronics by 10%:**
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Electronics';

## MySQL Workbench has Safe Updates mode ON by default.
# Safe Updates prevents UPDATE or DELETE statements that:
# Don’t reference a key column (PRIMARY KEY or UNIQUE) in the WHERE clause
# Or don’t use a LIMIT
# Category is not a key column, so Workbench stops it to avoid accidental mass updates.

# Temporarily disable safe updates for your session
SET SQL_SAFE_UPDATES = 0;

UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Electronics';

SET SQL_SAFE_UPDATES = 1;  -- re-enable after update

# Deleting a Single Product
DELETE FROM Products
WHERE ProductID = 3;

# Deleting Multiple Rows
DELETE FROM Products
WHERE Category = 'Accessories';

# disable safe mode
SET SQL_SAFE_UPDATES = 0;

DELETE FROM Products
WHERE Category = 'Accessories';

SET SQL_SAFE_UPDATES = 1;  -- re-enable after update

#check
SELECT * FROM Products;

# SQL Aggregate Functions
# Counting Rows with COUNT()
# Let’s see how many customers are in our store:
SELECT COUNT(*) AS TotalCustomers FROM Customers;

# Summing Values with SUM()
# Let’s calculate the total value of all orders:
SELECT SUM(TotalAmount) AS TotalSales FROM Orders;

# Calculating the Average with AVG()
# We can find the average price of products:
SELECT AVG(Price) AS AveragePrice FROM Products;

# Finding the Minimum and Maximum with MIN() and MAX()
# Let’s find the cheapest and most expensive products:
SELECT MIN(Price) AS CheapestProduct, MAX(Price) AS MostExpensiveProduct
FROM Products;

# Using Joins
# INNER JOIN — Only Matching Records
# Let’s find all orders along with the customer who placed them.
# We’ll combine `Orders` and `Customers`.

SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.Status
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID;
    
# Orders + OrderDetails
SELECT 
    o.OrderID,
    o.OrderDate,
    od.ProductID,
    od.Quantity,
    od.UnitPrice
FROM Orders o
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID;
    
# Full sales view (Orders + Products)
SELECT 
    o.OrderID,
    p.ProductName,
    p.Category,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS SubTotal
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
INNER JOIN Orders o
    ON od.OrderID = o.OrderID;
    
# FULL CUSTOMER ORDER VIEW
SELECT 
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS TotalLine
FROM Customers c
INNER JOIN Orders o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
INNER JOIN Products p
    ON od.ProductID = p.ProductID;
    
# LEFT JOIN
# show ALL customers, even those with no orders
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID;
    
# LEFT JOIN for products (unpopular products too)
SELECT 
    p.ProductID,
    p.ProductName,
    od.Quantity
FROM Products p
LEFT JOIN OrderDetails od
    ON p.ProductID = od.ProductID;
    
# GROUP BY
-- Total spending per customer
SELECT 
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID;

# GROUP BY + ORDER BY (ranking customers)
SELECT 
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
ORDER BY TotalSpent DESC;

# HAVING clause (filter AFTER grouping)
-- WHERE filters rows
-- HAVING filters groups

-- Customers who spent more than 200
SELECT 
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
HAVING TotalSpent > 200;

# Total quantity per product
SELECT 
    ProductID,
    SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails
GROUP BY ProductID;

# HAVING example on products (best sellers only)
SELECT 
    ProductID,
    SUM(Quantity) AS TotalSold
FROM OrderDetails
GROUP BY ProductID
HAVING TotalSold >= 5;

# Orders per customer
SELECT 
    CustomerID,
    COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

# Case When 
# Classify order value (LOW / MEDIUM / HIGH)
SELECT 
    o.OrderID,
    SUM(od.Quantity * od.UnitPrice) AS TotalAmount,
    CASE 
        WHEN SUM(od.Quantity * od.UnitPrice) >= 1000 THEN 'High Value'
        WHEN SUM(od.Quantity * od.UnitPrice) >= 300 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS OrderCategory
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID;

# Classify customers by spending
SELECT 
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent,
    CASE 
        WHEN SUM(od.Quantity * od.UnitPrice) >= 1000 THEN 'VIP Customer'
        WHEN SUM(od.Quantity * od.UnitPrice) >= 200 THEN 'Regular Customer'
        ELSE 'Low Spender'
    END AS CustomerSegment
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID;

# Stock status (Products table)
SELECT 
    ProductName,
    Stock,
    CASE 
        WHEN Stock = 0 THEN 'Out of Stock'
        WHEN Stock < 10 THEN 'Low Stock'
        WHEN Stock < 50 THEN 'Medium Stock'
        ELSE 'Well Stocked'
    END AS StockStatus
FROM Products;


# Using UNION for Full Outer Join
SELECT c.CustomerID,
       c.FirstName,
       o.OrderID,
       o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID

UNION

SELECT c.CustomerID,
       c.FirstName,
       o.OrderID,
       o.TotalAmount
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID; 

#  UNION - Products That Have Sold vs. Never Sold
SELECT ProductName
FROM Products

UNION

SELECT p.ProductName
FROM OrderDetails od
JOIN Products p
  ON od.ProductID = p.ProductID;
  
# UNION ALL - Products Sold Multiple Times
SELECT p.ProductID, p.ProductName, od.OrderID
FROM Products p
LEFT JOIN OrderDetails od
ON p.ProductID = od.ProductID

UNION

SELECT p.ProductID, p.ProductName, od.OrderID
FROM Products p
RIGHT JOIN OrderDetails od
ON p.ProductID = od.ProductID;

# Key difference:
# UNION combines results.
# JOIN combines tables.

#  INTERSECT - Customers Who Have Placed Orders
# To see only customers who actually placed an order:

SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers
    INTERSECT
    SELECT CustomerID FROM Orders
);

# EXCEPT / MINUS - Customers Who Haven't Placed Orders

SELECT CustomerID, FirstName, LastName
FROM Customers

EXCEPT

SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID;

# Using left join
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

# Using Subqueries in SQL
# Identify Frequent Buyers
SELECT FirstName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(OrderID) > 1
);

# Find Products That Haven’t Sold
SELECT ProductName
FROM Products
WHERE ProductID NOT IN (
    SELECT ProductID
    FROM OrderDetails
);

# Which orders are above the average order total?
SELECT OrderID, TotalAmount
FROM Orders
WHERE TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Orders
);

# Products Sold in High-Value Orders
SELECT ProductName
FROM Products
WHERE ProductID IN (
    SELECT ProductID
    FROM OrderDetails
    WHERE OrderID IN (
        SELECT OrderID
        FROM Orders
        WHERE TotalAmount > 1000
    )
);

# Using CTEs
# marketing team wants a list of customers who place more than one order
-- Define the CTE
WITH CustomerOrderCounts AS (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
)
-- Use the CTE in the main query
SELECT c.FirstName, coc.OrderCount
FROM Customers c
JOIN CustomerOrderCounts coc
ON c.CustomerID = coc.CustomerID
WHERE coc.OrderCount > 1;

# High-Value Orders
# inance team wants to focus on orders above average, 
# but we want to calculate the average once and reuse it.
WITH AvgOrder AS (
    SELECT AVG(TotalAmount) AS AvgTotal
    FROM Orders
)
SELECT OrderID, TotalAmount
FROM Orders, AvgOrder
WHERE TotalAmount > AvgOrder.AvgTotal;

# Top Products by Sales
# sales team wants a list of products with total sales above $500
WITH ProductSales AS (
    SELECT ProductID, SUM(Quantity * UnitPrice) AS TotalSales
    FROM OrderDetails
    GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps
ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

# Window Functions
# Calculate Total Spending per Customer Using SUM()
SELECT 
    CustomerID,
    OrderID,
    TotalAmount,
    SUM(TotalAmount) OVER(PARTITION BY CustomerID) AS TotalSpent
FROM Orders;

# Rank Customers by Total Spending Using RANK()
SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent,
    RANK() OVER(ORDER BY SUM(TotalAmount) DESC) AS SpendingRank
FROM Orders
GROUP BY CustomerID;

# Find the Most Expensive Product in Each Order Using ROW_NUMBER()
SELECT 
    OrderID,
    ProductID,
    UnitPrice,
    ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY UnitPrice DESC) AS RankByPrice
FROM OrderDetails;

# Add More Products Per Order
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
-- Order 1
(1, 1, 1, 1200.00),
(1, 5, 2, 3.50),

-- Order 2
(2, 2, 1, 800.00),
(2, 4, 1, 200.00),
(2, 5, 3, 3.50),

-- Order 3
(3, 1, 1, 1200.00),
(3, 5, 10, 3.50),

-- Order 4
(4, 1, 1, 1200.00),
(4, 2, 1, 800.00),
(4, 9, 3, 12.00),

-- Order 5
(5, 6, 5, 1.20),
(5, 8, 1, 300.00),

-- Order 6
(6, 6, 2, 1.20),
(6, 10, 1, 45.00),

-- Order 7
(7, 8, 1, 300.00),
(7, 4, 1, 200.00),

-- Order 8
(8, 9, 3, 12.00),
(8, 2, 1, 800.00),

-- Order 9
(9, 10, 2, 45.00),
(9, 5, 1, 3.50),

-- Order 10
(10, 1, 1, 1200.00),
(10, 6, 2, 1.20);


SELECT OrderID FROM Orders;

SELECT ProductID, ProductName FROM Products ORDER BY ProductID;

# Using Views
# Total Spending per Customer (Window Function → View)
# Using Window Function
SELECT
    o.OrderID,
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) 
        OVER (PARTITION BY o.CustomerID) AS TotalCustomerSpending
FROM Orders o
JOIN OrderDetails od
    ON o.OrderID = od.OrderID;
    
# This works — but it’s not reusable yet.

# Turn it into a view
CREATE VIEW Customer_Spending_View AS
SELECT
    o.OrderID,
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) 
        OVER (PARTITION BY o.CustomerID) AS TotalCustomerSpending
FROM Orders o
JOIN OrderDetails od
    ON o.OrderID = od.OrderID;
    
# Now you can query it like a table:
SELECT * 
FROM Customer_Spending_View;

# Rank Orders by Value Within Each Customer
# For each customer, how do their orders rank by value?
# Window Function Logic
SELECT
    o.OrderID,
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS OrderValue,
    RANK() OVER (
        PARTITION BY o.CustomerID
        ORDER BY SUM(od.Quantity * od.UnitPrice) DESC
    ) AS OrderRank
FROM Orders o
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.CustomerID;

# Save This as a View
CREATE VIEW Customer_Order_Rankings AS
SELECT
    o.OrderID,
    o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS OrderValue,
    RANK() OVER (
        PARTITION BY o.CustomerID
        ORDER BY SUM(od.Quantity * od.UnitPrice) DESC
    ) AS OrderRank
FROM Orders o
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.CustomerID;

SELECT *
FROM Customer_Order_Rankings;

# Running Total of Sales Over Time
# How does total **sales grow over time?
# Window Function Logic
SELECT
    o.OrderDate,
    SUM(od.Quantity * od.UnitPrice) AS DailySales,
    SUM(SUM(od.Quantity * od.UnitPrice)) 
        OVER (ORDER BY o.OrderDate) AS RunningTotalSales
FROM Orders o
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
GROUP BY o.OrderDate;

# Views in SQL

DROP view Sales_Running_Total;

# UPDATE Orders SET OrderDate = '2026-01-01 10:15:00' WHERE OrderID = 1;
UPDATE Orders SET OrderDate = '2026-01-02 14:20:00' WHERE OrderID = 2;
UPDATE Orders SET OrderDate = '2026-01-03 09:30:00' WHERE OrderID = 3;
UPDATE Orders SET OrderDate = '2026-01-05 16:45:00' WHERE OrderID = 4;
UPDATE Orders SET OrderDate = '2026-02-01 11:00:00' WHERE OrderID = 5;
UPDATE Orders SET OrderDate = '2026-02-15 18:10:00' WHERE OrderID = 6;

ALTER TABLE Orders
ADD Status VARCHAR(20) DEFAULT 'Pending';

UPDATE Orders SET Status = 'Shipped' WHERE OrderID IN (1,2,4);
UPDATE Orders SET Status = 'Cancelled' WHERE OrderID = 5;

SELECT *
FROM Orders
WHERE Status = 'Cancelled';

# Create a Sales Trend View
CREATE VIEW Sales_Running_Total AS
SELECT
    DATE(o.OrderDate) AS OrderDay,
    SUM(od.Quantity * od.UnitPrice) AS DailySales,
    SUM(SUM(od.Quantity * od.UnitPrice)) 
        OVER (ORDER BY DATE(o.OrderDate)) AS RunningTotalSales
FROM Orders o
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
WHERE o.Status <> 'Cancelled'
GROUP BY DATE(o.OrderDate);

SELECT *
FROM Sales_Running_Total;

# Triggeres
# Create a Trigger to Update Stock After an Order
DELIMITER //

CREATE TRIGGER Reduce_Stock_After_Order
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET Stock = Stock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END;
//

DELIMITER ;


#  Test the Trigger
-- Current stock for product 1 (Laptop)
SELECT ProductName, Stock FROM Products WHERE ProductID = 1;

-- Insert into orders
INSERT INTO Orders (CustomerID, TotalAmount)
VALUES 
(3, 200.00),
(4, 880.00);

-- Insert a new order detail (Alice buys 2 Laptops)
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice)
VALUES (12, 11, 4, 2, 200.00),
		(13, 12, 2, 3, 880.00);
        
-- Check updated stock
SELECT ProductName, Stock FROM Products WHERE ProductID = 2;

SELECT * FROM OrderDetails;
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

# Create a Trigger to Log Deleted Orders
CREATE TABLE DeletedOrdersLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    DeletedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CustomerID INT,
    TotalAmount DECIMAL(10,2)
);

DELIMITER //

CREATE TRIGGER Log_Deleted_Orders
BEFORE DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO DeletedOrdersLog (OrderID, CustomerID, TotalAmount)
    VALUES (OLD.OrderID, OLD.CustomerID, OLD.TotalAmount);
END;
//

DELIMITER ;

# Test the Delete Logging Trigger
-- Delete an order
DELETE FROM Orders WHERE OrderID = 3;

-- Check the log
SELECT * FROM DeletedOrdersLog;

# Stored Procedures
# Create a Stored Procedure to Add a New Customer

# Instead of writing a long `INSERT` statement every time a new customer is added, 
# we can create a stored procedure that takes customer details as input 
# and adds them to the `Customers` table.

DELIMITER $$

CREATE PROCEDURE AddCustomer(
	IN p_CustomerID INT,
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_Phone VARCHAR(15)
)
BEGIN
    INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
    VALUES (p_CustomerID, p_FirstName, p_LastName, p_Email, p_Phone);
END $$

DELIMITER ;

DROP Procedure AddCustomer;

# Using the stored procedure
CALL AddCustomer(12, 'Diana', 'Kamau', 'diana@example.com', '0745678901');

SELECT * FROM Customers;

# Create a Stored Procedure to Update Product Stock
DELIMITER $$

CREATE PROCEDURE UpdateStock(
    IN p_ProductID INT,
    IN p_AdditionalStock INT
)
BEGIN
    UPDATE Products
    SET Stock = Stock + p_AdditionalStock
    WHERE ProductID = p_ProductID;
END $$

DELIMITER ;

# Execute the Stock Update Procedure
CALL UpdateStock(1, 5);

SELECT * FROM Products;

# Create a Stored Procedure to Calculate Total Spending per Customer
DELIMITER $$

CREATE PROCEDURE TotalSpending(
    IN p_CustomerID INT
)
BEGIN
    SELECT c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpent
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE c.CustomerID = p_CustomerID
    GROUP BY c.FirstName, c.LastName;
END $$

DELIMITER ;

# Execute the Procedure
CALL TotalSpending(2);










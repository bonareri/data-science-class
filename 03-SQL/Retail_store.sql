CREATE DATABASE test_onlinestore;

USE test_onlinestore;

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

SELECT * FROM OrderDetails;

# Summing Values with SUM()
# Let’s calculate the total value of all orders:
SELECT SUM(Quantity * UnitPrice) AS TotalSales FROM OrderDetails;

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
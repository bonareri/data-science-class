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

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone)
VALUES
(1, 'John',   'Doe',     'john.doe@email.com',   '0711111111'),
(2, 'Jane',   'Smith',   'jane.smith@email.com', '0722222222'),
(3, 'Michael','Brown',   'michael.brown@email.com','0733333333'),
(4, 'Emily',  'Davis',   'emily.davis@email.com','0744444444'),
(5, 'Daniel', 'Wilson',  'daniel.wilson@email.com','0755555555'),
(6, 'Sophia', 'Taylor',  'sophia.taylor@email.com','0766666666'),
(7, 'James',  'Anderson','james.anderson@email.com','0777777777'),
(8, 'Olivia', 'Thomas',  'olivia.thomas@email.com','0788888888'),
(9, 'William','Moore',   'william.moore@email.com','0799999999'),
(10,'Ava',    'Martin',  'ava.martin@email.com', '0700000000');

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

## Change data type
ALTER TABLE Customers
MODIFY RegistrationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

## Add AUTO_INCREMENT to CustomerID
ALTER TABLE Customers
MODIFY CustomerID INT NOT NULL AUTO_INCREMENT;

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
    Stock INT CHECK (Stock >= 0)
);

# Insert sample data

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, 10),
(2, 'Smartphone', 'Electronics', 800.00, 25),
(3, 'Headphones', 'Accessories', 150.00, 50),
(4, 'Desk Chair', 'Furniture', 200.00, 15),
(5, 'Notebook', 'Stationery', 3.50, 100),
(6, 'Pen', 'Stationery', 1.20, 500),
(7, 'Backpack', 'Accessories', 60.00, 40),
(8, 'Monitor', 'Electronics', 300.00, 20),
(9, 'Coffee Mug', 'Kitchen', 12.00, 75),
(10, 'Table Lamp', 'Furniture', 45.00, 30);

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
    CustomerID INT,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

## Insert sample data
INSERT INTO Orders (CustomerID, TotalAmount)
VALUES
(1, 1200.00),
(2, 800.00),
(3, 150.00),
(1, 200.00),
(5, 50.00),
(6, 12.00),
(7, 60.00),
(8, 300.00),
(9, 12.00),
(10, 45.00);

SELECT * FROM Orders;

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) CHECK (UnitPrice >= 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

# Insert sample data
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 1200.00),
(1, 3, 2, 150.00),
(2, 2, 1, 800.00),
(3, 5, 10, 3.50),
(4, 4, 1, 200.00),
(5, 6, 5, 1.20),
(6, 7, 2, 60.00),
(7, 8, 1, 300.00),
(8, 9, 3, 12.00),
(9, 10, 2, 45.00);

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

# Sorting Orders by Multiple Columns
# Sort orders first by `CustomerID` ascending, then by `TotalAmount` descending.
SELECT * FROM Orders
ORDER BY CustomerID ASC, TotalAmount DESC;

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

# Products.ProductID is a parent table in the relationship.
# OrderDetails.ProductID is a child table referencing it.
# MySQL prevents deletion of a parent row if child rows exist that reference it.

SHOW CREATE TABLE OrderDetails;

# How to add ON DELETE CASCADE
# Step 1 — Drop the existing foreign keys
ALTER TABLE orderdetails
DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE orderdetails
DROP FOREIGN KEY orderdetails_ibfk_2;

# Step 2 — Recreate foreign keys with cascade
ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_ibfk_1
FOREIGN KEY (OrderID)
REFERENCES orders(OrderID)
ON DELETE CASCADE;

ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_ibfk_2
FOREIGN KEY (ProductID)
REFERENCES products(ProductID)
ON DELETE CASCADE;

# Make OrderID and ProductID NOT NULL:
ALTER TABLE orderdetails
MODIFY OrderID INT NOT NULL,
MODIFY ProductID INT NOT NULL;


# Now: MySQL automatically deletes all related rows in OrderDetails.
SELECT * FROM Products;
SELECT * FROM OrderDetails;

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










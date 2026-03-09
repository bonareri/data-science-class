// DBML for a School Database

Table Students {
  StudentID int [pk, increment]
  FirstName varchar
  LastName varchar
  Email varchar [unique]
  EnrollmentDate datetime
}

Table Teachers {
  TeacherID int [pk, increment]
  FirstName varchar
  LastName varchar
  Email varchar [unique]
  HireDate datetime
}

Table Courses {
  CourseID int [pk, increment]
  CourseName varchar
  Credits int
  TeacherID int [ref: > Teachers.TeacherID] // each course has one teacher
}

Table Enrollments {
  EnrollmentID int [pk, increment]
  StudentID int [ref: > Students.StudentID]
  CourseID int [ref: > Courses.CourseID]
  EnrollmentDate datetime
  Grade varchar
}

// Explicit cardinalities
// Ref: Courses.TeacherID > Teachers.TeacherID [1..*]       // One teacher can teach many courses
// Ref: Enrollments.StudentID > Students.StudentID [0..*]   // One student can enroll in zero or many courses
// Ref: Enrollments.CourseID > Courses.CourseID [0..*]      // One course can have zero or many students


DROP DATABASE onlineretailstore;

CREATE DATABASE onlineretailstore;

USE onlineretailstore;

# Create Customers Table
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY, 
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL, 
    Phone VARCHAR(15), 
    RegistrationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DESCRIBE Customers;

# Making changes to the structure of the table
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

# Add a new column 
ALTER TABLE Customers
ADD Status VARCHAR(20) DEFAULT 'Active';

# Rename a column
ALTER TABLE Customers
RENAME COLUMN Phone TO PhoneNumber;

# ADD AUTO_INCREMENT
ALTER TABLE Customers
MODIFY CustomerID INT AUTO_INCREMENT;

# INSERT DATA
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber)
VALUES
('John',   'Doe',     'john.doe@email.com',   '0711111111'),
('Jane',   'Smith',   'jane.smith@email.com', '0722222222'),
('Michael','Brown',   'michael.brown@email.com','0733333333'),
('Emily',  'Davis',   'emily.davis@email.com','0744444444'),
('Daniel', 'Wilson',  'daniel.wilson@email.com','0755555555'),
('Sophia', 'Taylor',  'sophia.taylor@email.com','0766666666'),
('James',  'Anderson','james.anderson@email.com','0777777777'),
('Olivia', 'Thomas',  'olivia.thomas@email.com','0788888888'),
('William','Moore',   'william.moore@email.com','0799999999'),
('Ava',    'Martin',  'ava.martin@email.com', '0700000000');

SELECT * FROM Customers;

#Update existing data
UPDATE Customers
SET LastName = 'Kamau'
WHERE CustomerID = 1;

# Create Products table
CREATE TABLE Products (
	ProductID INT PRIMARY KEY AUTO_INCREMENT, 
    ProductName VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) CHECK (Price > 0),
    Stock INT CHECK (Stock >= 0)
);

DESCRIBE Products;

# INSERT DATA
INSERT INTO Products (ProductName, Category, Price, Stock)
VALUES
('Laptop', 'Electronics', 1200.00, 10),
('Smartphone', 'Electronics', 800.00, 25),
('Headphones', 'Accessories', 150.00, 50),
('Desk Chair', 'Furniture', 200.00, 15),
('Notebook', 'Stationery', 3.50, 100),
('Pen', 'Stationery', 1.20, 500),
('Backpack', 'Accessories', 60.00, 40),
('Monitor', 'Electronics', 300.00, 20),
('Coffee Mug', 'Kitchen', 12.00, 75),
('Table Lamp', 'Furniture', 45.00, 30);

SELECT * FROM Products;

# CREATE ORDERS TABLE
CREATE TABLE Orders (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL (10, 2) CHECK (TotalAmount >= 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

#INSERT DATA
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
    UnitPrice DECIMAL(10, 2) CHECK (UnitPrice > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

DESCRIBE OrderDetails;

#INSERT DATA
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

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

# Selecting firstname, lastname and email from customers
SELECT FirstName, LastName, Email FROM Customers;

# Select Emily
SELECT * FROM Customers
WHERE CustomerID = 4;

# Find products that cost more than 500:
SELECT * FROM Products
WHERE Price > 500;

# Stock is less than or equal to 20
SELECT * FROM Products
WHERE Stock <= 20;


SELECT * FROM Products
WHERE Price > 500 AND Stock <= 20;

SELECT * FROM Products
WHERE (Category = 'Electronics' AND Price > 500) OR Stock <= 20;

# ORDER BY
SELECT * FROM Products
ORDER BY Price DESC;

# ORDER BY
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 2;

SELECT *
FROM Customers
WHERE Email = 'jane.smith@email.com';

CREATE INDEX idx_customer_email
ON Customers (Email);

SELECT *
FROM Orders
WHERE CustomerID = 1
AND OrderDate = '2026-03-02 13:14:57';

-- View existing indexes
SHOW INDEXES FROM Customers;

-- Dropping an index
DROP INDEX idx_customer_email
ON Customers;

SELECT * FROM Orders;

# To practice partitioning, it helps
# if your Orders table has many records and different dates.
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2021-01-15', 250.00),
(2, '2021-03-10', 340.00),
(3, '2021-06-21', 120.00),
(4, '2021-09-11', 560.00),
(5, '2021-12-05', 700.00),

(2, '2022-02-14', 430.00),
(3, '2022-04-09', 220.00),
(4, '2022-07-18', 150.00),
(5, '2022-10-30', 620.00),
(6, '2022-12-25', 890.00),

(1, '2023-01-08', 90.00),
(2, '2023-03-17', 300.00),
(3, '2023-05-22', 410.00),
(4, '2023-08-13', 150.00),
(5, '2023-11-29', 770.00),

(6, '2024-01-10', 510.00),
(7, '2024-03-04', 60.00),
(8, '2024-06-15', 820.00),
(9, '2024-09-09', 130.00),
(10, '2024-12-20', 940.00);

# First remember an important MySQL rule:

# When a table is partitioned, the partition column must be part of the PRIMARY KEY.

# we want to partition using OrderDate, so we must modify the table first.

# Partition by YEAR (Range Partitioning)

# Recreate the Table

# Rename the old table

RENAME TABLE Orders TO Orders_old;

# Create the new partitioned table

CREATE TABLE Orders (
	OrderID INT AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),
    PRIMARY KEY (OrderID, OrderDate)
)
PARTITION BY RANGE (YEAR(OrderDate)) (
	PARTITION p2021 VALUES LESS THAN (2022),
	PARTITION p2022 VALUES LESS THAN (2023),
	PARTITION p2023 VALUES LESS THAN (2024),
	PARTITION p2024 VALUES LESS THAN (2025),
	PARTITION p_future VALUES LESS THAN MAXVALUE
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
SELECT OrderID, CustomerID, OrderDate, TotalAmount
FROM Orders_old;

SELECT * FROM Orders;

SELECT * FROM Orders
WHERE OrderDate >= '2026-01-01 00:00:00';







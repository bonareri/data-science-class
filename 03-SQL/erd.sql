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



-- Retail Store Database
Table Customers {
  CustomerID int [pk, increment]
  FirstName varchar(50) [not null]
  LastName varchar(50) [not null]
  Email varchar(70) [not null, unique]
  Phone varchar(20)
}

Table Products {
  ProductID int [pk, increment]
  ProductName varchar(100) [not null]
  Category varchar(50) [not null]
  Price decimal(10,2) [not null]
  Stock int [not null]
  CreatedAT datetime [not null]
}

Table Orders {
  OrderID int [pk, increment]
  CustomerID int [not null]
  OrderDate datetime [not null]
  Status varchar(20)
}

Table OrderDetails {
  OrderDetailID int [pk, increment]
  OrderID int [not null]
  ProductID int [not null]
  Quantity int [not null]
  UnitPrice decimal(10,2) [not null]
}


-- general syntax for relationships
-- Ref: ChildTable.ForeignKey > ParentTable.PrimaryKey [options]


-- Because a primary key is unique while a foreign key can appear multiple times, 
-- dbdiagram.io automatically infers the relationship as: 1 > many 
-- One customer can have many orders.
Ref: Orders.CustomerID > Customers.CustomerID [delete: cascade]

Ref: OrderDetails.OrderID > Orders.OrderID [delete: cascade]

Ref: OrderDetails.ProductID > Products.ProductID [delete: cascade]
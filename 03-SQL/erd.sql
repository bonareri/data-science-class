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
### Case Study: Simple Library Management System

Scenario

A small library wants a simple system to manage books and track borrowing. Each book has:

- Title
- Availability status (Available / Borrowed)

We will use a dictionary to store books.

#### System Requirements

The program should:

1. Display all books and their status
2. Allow a user to borrow a book
3. Allow a user to return a book
4. Prevent borrowing a book that is already borrowed
5. Prevent returning a book that is already available
6. Keep running until the user chooses to exit

#### Extension Ideas 
1. Add a feature to add new books
2. Track who borrowed the book
3. Count total borrowed books
4. Add a search function
5. Limit borrowing to max 2 books per user

### Hospital Patient Management System

#### Scenario
A small clinic wants a simple system to manage patients, track consultations, and assign doctors.  
The system will use a **dictionary-based structure in Python** and store data in a **file for persistence** so that no data is lost when the program stops running.

#### User Requirements

The system must allow a receptionist/clinic staff member to:

1. Add new patients to the system  
2. View all patient records  
3. Search for a patient by name  
4. Assign doctors to patients  
5. Update patient status:
   - Waiting → Under Treatment → Discharged  
6. Discharge patients after treatment  
7. View a summary of all patient statuses  
8. Ensure all patient data is saved and loaded from a file automatically  

#### Data Storage Requirements

1. All patient data must be stored in a file called: patients.txt

2. When the program starts:
- Load all existing patient data from the file into a dictionary

3. During program execution:
- All changes must first update the dictionary in memory

4. After every update:
- The system must save the updated data back to the file

5. If the file does not exist:
- The system must create a new empty file automatically

### Functional Requirements

#### Patient Data Structure
Each patient must be stored using a dictionary with the following details:
- Name
- Age
- Assigned doctor (or None)
- Status (Waiting / Under Treatment / Discharged)

#### Add New Patient
- Add a new patient to the system
- Patient names must be unique
- Default values:
- Doctor = None
- Status = "Waiting"
- Save changes to the file immediately

#### View & Search Patients
- Display all patient records in the system
- Allow searching for patients by name (partial matching allowed)
- If no match is found, display an appropriate message

#### Assign Doctor
- Assign a doctor to a patient
- The system must check that:
- The patient exists
- The patient is not discharged
- The patient does not already have a doctor assigned
- After assignment:
- Status must change to "Under Treatment"
- Save changes to the file immediately

#### Discharge Patient
- Allow discharge only if the patient is under treatment
- After discharge:
- Status becomes "Discharged"
- Doctor assignment is removed
- Save changes to the file immediately

#### Summary Report
- Display a summary showing:
- Number of patients waiting
- Number of patients under treatment
- Number of discharged patients

#### Constraints

1. Patient names must be unique  
2. A patient cannot have more than one doctor assigned at a time  
3. A discharged patient cannot be discharged again  
4. Only valid menu options should be accepted  
5. Data must be stored in dictionaries while the program is running  
6. Data must also be saved and loaded from a file (`patients.txt`)  
7. The system must always keep file data and in-memory data consistent  

#### NB

- Use **functions** to organize your code (e.g., add_patient, assign_doctor, etc.)
- Use **loops** for the menu system and searching records
- Use **conditionals** to validate rules
- Use **file handling** to store and retrieve data
- Use **dictionaries** to manage patient records
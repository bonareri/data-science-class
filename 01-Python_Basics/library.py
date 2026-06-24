library = {
        "Python Basics": "Available",
        "Data science": "Borrowed",
        "Web development": "Available",
        "Machine Learning": "Available"
}

# Function to display the books
def display_books():
    print("\n Library Books")
    for book, status in library.items():
        print(f"{book} - {status}")

# Function to borrow a book
def borrow_book(book_name):
    if book_name in library:
        if library[book_name] == "Available":
            library[book_name] = "Borrowed"
            print(f"You have borrowed {book_name}")
        else:
            print(f"This {book_name} has already been borrowed")
    else:
        print(f"This {book_name} is not available")

# Function to return a book
def return_book(book_name):
    if book_name in library:
        if library[book_name] == "Borrowed":
            library[book_name] = "Available"
            print(f"You have returned {book_name}")
        else:
            print(f"{book_name} was not borrowed")
    else:
        print(f"{book_name} not available in the library")


# Main program 
while True:
    print("\n ----Library Menu-----")
    print("1. Display Books")
    print("2. Borrow Books")
    print("3. Return Books")
    print("4. Exit")

    choice = input("Choose an option: ")

    if choice == "1":
        display_books()

    elif choice == "2":
        book = input("Enter book name to borrow: ")
        borrow_book(book)

    elif choice == "3":
        book = input("Enter book name to return: ")
        return_book(book)

    elif choice == "4":
        print("Goodbye!")
        break

    else: 
        print("Invalid option, try again")


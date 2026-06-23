library = {
    "Python Basics": "Available",
    "Data Science 101": "Borrowed",
    "Web Development": "Available",
    "Machine Learning": "Available"
}

# Function to display books
def show_books():
    print("\nLibrary Books:")
    for book, status in library.items():
        print(f"{book} - {status}")


# Function to borrow a book
def borrow_book(book_name):
    if book_name in library:
        if library[book_name] == "Available":
            library[book_name] = "Borrowed"
            print(f"You have borrowed '{book_name}'")
        else:
            print("Sorry, book is already borrowed")
    else:
        print("Book not found")


# Function to return a book
def return_book(book_name):
    if book_name in library:
        if library[book_name] == "Borrowed":
            library[book_name] = "Available"
            print(f"You have returned '{book_name}'")
        else:
            print("This book was not borrowed")
    else:
        print("Book not found")


# Main program loop
while True:
    print("\n===== LIBRARY MENU =====")
    print("1. Show Books")
    print("2. Borrow Book")
    print("3. Return Book")
    print("4. Exit")

    choice = input("Choose an option: ")

    if choice == "1":
        show_books()

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
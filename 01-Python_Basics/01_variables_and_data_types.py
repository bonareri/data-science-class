'''
1. Variables 
A variable is a name used to store data in memory
You can assign a value using the = operator 
You can assign new values to a variable at any time.
'''

x = 10
name = "Melody"

'''
#Rules for naming variables
Must start with a letter or underscore_
Cannot start with a number
Case sensitive(Age and age are different)
Cannot use python keyword(e.g "If", "Class", "for")
'''

'''
2. Data Types
Str - "Hello" - String(Text)
int - 42 - Integer(Whole number)
float - 3.14 - Float(Decimal)
bool - True, False - Boolean
list -  [1,2,3,] - Ordered, Changeable collection, 
set - {1,2,3} - Unorderd, unique items
dict - {"key" : "value"} - key-value pairs  
'''

#Use type() to check the data type of a variable
#print(type(name))
#print(type(10))

"""3. Input and Output"""
#user input
#name = input("What is your name?")
#print("Hello," + name + "!")


"""4.Type Conversion"""
age = input("Enter your age:")
print(type(age))
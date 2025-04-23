"""
 Two main loops in Python:
for loop → Used when you know how many times you want to repeat.
while loop → Used when you want to repeat until a condition changes.
"""

"""
for i in range(5):
    print("Hello")
for i in range(1, 6):
    print(i, "Hello")
"""

"""While Loop
count = 1

while count <= 5:
    print(count)
    count += 1
"""

"""Print numbers from 1 to 10
#for loop
for i in range(1, 11):
    print(i)

#while loop
i = 1

while i <= 10:
    print(i)
    i += 1
"""

"""Sum of numbers from 1 to 100
total = 0 

for i in range(1, 101):
    total += i

print(f"The total is, ", total)"""

"""Nested Loops
For every single run of the outer loop, the inner loop runs completely.
for outer in range(3):
    for inner in range(2):
        print("Outer:",outer, "| Inner:", inner)
        for row in range(3):
    for column in range(5):
        print("*", end="")
    print()
for row in range(5,0,-1):
    for col in range(row):
        print("*", end="")
    print()
"""

for i in range(5, 0, -1):
    print(i)















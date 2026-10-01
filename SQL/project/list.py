# create a list 
my_list = [1, 2, 3, 4, 5]
print(my_list)
# uppend 6 to 10 in the list
for i in range(6, 11):
    my_list.append(i)
print(my_list)
# dictionary of list
my_dict = {"list": "kefyalew", "last name": "abaroro", "list1": my_list }
print(my_dict)
#  Tuples
my_tuple = (1, 2, 3, 4, 5)
print(my_tuple)

# loops
square = [x**2 for x in my_list]
print(square)
for item in my_tuple:
    print(item)

c = 1
while c <= 8:
    print(c)
    c += 1


# Create a listed called nums containing numbers 1 thru 5

nums = [1, 2, 3, 4, 5]
print(nums)

# Create a list containing the squares of the numbers in your nums list by looping through your list
squares = []
for n in nums:
    squares.append(n**2)
print(squares)
# Map each number in your nums list to a Boolean value by checking whether it is even or odd,find key value pairs in a dictionary and print the result  

is_even = [n % 2 == 0 for n in nums]
print(is_even)
mapping = {n:n%2==0 for n in nums}
print(mapping)

#  create a function that spesifies age as adult else child and greater than 50 as senior citizen
def check_age(age):
    if age >= 18:
        if age > 50:
            return "Senior Citizen"
        else:
            return "Adult"
    else:
        return "Child"
    # uppend the result of the function to a list called age_status for ages 10, 15, 20, and 25 and above 50 senior citizen
ages = [10, 15, 20, 25, 50, 51]
age_status = []
for age in ages:
    status = check_age(age)
    age_status.append(status)
print(age_status)

# write a funtion with index and value as parameters and return the value at the index in the list
def get_value_at_index(index, value):
    if index < len(value):
        return value[index]
    else:
        return "Index out of range"
    #  write Febenacci function that takes a number n as input and returns the nth Fibonacci number
def fibonacci(n):
    if n <= 0:
        return "Input should be a positive integer"
    elif n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        a, b = 0, 1
        for _ in range(2, n):
            a, b = b, a + b
        return b
  




def add(a, b):
    """Return the sum of two numbers"""
    return a + b


def multiply(a, b):
    """Return the product of two numbers"""
    return a * b
def subtract(a, b):
    """Return the difference of two numbers"""
    return a - b
def divide(a, b):
    """Return the quotient of two numbers"""
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
def power(a, b):
    """Return a raised to the power of b"""
    return a ** b
def modulus(a, b):
    """Return the modulus of two numbers"""
    return a % b
def floor_divide(a, b):
    """Return the floor division of two numbers"""
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a // b
def square(a):
    """Return the square of a number"""
    return a * a
def cube(a):
    """Return the cube of a number"""
    return a * a * a
def factorial(n):
    """Return the factorial of a number"""
    if n < 0:
        raise ValueError("Factorial is not defined for negative numbers")
    elif n == 0 or n == 1:
        return 1
    else:
        result = 1
        for i in range(2, n + 1):
            result *= i
        return result
def is_prime(n):
    """Return True if a number is prime, else False"""
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True
def mean(numbers):
    """Return the mean of a list of numbers"""
    if not numbers:
        raise ValueError("The list is empty")
    return sum(numbers) / len(numbers)
def standard_deviation(numbers):
    """Return the standard deviation of a list of numbers"""
    if not numbers:
        raise ValueError("The list is empty")
    mean_value = mean(numbers)
    variance = sum((x - mean_value) ** 2 for x in numbers) / len(numbers)
    return variance ** 0.5  
def median(numbers):
    """Return the median of a list of numbers"""
    if not numbers:
        raise ValueError("The list is empty")
    sorted_numbers = sorted(numbers)
    n = len(sorted_numbers)
    mid = n // 2
    if n % 2 == 0:
        return (sorted_numbers[mid - 1] + sorted_numbers[mid]) / 2
    else:
        return sorted_numbers[mid]
def mode(numbers):
    """Return the mode of a list of numbers"""
    if not numbers:
        raise ValueError("The list is empty")
    frequency = {}
    for number in numbers:
        frequency[number] = frequency.get(number, 0) + 1
    max_freq = max(frequency.values())
    modes = [key for key, value in frequency.items() if value == max_freq]
    return modes
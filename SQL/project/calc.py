
from statistics import mean


def add(a, b):
    return a + b

def multiply(a, b):
    return a * b

def subtract(a, b):
    return a - b

def divide(a, b):
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
def power(a, b):
    return a ** b
def modulus(a, b):
    return a % b
def floor_divide(a, b):
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a // b
def square(a):
    return a ** 2
def cube(a):
    return a ** 3
def factorial(n):
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
        if n <= 1:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return False
        return True
    def mean(numbers):
        if not numbers:
            raise ValueError("The list is empty")
        return sum(numbers) / len(numbers)
    def median(numbers):
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
    if not numbers:
        raise ValueError("The list is empty")
    frequency = {}
    for number in numbers:
        frequency[number] = frequency.get(number, 0) + 1
    max_freq = max(frequency.values())
    modes = [key for key, value in frequency.items() if value == max_freq]
    return modes
def variance(numbers):
    if not numbers:
        raise ValueError("The list is empty")
    mean_value = mean(numbers)
    return sum((x - mean_value) ** 2 for x in numbers) / len(numbers)
def standard_deviation(numbers):
    if not numbers:
        raise ValueError("The list is empty")
    return variance(numbers) ** 0.5




 
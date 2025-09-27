import re

# 1. C++ identifiers: start with letter or underscore, followed by letters, digits, or underscores
identifier_pattern = r"^[A-Za-z_][A-Za-z0-9_]*$"
identifier_tests = ["foo", "_bar123", "9start", "with space"]
print("C++ identifiers:")
for t in identifier_tests:
    print(f"{t:12} -> {bool(re.match(identifier_pattern, t))}")

print()

# 2. U.S. phone numbers: (XXX) XXX-XXXX or XXX-XXX-XXXX
phone_pattern = r"^(\(\d{3}\)\s|\d{3}-)\d{3}-\d{4}$"
phone_tests = ["(123) 456-7890", "123-456-7890", "(555)555-5555", "12-3456-7890"]
print("Phone numbers:")
for t in phone_tests:
    print(f"{t:15} -> {bool(re.match(phone_pattern, t))}")

print()

# 3. Floating point numbers with optional sign and decimal
float_pattern = r"^[+-]?(\d+(\.\d*)?|\.\d+)$"
float_tests = ["3.14", "-0.5", "+42", ".75", "abc"]
print("Floating point numbers:")
for t in float_tests:
    print(f"{t:8} -> {bool(re.match(float_pattern, t))}")

print()

# 4. Binary palindromes of length 3 or 4
palindrome_pattern = r"^(000|010|101|111|0000|0110|1001|1111)$"
palindrome_tests = ["101", "0110", "000", "1001", "0101"]
print("Binary palindromes:")
for t in palindrome_tests:
    print(f"{t:5} -> {bool(re.match(palindrome_pattern, t))}")

import re
import string
import random
import libmyrustlib

# Python ZIP version
def count_doubles(val):
    total = 0
    # there is an improved version later on this post
    for c1, c2 in zip(val, val[1:]):
        if c1 == c2:
            total += 1
    return total


# Python REGEXP version
double_re = re.compile(r'(?=(.)\1)')

def count_doubles_regex(val):
    return len(double_re.findall(val))


# Benchmark it
# generate 1M of random letters to test it
val = ''.join(random.choice(string.ascii_letters) for i in range(1000000))

def test_pure_python(benchmark):
    benchmark(count_doubles, val)

def test_regex(benchmark):
    benchmark(count_doubles_regex, val)

def test_rust(benchmark):   #  <-- Benchmark the Rust version
    benchmark(libmyrustlib.count_doubles, val)

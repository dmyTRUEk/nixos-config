# Init for `interactive_python` alias.

from typing import Callable, Iterator

from sys import argv as cli_args

from time import sleep
from math import *
import itertools

import numpy as np
import matplotlib.pyplot as plt

from pipe import (
	Pipe,
	chain as chain_,
	chain_with as chain_with_,
	dedup as dedup_,
	enumerate as enumerate_,
	filter as filter_leave_,
	groupby as group_by_,
	islice as slice_,
	izip as zip_,
	map as map_,
	permutations as permutations_,
	reverse as reverse_,
	skip as skip_,
	skip_while as skip_while_,
	sort as sort_,
	t as append_,
	tail as tail_,
	take as take_,
	take_while as take_while_,
	tee as tee_,
	transpose as transpose_,
	traverse as traverse_,
	uniq as uniq_,
)


# abcdefghijklmnopqrstuvwxyz

def at[T](l: list[T], index: int) -> T:
	return l[index]

def avg[T](l: list[T]) -> T:
	return sum(l) / len(l)

def diff(a: int | float | complex, b: int | float | complex) -> float | complex:
	return abs(a-b) / (0.5 * (a+b))

def filter_leave[T](it: Iterator[T], pred: Callable[[T], bool]) -> Iterator[T]:
	return (x for x in it if pred(x))

def filter_remove[T](it: Iterator[T], pred: Callable[[T], bool]) -> Iterator[T]:
	return (x for x in it if not pred(x))

def frange(start: float, end: float, step: float):
	x = start
	while x < end:
		yield x
		x += step

def index_of_max[T](l: list[T]) -> int:
	return max(enumerate(l), key=lambda x: x[1])[0]

def index_of_min[T](l: list[T]) -> int:
	return min(enumerate(l), key=lambda x: x[1])[0]

def lerp[T](a: T, b: T, t: float) -> T:
	return a*(1.-t) + b*t

def split_at[T](l: list[T], index: int) -> tuple[list[T], list[T]]:
	return ( l[:index], l[index:] )

def split_at_percentage[T](l: list[T], p: float) -> tuple[list[T], list[T]]:
	return split_at(l, round(len(l) * p))

def std_dev(l: list[float]) -> float:
	avg_value = avg(l)
	return sqrt( sum(map(lambda x: (x-avg_value)**2, l)) / (len(l) - 1) )

def unzip2(xy: Iterator) -> tuple[Iterator, Iterator]:
	xy1, xy2 = itertools.tee(xy)
	return ( (x for x, _ in xy1), (y for _, y in xy2) )

def windows[T](it: Iterator[T] | list[T], window_size: int) -> Iterator[tuple[T, ...]] | list[tuple[T, ...]]:
	it = iter(it)
	res = tuple(next(it) for _ in range(window_size))
	yield res
	for el in it:
		res = res[1:] + (el,)
		yield res


# Pipes:
at_ = Pipe(at)
avg_ = Pipe(avg)
filter_leave_ = Pipe(filter_leave)
filter_remove_ = Pipe(filter_remove)
index_of_max_ = Pipe(index_of_max)
index_of_min_ = Pipe(index_of_min)
list_ = Pipe(list)
np_array_ = Pipe(np.array)
split_at_ = Pipe(split_at)
split_at_percentage_ = Pipe(split_at_percentage)
std_dev_ = Pipe(std_dev)
sum_ = Pipe(sum)
unzip2_ = Pipe(unzip2)
windows_ = Pipe(windows)



def binomial(n: int, m: int) -> int:
	return factorial(n) // (factorial(m) * factorial(n-m))


def xor_encryptor_decryptor(password: str) -> Callable[[str], str]:
	password = str(hash(password))
	def xor_encrypt(text: str) -> str:
		encrypted_l = []
		for i in range(len(text)):
			encrypted_c = ord(password[i%len(password)]) ^ ord(text[i])
			encrypted_l.append(chr(encrypted_c))
		return ''.join(encrypted_l)
	return xor_encrypt

def is_prime(n: int) -> bool:
	if n < 2:
		return False
	if n == 2:
		return True
	if n % 2 == 0:
		return False
	for i in range(3, ceil(sqrt(n))+1, 2):
		if n % i == 0:
			return False
	return True

def factorial_partial(n: int, k: int) -> int:
	# n! / (n-k)!
	return prod(range(n-k+1, n+1))





if __name__ == '__main__':
	import sys
	print(f'Python {sys.version} on {sys.platform}')


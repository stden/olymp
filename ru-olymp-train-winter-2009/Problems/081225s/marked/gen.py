#! /usr/bin/python
TASKNAME = 'marked'
TESTSTR = '%02d'
SMALLTESTS = 12
TOFILES = False

import random, sys
random.seed (hash (TASKNAME))
try:
	import psyco
	psyco.full ()
	sys.stderr.write ('(using psyco)\n')
except:
	sys.stderr.write ('(psyco not available)\n')

MinN, MaxN = 1, 10
MinZ, MaxZ = 0, 1000

test = SMALLTESTS

def out (n, g, h):
	global test
	test += 1
	sys.stderr.write ('Test ' + TESTSTR % test + '\n')
	assert MinN <= n <= MaxN
	m = 1 << n
	x, y = len (g), len (h)
	assert MinZ <= x <= MaxZ
	assert MinZ <= y <= MaxZ
	for i in range (x):
		assert 0 <= g[i] < m
	for i in range (y):
		assert 0 <= h[i] < m
	if TOFILES:
		f = open (TESTSTR % test, 'wt')
	else:
		f = sys.stdout
	f.write ('\n%d %d %d\n' % (n, x, y))
	for i in range (x):
		k = 0
		for j in range (n):
			if (g[i] & (1 << j)) > 0:
				k += 1
		s = '%d' % k
		for j in range (n):
			if (g[i] & (1 << j)) > 0:
				s += ' %d' % (j + 1)
		f.write ('%s\n' % s)
	for i in range (y):
		k = 0
		for j in range (n):
			if (h[i] & (1 << j)) > 0:
				k += 1
		s = '%d' % k
		for j in range (n):
			if (h[i] & (1 << j)) > 0:
				s += ' %d' % (j + 1)
		f.write ('%s\n' % s)
	if TOFILES:
		f.close ()

def genrandom (n, z, lo, hi, mask):
	a = []
	for i in range (z):
		a.append (random.randint (lo, hi) & mask)
	return a

def gencount (n, u, v, b):
	a = []
	for i in range (u):
		k = 0
		for j in range (b):
			while True:
				p = random.randrange (n)
				if (k & (1 << p)) == 0:
					k |= 1 << p
					break
		a += genrandom (n, v, 0, (1 << n) - 1, k)
	return a

random.seed (hash ('marked'))
# Small tests
for n in [7, 9, 10]:
	for z in [10, 100, 1000]:
		g = genrandom (n, random.randint (1, z),
		 0, (1 << n) - 1, (1 << n) - 1)
		h = genrandom (n, random.randint (1, z),
		 0, (1 << n) - 1, (1 << n) - 1)
		out (n, g, h)
		h = genrandom (n, random.randrange (random.randrange (z) + 1),
		 0, (1 << n) - 1, (1 << n) - 1)
		out (n, g, h)
		h = genrandom (n, random.randint (1, z),
		 0, random.randrange (1 << n), random.randrange (1 << n))
		out (n, g, h)
		g = genrandom (n, z,
		 random.randrange (1 << n), (1 << n) - 1, (1 << n) - 1)
		h = genrandom (n, z,
		 0, (1 << n) - 1, (1 << n) - 1)
		out (n, g, h)
		g = gencount (n, 10, z / 10, n - 1)
		h = gencount (n, z / 10, 10, n - 2)
		out (n, g, h)
		h = gencount (n, z / 5, 5, n - 2)
		g = gencount (n, 5, z / 5, n - 3)
		out (n, g, h)

# Medium tests
out (9, [(1 << 9) - 1] * 100, [(1 << 9) - 3] * 100)
out (10, [(1 << 9) - 14] * 100, [(1 << 8) - 3] * 100)

# Large tests
out (9, [(1 << 9) - 1] * 1000, [(1 << 9) - 3] * 1000)
out (10, [(1 << 9) - 14] * 1000, [(1 << 8) - 3] * 1000)
out (10, range (1000), [])
out (10, range (24, 1024), [])
out (10, range (1000), range (543, 711))

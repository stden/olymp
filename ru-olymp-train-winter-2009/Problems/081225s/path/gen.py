#! /usr/bin/python
TASKNAME = 'path'
TESTSTR = '%02d'
SMALLTESTS = 33
TOFILES = False

import random, sys
random.seed (hash (TASKNAME))
try:
	import psyco
	psyco.full ()
	sys.stderr.write ('(using psyco)\n')
except:
	sys.stderr.write ('(psyco not available)\n')

MinN, MaxN = 1, 22
MinM, MaxM = 0, 1000

test = SMALLTESTS

def out (a):
	global test
	test += 1
	sys.stderr.write ('Test ' + TESTSTR % test + '\n')
	n = len (a)
	assert MinN <= n <= MaxN
	m = 0
	for i in range (n):
		assert n == len (a[i])
		for j in range (n):
			assert a[i][j] in [False, True]
			m += a[i][j]
	assert MinM <= m <= MaxM
	if TOFILES:
		f = open (TESTSTR % test, 'wt')
	else:
		f = sys.stdout
	f.write ('\n%d %d\n' % (n, m))
	for i in range (n):
		for j in range (n):
			if a[i][j]:
				f.write ('%d %d\n' % (i + 1, j + 1))
	if TOFILES:
		f.close ()

def init (n):
	a = []
	for i in range (n):
		a.append ([False] * n)
	return a

def genrandom (a, k, mask):
	n = len (a)
	b = []
	for i in range (n):
		if (mask & (1 << i)) > 0:
			b.append (i)
	z = len (b)
	assert z > 0
	for i in range (k):
		x = random.randrange (z)
		y = random.randrange (z)
		a[b[x]][b[y]] = True
	return a

def genorder (a, k, mask, p):
	n = len (a)
	b = []
	for i in range (n):
		if (mask & (1 << i)) > 0:
			b.append (i)
	z = len (b)
	assert z > 0
	for i in range (k):
		x = random.randrange (z)
		y = random.randrange (z)
		if p[b[x]] < p[b[y]]:
			a[x][y] = True
	return a

def twoparts (n, k):
	u = (1 << k) - 1
	v = (1 << n) - 1 - u
	a = init (n)
	a = genrandom (a, 100, u)
	a = genrandom (a, 120, v)
	out (a)
	p = range (n)
	random.shuffle (p)
	a = genorder (a, 10, (1 << n) - 1, p)
	out (a)

def increase (n, x, y, s = 0):
	a = init (n)
	a = genrandom (a, s, (1 << n) - 1)
	out (a)
	for k in range (x):
		a = genrandom (a, y, (1 << n) - 1)
		out (a)

def orderincrease (n, x, y, s = 0):
	a = init (n)
	p = range (n)
	random.shuffle (p)
	a = genorder (a, s, (1 << n) - 1, p)
	out (a)
	for k in range (x):
		a = genorder (a, y, (1 << n) - 1, p)
		out (a)

def increaseorder (n, x, y, s = 0):
	a = init (n)
	p = range (n)
	random.shuffle (p)
	a = genorder (a, s, (1 << n) - 1, p)
	out (a)
	for k in range (x):
		p = range (n)
		random.shuffle (p)
		a = genorder (a, y, (1 << n) - 1, p)
		out (a)

# Small tests
for n in range (5, 10):
	a = init (n)
	a = genrandom (a, 10, (1 << n) - 1)
	p = range (n)
	random.shuffle (p)
	a = genorder (a, 10, random.randrange (1 << n), p)
	out (a)

# Medium tests
twoparts (11, 7 / 2)
twoparts (12, 5)
increase (13, 4, 10, 15)
orderincrease (14, 4, 7, 20)
increaseorder (15, 4, 8, 21)
for n in range (10, MaxN + 1):
	a = init (n)
	a = genrandom (a, 4 * n, (1 << n) - 1)
	p = range (n)
	random.shuffle (p)
	a = genorder (a, 3 * n, random.randrange (1 << n), p)
	out (a)

# Large tests
twoparts (MaxN, MaxN / 2)
twoparts (MaxN, 5)
twoparts (MaxN, 2)
twoparts (MaxN, 1)

n = 21
k = 7
u = (1 << k) - 1
v = u << k
w = v << k
a = init (n)
a = genrandom (a, 80, u)
a = genrandom (a, 90, v)
a = genrandom (a, 70, w)
out (a)
p = range (n)
random.shuffle (p)
a = genorder (a, 10, (1 << n) - 1, p)
out (a)

increase (MaxN, 5, 10, 20)
orderincrease (MaxN, 5, 45, 65)
increaseorder (MaxN, 5, 20, 60)

#! /usr/bin/python
TASKNAME = 'modsum3'
TESTSTR = '%02d'
SMALLTESTS = 12
TOFILES = False

GMinN, GMaxN = 2, 18
GMinS, GMaxS = 1, 10
GMaxT = 50

import random, sys
random.seed (hash (TASKNAME))
try:
	import psyco
	psyco.full ()
	sys.stderr.write ('(using psyco)\n')
except:
	sys.stderr.write ('(psyco not available)\n')

test = SMALLTESTS

def out (s):
	n = len (s)
	try:
		assert GMinN <= n <= GMaxN
		for i in range (n):
			assert GMinS <= s[i] <= GMaxS
		t = 0
		for i in range (n):
			t += s[i]
		assert t <= GMaxT
	except:
		sys.stderr.write ('Test not conforming to bounds.\n')
		return
	global test
	test += 1
	sys.stderr.write ('Test ' + TESTSTR % test + '\n')
	if TOFILES:
		f = open (TESTSTR % test, 'wt')
	else:
		f = sys.stdout
	f.write ('%d\n' % n)
	t = ''
	for i in range (n):
		t += '%d ' % s[i]
	f.write ('%s\n' % t[:-1])
	if TOFILES:
		f.close ()

def genrandom (n, lo, hi):
	s = []
	for i in range (n):
		s.append (random.randint (lo, hi))
	return s

def genrandomsum (n, lo, hi, sum):
	assert lo <= hi
	assert sum <= n * hi
	s = [lo] * n
	k = lo * n
	for i in range (k, sum):
		while True:
			j = random.randrange (n)
			if s[j] < hi:
				s[j] += 1
				break
	return s

random.seed (hash ('modsum'))
MinN, MaxN = 2, 10
MinS, MaxS = 1, 1000
MaxT = MaxS * MaxN
# Small tests
out ([17, 13])
out ([1, 2, 6, 24])
out ([15, 16, 18, 22])
out ([1, 10, 100, 1000])
out ([1, 10, 100, 1])
out ([1, 100, 10, 1])
out ([1, 1000, 999, 2, 1])

# Medium tests
for i in range (5, 11):
	out (genrandom (i, 1, 50))
for i in range (5, 11):
	out (genrandom (i, 1, 1000))
for i in range (5, 11):
	out (genrandom (i, 999, 1000))

# Large tests
out ([1] * 10)
out ([1000] * 10)
out (range (991, 1001))
out (range (1, 4) + range (991, 998))
out ([1, 2, 4, 8, 16, 32, 64, 128, 256, 512])
for i in range (900, 920):
	out (genrandom (10, i, 1000 - random.randrange (3)))

random.seed (hash ('modsum2'))
MinN, MaxN = 2, 16
MinS, MaxS = 1, 10 ** 6
MaxT = MaxS * MaxN
# Tests for modsum2
# Small tests
out ([MaxS] * 2)
out ([MaxS] * 3)
out ([999991, 999997])
out ([MaxS] * 2 + [MaxS - 1])

# Medium tests
out ([1] * MaxN)
out ([MaxS] * MaxN)
for i in range (11, MaxN + 1):
	out (genrandom (i, 1, 500))
for i in range (11, MaxN + 1):
	out (genrandom (i, 1, MaxS))
for i in range (11, MaxN + 1):
	out (genrandom (i, MaxS - 1, MaxS))

# Large tests
out (range (999985, 1000001))
out (range (1, 4) + range (999985, 999998))
out ([1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
 1024, 2048, 4096, 8192, 16384, 32768])
for i in range (900000, 900010):
	out (genrandom (16, i, MaxS - random.randrange (3)))

random.seed (hash ('modsum3'))
MinN, MaxN = 2, 18
MinS, MaxS = 1, 10
MaxT = 50
# Tests for modsum3
# Small tests
out ([MaxS] * 2)
out (genrandom (3, MaxS - 1, MaxS))
out ([MaxS - 2] * 4)
out (genrandom (5, MaxS - 3, MaxS))

# Medium tests
out ([1] * 10 + genrandomsum (7, MinS, MaxS, 40))
out (genrandomsum (10, 2, MaxS, 32) + [1] * 8)
out ([10] * 4 + [3, 5])
out ([5] * 4 + [4] * 6)
out ([5] * 2 + [2] * 10 + [3] * 6)

# Large tests
for l in range (40, 51):
	out (genrandomsum (12 - random.randrange (6), MinS, MaxS, l))
	out (genrandomsum (MaxN - random.randrange (3), MinS, MaxS, l))
out (genrandomsum (MaxN, 1, MaxS, MaxT))
out (genrandomsum (MaxN, 2, MaxS, MaxT))
out (genrandomsum (15, 3, MaxS, MaxT))
out ([10] * 5)
out ([5] * 10)
out ([3] * 16)
out ([3] * 16 + [1, 1])
out ([10, 10, 10, 8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
out ([10, 10, 10, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
out ([9, 1, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4])

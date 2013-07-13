#! /usr/bin/python
TASKNAME = 'modsum2'
TESTSTR = '%02d'
SMALLTESTS = 12
TOFILES = False

import random, sys
try:
	import psyco
	psyco.full ()
	sys.stderr.write ('(using psyco)\n')
except:
	sys.stderr.write ('(psyco not available)\n')

test = SMALLTESTS

def out (s):
	global test
	test += 1
	sys.stderr.write ('Test ' + TESTSTR % test + '\n')
	n = len (s)
	assert MinN <= n <= MaxN
	for i in range (n):
		assert MinS <= s[i] <= MaxS
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

random.seed (hash ('modsum'))
MinN, MaxN = 2, 10
MinS, MaxS = 1, 1000
# Small tests
out ([17, 13])
out ([1, 2, 6, 24])
out ([15, 16, 18, 22])
out ([1, 10, 100, 1000])
out ([1, 10, 100, 1])
out ([1, 100, 10, 1])
out ([1, 1000, 999, 2, 1])

# Medium tests
for i in range (5, MaxN + 1):
	out (genrandom (i, 1, 50))
for i in range (5, MaxN + 1):
	out (genrandom (i, 1, 1000))
for i in range (5, MaxN + 1):
	out (genrandom (i, 999, 1000))

# Large tests
out ([1] * MaxN)
out ([1000] * MaxN)
out (range (991, 1001))
out (range (1, 4) + range (991, 998))
out ([1, 2, 4, 8, 16, 32, 64, 128, 256, 512])
for i in range (900, 920):
	out (genrandom (MaxN, i, 1000 - random.randrange (3)))

random.seed (hash ('modsum2'))
MinN, MaxN = 2, 16
MinS, MaxS = 1, 10 ** 6
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
	out (genrandom (MaxN, i, MaxS - random.randrange (3)))

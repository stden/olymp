#! /usr/bin/python
TASKNAME = 'modsum'
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

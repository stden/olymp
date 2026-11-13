#! /usr/bin/python
TASKNAME = 'digitsum'
TESTSTR = '%02d'
SMALLTESTS = 0
TOFILES = True

import math, random, sys
random.seed (hash (TASKNAME))
try:
	import psyco
	psyco.full ()
	sys.stderr.write ('(using psyco)\n')
except:
	sys.stderr.write ('(psyco not available)\n')

MinT, MaxT = 1, 50000
MinC, MaxC = 1, 10 ** 9
MaxG = 24

test = SMALLTESTS

good = []

def out (a):
	global test
	test += 1
	sys.stderr.write ('Test ' + TESTSTR % test)
	t = len (a)
	assert MinT <= t <= MaxT
	s = 0
	for i in range (t):
		assert MinC <= a[i][0] <= a[i][1] <= MaxC
		s += a[i][1] - a[i][0] + 1
	sys.stderr.write (': %d test(s), %d total length\n' % (t, s))
	if TOFILES:
		f = open (TESTSTR % test, 'wt')
	else:
		f = sys.stdout
	f.write ('%d\n' % t)
	for i in range (t):
		f.write ('%d %d\n' % (a[i][0], a[i][1]))
	if TOFILES:
		f.close ()

def shuffle (a):
	random.shuffle (a)
	return a

def intsqrt (x):
	return int (math.sqrt (x))

def initgood ():
	global good;
	# denominators of continued fraction convergents to sqrt (2)
	# OEIS: http://www.research.att.com/~njas/sequences/A001333
	good.append ([])
	good[-1].append (1)
	good[-1].append (2)
	for i in range (2, MaxG):
		good[-1].append (good[-1][-1] * 2 + good[-1][-2])
	# numerators of continued fraction convergents to sqrt (2)
	# OEIS: http://www.research.att.com/~njas/sequences/A000129
	good.append ([])
	good[-1].append (1)
	good[-1].append (3)
	for i in range (2, MaxG):
		good[-1].append (good[-1][-1] * 2 + good[-1][-2])
	good.append ([good[-2][i] + good[-1][i] for i in range (MaxG)])

def genrandom (n, lo, hi):
	a = []
	for i in range (n):
		l = random.randint (lo, hi)
		r = random.randint (lo, hi)
		if l > r:
			l, r = r, l
		a.append ((l, r))
	return a

def genrandomlen (n, lo, hi, lenlo, lenhi):
	a = []
	for i in range (n):
		l = random.randint (lo, hi)
		r = l + random.randint (lenlo, lenhi)
		a.append ((l, r))
	return a

def genrandomends (n, llo, lhi, rlo, rhi):
	a = []
	for i in range (n):
		l = random.randint (llo, lhi)
		r = random.randint (rlo, rhi)
		if l > r:
			l, r = r, l
		a.append ((l, r))
	return a

def gengoodnumber (start, lo, hi):
        assert start < MaxG
	x = random.randrange (3)
	y = random.randrange (start, len (good[x]))
	z = random.randint (lo, hi)
	r = good[x][y] + z
	if r < MinC:
		r = MinC
	if r > MaxC:
		r = MaxC
	return r

def gengood (n, s, lo, hi):
	a = []
	for i in range (n):
		l = gengoodnumber (s, lo, hi)
		r = gengoodnumber (s, lo, hi)
		if l > r:
			l, r = r, l
		a.append ((l, r))
	return a

def genprec (k):
	x = random.randrange (MaxG)
	y = (x & 1) ^ k
	return good[y][x] + random.randrange (2)

initgood ()

# [Test 1] Sample
out ([(1, 6), (17, 17)])

# [Tests 2-5] Score: 1
out ([(41, 41)])
out ([(i, i) for i in range (1, 11)])
out ([(1, i) for i in range (1, 26)])
out ([(1, random.randint (1, 50)) for i in range (1, 51)])

# [Tests 6-7] Score: 1
out (shuffle ([(i, i) for i in range (1, 101)]))
out (shuffle ([(i, i * 2) for i in range (1, 501)]))

# [Tests 8-11] Score: 1
out (genrandomlen (243, 1, 100, 0, 100))
out (genrandom (812, 500, 650))
out (genrandomlen (1000, 1, 900, 0, 100))
out (genrandom (1000, 1, 1000))

# [Tests 12-16] Score: 2
out (genrandom (750, 1001, 10000))
out (genrandomlen (1225, 1001, 10000, 50, 1111))
out (shuffle ([(10000 + i, 10000 + i * 2) for i in range (1, 1001)]))
out ([(100000 + i, 100000 + i * 3) for i in range (1, 101)])
out (shuffle ([(1000000 + i, 1000000 + i * 5) for i in range (1, 11)]))

# [Tests 17-21] Score: 2
out ([(i, i) for i in range (1, MaxT + 1)])
out (shuffle ([(i, i + 28) for i in range (1, 11112)]))
out (genrandom (20000, 50, 500))
out (genrandom (MaxT - random.randrange (intsqrt (MaxT)), 1, 100))
out (genrandomlen (MaxT - random.randrange (intsqrt (MaxT)), 101, 1000, 1, 99))

# [Tests 22-26] Score: 3
out ([(1, i) for i in range (1, MaxT + 1)])
out ([(i, MaxT) for i in range (1, MaxT + 1)])
out (genrandom (10001, 1, 1000000))
out (genrandomlen (12597, 1, 500001, 1, 500000))
out (genrandomends (13579, 1, 500000, 500001, 1000000))

# [Tests 27-31] Score: 3
out (genrandom (126, MinC, MaxC))
out (genrandomlen (127, MinC, MaxC / 2 + 1, 1, MaxC / 2))
out (genrandomends (128, MinC, MaxC / 2, MaxC / 2 + 1, MaxC))
out (shuffle ([(i, i) for i in range (MaxC - MaxT + 1, MaxC + 1)]))
out (shuffle ([(i, MaxC) for i in range (MaxC - MaxT + 1, MaxC + 1)]))

# [Tests 32-35] Score: 4
out (genrandom (MaxT, MinC, MaxC))
out (genrandomlen (MaxT - random.randrange (intsqrt (MaxT)), \
 MinC, MaxC / 2 + 1, 1, MaxC / 2))
out (genrandomends (MaxT - random.randrange (intsqrt (MaxT)), \
 MinC, MaxC / 2, MaxC / 2 + 1, MaxC))
out (genrandomends (MaxT, 1, 10000, MaxC - 9999, MaxC))

# [Tests 36-41] Score: 4
out (genrandomends (MaxT, good[1][-3] - 10, good[1][-3] - 5, \
 good[1][-1] - 5, good[1][-1] - 1))
out (gengood (MaxT - random.randrange (intsqrt (MaxT)), 10, 0, 1))

a = []
for i in range (MaxT):
	l, r = genprec (random.randrange (2)), genprec (random.randrange (2))
	if l > r:
		l, r = r, l
	a.append ((l, r))
out (a)

out (gengood (MaxT - 1, 10,  1, 3))
out (gengood (MaxT / 4, 18,  -3,  -1) + \
     gengood (MaxT / 4, 18,  -1,   1) + \
     gengood (MaxT / 4, 18,   1,   3) + \
     gengood (MaxT / 4, 18,  -3,   3))
out (gengood (MaxT / 4, 15, -30, -10) + \
     gengood (MaxT / 4, 15, -10,  10) + \
     gengood (MaxT / 4, 15,  10,  30) + \
     gengood (MaxT / 4, 15, -30,  30))

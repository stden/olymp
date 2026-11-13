import random
random.seed (13428)
test = 11

def init (n):
	a = []
	for i in range (n):
		b = [0] * n
		a.append (b)
	return a

def cyclerange (a, r):
        k = len (r)
        for i in range (k - 1):
        	a[r[i]][r[i + 1]] = 1
        a[r[k - 1]][r[0]] = 1
	return a

def fullrange (a, r):
        k = len (r)
	for i in range (k):
		for j in range (i + 1, k):
			a[r[i]][r[j]] = 1
	return a

def idrange (a, r):
        k = len (r)
	for i in range (k):
		a[r[i]][r[i]] = 1
	return a

def randomrange (a, r, p, q):
        k = len (r)
	for i in range (k):
		for j in range (k):
			if random.randrange (q) < p:
				a[j][i] = 1
	return a

def pathfrom (a, b):
	n = len (a)
	e = [False] * n
	while True:
		if e[b]: break
		e[b] = True
		b = random.randrange (n)
	return a

def out (a, c, k):
	assert (len (a) == len (c))
	s = ''
	n = len (a)
	assert (n >= 2) and (n <= 20)
	m = 0
	for i in range (n):
		for j in range (n):
			if a[i][j]:
				m += 1
	s += '%d %d %s\n' % (n, m, k)
	for i in range (n - 1):
		s += '%d ' % c[i]
	s += '%d\n' % c[n - 1]
	for i in range (n):
		for j in range (n):
			if a[i][j]:
				s += '%d %d\n' % (i + 1, j + 1)
	return s

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 10
a = init (n)
c = [1, 2, 3, 4, 1, 2, 3, 4, 1, 2]
a = cyclerange (a, [0, 1, 2])
s = out (a, c, '100')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 11
a = init (n)
c = [1, 2, 3, 4, 5, 7, 6, 5, 4, 3, 2]
a = fullrange (a, range (0, 3))
a = fullrange (a, range (2, 9))
a = fullrange (a, range (8, 11))
a[10][0] = 1
s = out (a, c, '250')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 12
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (100) + 1)
a = fullrange (a, [0, 1, 2, 3, 4, 5, 6])
a = fullrange (a, [7, 8, 9, 10, 11])
a[6][7] = 1
a[11][0] = 1
s = out (a, c, '1000')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (100) + 1)
a = fullrange (a, range (20))
a = fullrange (a, (range (20))[::-1])
s = out (a, c, '10000')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 2
a = init (n)
c = [1, 100]
a[0][1] = 1
a[1][0] = 1
a[0][0] = 1
s = out (a, c, '1000000')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 2
a = init (n)
c = [1, 100]
a[0][1] = 1
a[1][0] = 1
a[0][0] = 1
s = out (a, c, '1000000000000')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 3
a = init (n)
c = [1, 100, 10]
a[0][2] = 1
a[2][0] = 1
a[0][0] = 1
a[0][1] = 1
s = out (a, c, '1000000000000')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 3
a = init (n)
c = [1, 11, 10]
a[0][2] = 1
a[2][0] = 1
a[0][0] = 1
a[0][1] = 1
s = out (a, c, '1000000000000')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (2) + 99)
a = fullrange (a, range (20))
a = fullrange (a, range (20)[::-1])
s = out (a, c, '1000000000000000')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (10) + 91)
a = fullrange (a, range (20))
a = fullrange (a, range (20)[::-1])
s = out (a, c, '999999999998765')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [80] + [81] * 8 + [81] * 9 + [100] + [1]
a = cyclerange (a, range (9))
a = cyclerange (a, [1] + range (9, 18))
a[0][18] = 1
a[18][19] = 1
s = out (a, c, '456482073846725')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [80] + [81] * 8 + [81] * 9 + [100] + [1]
a = cyclerange (a, range (9))
a = cyclerange (a, [1] + range (9, 18))
a[0][18] = 1
a[18][19] = 1
s = out (a, c, '937462425867234')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [50] + [51] * 9 + [51] * 8 + [1] + [100]
a = cyclerange (a, range (10))
a = cyclerange (a, [1] + range (10, 18))
a[0][19] = 1
a[19][18] = 1
a[18][3] = 1
s = out (a, c, '987654321098785')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [50] + [51] * 9 + [51] * 8 + [1] + [100]
a = cyclerange (a, range (10))
a = cyclerange (a, [1] + range (10, 18))
a[0][18] = 1
a[18][19] = 1
a[19][3] = 1
s = out (a, c, '987654321098785')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 19
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (2) + 40)
for i in range (n - 1):
	a[i][i + 1] = 1
a[n - 1][n - 1] = 1
s = out (a, c, '18478578936753')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 19
a = init (n)
c = []
for i in range (n - 1):
	c.append (random.randrange (80) + 1)
c += [100]
for i in range (n - 1):
	a[i][i + 1] = 1
a[n - 1][n - 1] = 1
for i in range (n - 1):
	a[n - 1][i] = 1
s = out (a, c, '218478578936754')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 19
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (20) + 41)
a = randomrange (a, range (n), 3, 5)
a = pathfrom (a, 0)
s = out (a, c, '562949953421312')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (20) + 41)
a = randomrange (a, range (n), 2, 5)
a = pathfrom (a, 0)
s = out (a, c, '562949953421312')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 19
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (20) + 41)
a = randomrange (a, range (n), 1, 5)
a = pathfrom (a, 0)
s = out (a, c, '562949953421311')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = []
for i in range (n):
	c.append (random.randrange (20) + 41)
a = randomrange (a, range (n), 4, 5)
a = pathfrom (a, 0)
s = out (a, c, '562949953421311')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * (n - 2) + [1, 100]
for i in range (n - 1):
	a[i][i + 1] = 1
a[n - 1][n - 1] = 1
for i in range (n - 1):
	a[n - 1][i] = 1
s = out (a, c, '891450947212367')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * (n - 2) + [1, 99]
for i in range (n - 1):
	a[i][i + 1] = 1
a[n - 1][n - 1] = 1
for i in range (n - 1):
	a[n - 1][i] = 1
s = out (a, c, '891450947212368')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * (n - 3) + [1, 99, 98]
for i in range (n - 2):
	a[i][i + 1] = 1
a[n - 2][n - 1] = 1
a[n - 1][n - 2] = 1
for i in range (n - 2):
	a[n - 1][i] = 1
s = out (a, c, '891450947212369')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * (n - 3) + [1, 99, 98]
for i in range (n - 2):
	a[i][i + 1] = 1
a[n - 2][n - 1] = 1
a[n - 1][n - 2] = 1
for i in range (n - 2):
	a[n - 1][i] = 1
s = out (a, c, '891450947212370')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * (n - 3) + [1, 99, 98]
for i in range (n - 2):
	a[i][i + 1] = 1
a[n - 2][n - 1] = 1
a[n - 1][n - 2] = 1
a[n - 1][0] = 1
s = out (a, c, '891450947212371')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * (n - 3) + [1, 99, 98]
for i in range (n - 2):
	a[i][i + 1] = 1
a[n - 2][n - 1] = 1
a[n - 1][n - 2] = 1
a[n - 1][0] = 1
s = out (a, c, '891450947212372')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * 7 + [99] * 6 + [100] * 7
for i in range (7):
	a[i][i + 1] = 1
a = cyclerange (a, range (7, 13))
for i in range (12, 19):
	a[i][i + 1] = 1
s = out (a, c, '999991234567890')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * 7 + [99] * 6 + [100] * 7
for i in range (7):
	a[i][i + 1] = 1
a = cyclerange (a, range (7, 13))
for i in range (12, 19):
	a[i][i + 1] = 1
s = out (a, c, '999991234567892')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * 3 + [98] + [99] * 6 + [99] * 7 + [100] * 3
for i in range (3):
	a[i][i + 1] = 1
a = cyclerange (a, [3] + range (4, 10))
a = cyclerange (a, [3] + range (10, 17))
a[3][17] = 1
for i in range (17, 19):
	a[i][i + 1] = 1
s = out (a, c, '999999999998713')
f.write (s)
f.close ()
test += 1

f = open ('%02d' % test, 'w')
print 'Generating test %02d' % test
n = 20
a = init (n)
c = [100] * 3 + [98] + [99] * 6 + [99] * 7 + [100] * 3
for i in range (3):
	a[i][i + 1] = 1
a = cyclerange (a, [3] + range (4, 10))
a = cyclerange (a, [3] + range (10, 17))
a[3][17] = 1
for i in range (17, 19):
	a[i][i + 1] = 1
s = out (a, c, '999999999998791')
f.write (s)
f.close ()
test += 1

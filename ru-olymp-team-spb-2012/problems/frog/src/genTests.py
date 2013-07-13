from os import *
from io import *
import random                             

def gentest(testNo, i):
	if not (path.exists("../tests")):
		mkdir("../tests")
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	tst.write(str(n[i]) + "\n");
	for j in range(n[i] - 1):
		tst.write(str(test[i][j]) + " ");
	tst.write(str(test[i][n[i] - 1]) + "\n");
	tst.close()              

def firstgen(testNo):
	if not (path.exists("../tests")):
		mkdir("../tests")
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	tst.write("100000\n");
	j = 0
	q = 1
	while (j < 100000):
		s = random.randint(1, 10)
		f = 1
		if (100000 - j <= 10):
			f = 0
			s = 100000 - j
		if (f == 1):
			for qq in range(s):
				tst.write(str(q) + " ");
		else:
			for qq in range(s-1):
				tst.write(str(q) + " ");
			tst.write(str(q) + "\n");
		q += 1
		j += s;
	tst.close()              

def randgen(testNo):
	if not (path.exists("../tests")):
		mkdir("../tests")
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	tst.write("100000\n");
	
	max = 1
	for i in range(99999):
		s = random.randint(max, 10**9)
		tst.write(str(s) + " ");
		max = s
	s = random.randint(max, 10**9)
	tst.write(str(s) + "\n") 
	tst.close()              


#n = [5, 11, 25, 5, 5, 2, 1, 4, 11]
test = [[2, 2, 4, 4]]
test += [[2, 2, 3, 3, 3, 4, 5, 6, 6, 8, 8]]
test += [[1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49]]
test += [[1, 1, 1, 1, 1]]     
test += [[1, 1, 1, 1, 10**9]]     
test += [[7, 7]]
test += [[1]]
test += [[1, 2, 2, 4]]
test += [list(range(10**9-10, 10**9))]
n = list(map(len, test))

random.seed(30131301);
testNo = 0
for i in range(9):
	testNo = testNo + 1
	gentest(testNo, i);

for i in range(8):
	testNo = testNo + 1
	firstgen(testNo);

for i in range(8):
	testNo = testNo + 1
	randgen(testNo);


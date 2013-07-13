from os import *
from io import *
import random                             

def genSample(testNo):
	if not (path.exists("../tests")):
		mkdir("../tests")
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	tst.write("3 3\n1 1\n3 3\n2 2\n");
	tst.close()              

#from a to c with b
def printTest(testNo, n, m, ai, aj, bi, bj, ci, cj):
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	tst.write(str(n) + " " + str(m) + "\n");
	tst.write(str(ai) + " " + str(aj) + "\n");
	tst.write(str(bi) + " " + str(bj) + "\n");
	tst.write(str(ci) + " " + str(cj) + "\n");
	tst.close();

MAXN = 100;


def randTest(testNo):
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	n = random.randint(50, 100);
	m = random.randint(50, 100);

	tst.write(str(n) + " " + str(m) + "\n");
	
	ai = random.randint(1, n);
	aj = random.randint(1, m);
	bi = random.randint(1, n);
	bj = random.randint(1, m);
	ci = random.randint(1, n);
	cj = random.randint(1, m);

	while (((ai == bi) and (aj == bj)) or (ai == ci and aj == cj) or (bi == ci and bj == cj)):
		ai = random.randint(1, n);
		aj = random.randint(1, m);
		bi = random.randint(1, n);
		bj = random.randint(1, m);
		ci = random.randint(1, n);
		cj = random.randint(1, m);

	tst.write(str(ai) + " " + str(aj) + "\n");
	tst.write(str(bi) + " " + str(bj) + "\n");
	tst.write(str(ci) + " " + str(cj) + "\n");
	tst.close();

def lineTest1(testNo):
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	n = random.randint(50, 100);
	m = random.randint(50, 100);

	tst.write(str(n) + " " + str(m) + "\n");

	ai = random.randint(1, n);
	bj = random.randint(1, m);
	cj = random.randint(bj + 1, m);
	aj = random.randint(cj + 1, m);

	tst.write(str(ai) + " " + str(aj) + "\n");
	tst.write(str(ai) + " " + str(bj) + "\n");
	tst.write(str(ai) + " " + str(cj) + "\n");
	tst.close();

def lineTest2(testNo):
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	n = random.randint(50, 100);
	m = random.randint(50, 100);

	tst.write(str(n) + " " + str(m) + "\n");

	ai = random.randint(1, n);
	aj = random.randint(1, m);
	ci = random.randint(ai + 1, n);
	bi = random.randint(ci + 1, n);

	tst.write(str(ai) + " " + str(aj) + "\n");
	tst.write(str(bi) + " " + str(aj) + "\n");
	tst.write(str(ci) + " " + str(aj) + "\n");
	tst.close();



n = [MAXN, MAXN, 5, 7, 5, 5, 5, 5, 3, MAXN, MAXN, MAXN, MAXN]
m = [MAXN, MAXN, 7, 5, 5, 5, 5, 5, 3, MAXN, MAXN, MAXN, MAXN]
a = [[1, 1], [MAXN, MAXN], [1, 5], [5, 1], [1, 1], [1, 5], [5, 5], [5, 1], [3, 3], [1, 1], [MAXN, MAXN], [1, MAXN], [MAXN - 1, MAXN]]
b = [[MAXN // 2, MAXN], [MAXN // 2, 1], [5, 5], [5, 5], [1, 5], [5, 5], [5, 1], [1, 1], [3, 2], [MAXN, MAXN // 2], [1, MAXN // 2], [MAXN, 1], [1, 1]]
c = [[MAXN, 1], [1, MAXN], [3, 5], [5, 3], [1, 3], [3, 5], [5, 3], [3, 1], [3, 1], [1, MAXN], [MAXN, 1], [2, MAXN], [MAXN, MAXN]]


random.seed(30131301);
testNo = 0
testNo = testNo + 1;
genSample(testNo);

for i in range(13):
	testNo = testNo + 1
	printTest(testNo, n[i], m[i], a[i][0], a[i][1], b[i][0], b[i][1], c[i][0], c[i][1]);

for i in range(16):
	testNo = testNo + 1;
	randTest(testNo) 

for i in range(2):
	testNo = testNo + 1;
	lineTest1(testNo) 

for i in range(2):
	testNo = testNo + 1;
	lineTest2(testNo) 

testNo = testNo + 1
printTest(testNo, 5, 3, 1, 3, 3, 3, 2, 3)

dx = [1, 1, 1, 0, -1, -1, -1, 0]
dy = [1, 0, -1, -1, -1, 0, 1, 1]

for i in range(8):
	for j in range(8):
		testNo = testNo + 1
		printTest(testNo, 100, 100, 50 + random.randint(1, 49) * dx[i], 50 + random.randint(1, 49) * dy[i], 50, 50, 50 + random.randint(1, 49) * dx[j], 50 + random.randint(1, 49) * dy[j]);
 



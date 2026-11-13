from os import *
from io import *
import random

def test(testNo, i):
	if not (path.exists("../tests")):
		mkdir("../tests")
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	tst.write(str(size[i]) + " " + str(n[i]) + "\n");
	for j in range(n[i]):
		tst.write(str(l[i][j]) + " " + str(r[i][j]) + "\n");
	tst.close()              

def gen(testNo):
	if not (path.exists("../tests")):
		mkdir("../tests")
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	Size = random.randint(1, 10000)
	tst.write(str(Size) + " ");
	tst.write("1000\n");
	for j in range(1000):
		left = random.randint(1, Size)
		right = random.randint(left, Size)
		tst.write(str(left) + " " + str(right) + "\n");
	tst.close()              

def gen2(testNo):
	if not (path.exists("../tests")):
		mkdir("../tests")
	tst = open("../tests/%d%d" % divmod(testNo, 10), "w")
	Size = 10000;
	tst.write(str(Size) + " ");
	tst.write("1000\n");
	for j in range(1000):
		left = random.randint(1, Size)
		right = random.randint(left, Size)
		tst.write(str(left) + " " + str(right) + "\n");
	tst.close()              


n = [3, 2, 3, 1, 4, 2, 1, 1, 2, 5, 5]
size = [3, 10, 10, 100, 101, 101, 10000, 10000, 10000, 10, 10]

l = [[1, 2, 3]]
r = [[1, 2, 3]]

l += [[1, 3]]
r += [[4, 10]]

l += [[1, 5, 9]]
r += [[6, 8, 10]]

l += [[1]]
r += [[100]]

l += [[1, 15, 50, 75]]
r += [[26, 62, 77, 100]]

l += [[2, 50]]
r += [[70, 101]]

l += [[1]]
r += [[10000]]

l += [[1]]
r += [[9999]]
   
l += [[2, 1]]
r += [[10000, 14]]

l += [[10, 8, 6, 4, 2]]
r += [[10, 10, 10, 10, 10]]


l += [[10, 8, 6, 4, 1]]
r += [[10, 10, 10, 10, 10]]



random.seed(313131);
testNo = 0
for i in range(11):
	testNo = testNo + 1
	test(testNo, i);

for i in range(10):
	testNo = testNo + 1
	gen(testNo);

for i in range(4):
	testNo = testNo + 1
	gen2(testNo);


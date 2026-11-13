import random
import os
random.seed(435437853427523852381)

cntTests = 0

def toString(a):
	s = str(a)
	if a < 10:
		s = "0" + s
	return s
		
def printTest(x, n):
	global cntTests
	cntTests += 1
	print("Printing test " + toString(cntTests))
	if not os.path.exists("../tests"):
		os.mkdir("../tests")
	f = open("../tests/" + toString(cntTests), "w")
	f.write(str(x) + " " + str(n) + "\n")
	f.close()

printTest(6, 1)
for i in [1, 2, 3, 4, 6, 10, 20, 21, 22, 23, 24]:
	for j in [1, 2, 3]:
		printTest(i, j)

for i in [15, 16, 63, 64, 511, 512, 999, 1000]:
	for j in [1, 5, 10, 100, 1000]:
		printTest(i, j)

printTest(968, 15)
printTest(968, 17)
for i in range(664, 668):
    printTest(1000, i)

import os
import io
import random

random.seed(23723572325)
testNo = 0

def printTest(k, n):
	global testNo
	testNo += 1
	if not (os.path.exists('../tests')):
		os.mkdir('../tests')
	test = open('../tests/%02d' % testNo, 'w')
	test.write(str(k) + ' ' + str(n) + '\n')
	test.close()


# sample tests
printTest(1, 6)
printTest(3, 4)

# all tests with n = 4
for k in range(1, 8):
	printTest(k, 4)

for k in [x for x in range(1, 11)] + [15, 42, 49, 50, 99, 100]:
	for n in [6, 8, 100]:
		printTest(k, n)

for t in range(10):
	printTest(random.randint(1, 100), 2 * random.randint(3, 50))

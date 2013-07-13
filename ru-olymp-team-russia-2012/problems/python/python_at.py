#!/usr/bin/python3

fin = open('python.in', 'r')
fout = open('python.out', 'w')

a = int(fin.readline())
b = int(fin.readline())
print(a // (b + 1), file = fout)
if (a + 1) % b == 0:
	print((a + 1) // b - 1, file = fout)
else:
	print((a + 1) // b, file = fout)
fin.close()
fout.close()

#!/usr/bin/python3

fin = open('forest.in', 'r')
fout = open('forest.out', 'w')
n,m = map(int,fin.readline().split())
def valid(x, y):
	return 0 <= x < n and 0 <= y < m;
a = [ list(map(int,fin.readline().split())) for i in range(n) ]
time = [ [ 0 for i in range(m) ] for i in range(n) ]
cnt = 0
dx = [ 0, 0, -1, 1, 0 ]
dy = [ -1, 1, 0, 0, 0 ]
interesting = []

def init_interesting():
	global interesting
	for i in range(n):
		for j in range(m):
			grow = False
			for k in range(4):
				i1 = i + dx[k]
				j1 = j + dy[k]
				grow = grow or (valid(i1, j1) and a[i][j] + 1 == a[i1][j1])
			if grow:
				interesting.append((i,j))

init_interesting()

step = 0
while len(interesting) > 0:
	step += 1
	interesting, old_interesting = [], interesting
	for (i,j) in old_interesting:
		a[i][j] += 1
	for (i, j) in old_interesting:
		for k in range(5):
			i1 = i + dx[k]
			j1 = j + dy[k]
			grow = False
			if valid(i1, j1):
				for k1 in range(4):
					i2 = i1 + dx[k1]
					j2 = j1 + dy[k1]
					grow = grow or (valid(i2, j2) and a[i1][j1] + 1 == a[i2][j2])
				if grow:
					interesting.append((i1, j1))
	interesting = list(set(interesting))

print(step,file=fout)
for line in a:
	print(' '.join(map(str,line)), file=fout)
fin.close()
fout.close()

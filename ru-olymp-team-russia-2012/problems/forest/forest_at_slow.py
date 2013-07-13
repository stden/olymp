#!/usr/bin/python3

fin = open('forest.in', 'r')
fout = open('forest.out', 'w')
n,m = map(int,fin.readline().split())
def valid(x, y):
	return 0 <= x < n and 0 <= y < m;
a = [ list(map(int,fin.readline().split())) for i in range(n) ]
cnt = 0
dx = [ 0, 0, -1, 1 ]
dy = [ -1, 1, 0, 0 ]
while True:
	changed = False
	b = [ [ 0 for i in range(m) ] for j in range(n) ]
	for i in range(n):
		for j in range(m):
			grow = False
			for k in range(4):
				i1 = i + dx[k]
				j1 = j + dy[k]
				grow = grow or (valid(i1, j1) and a[i][j] + 1 == a[i1][j1])
			if grow:
				b[i][j] = a[i][j] + 1
				changed = True
			else:
			 	b[i][j] = a[i][j]
	a = b
	if not changed:
	   break
	else:
	   cnt += 1
print(cnt,file=fout)
for line in a:
	print(' '.join(map(str,line)), file=fout)
fin.close()
fout.close()

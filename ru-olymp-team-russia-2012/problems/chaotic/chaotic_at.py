#!/usr/bin/python3

fin = open('chaotic.in', 'r')
fout = open('chaotic.out', 'w')

ans = []

n = int(fin.readline())
a = list(map(int, fin.readline().split()))
for i in range(1, n - 1):
	if (a[i - 1] < a[i] < a[i + 1]) or (a[i - 1] > a[i] > a[i + 1]):
		ans.append(i + 1)
		a[i], a[i + 1] = a[i + 1], a[i]
print(len(ans), file=fout)
print(' '.join(map(str,ans)), file=fout)

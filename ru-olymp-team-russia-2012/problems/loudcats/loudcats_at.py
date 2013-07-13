#!/usr/bin/python3

fin = open('loudcats.in', 'r')
fout = open('loudcats.out', 'w')
n,m,a = map(int, fin.readline().split())
l = list(map(int, fin.readline().split()))
res = sum([ (i + m < len(l)) and (2 * l[i] < l[i + m]) for i in range(len(l))])
print(res * a, file=fout)
fin.close()
fout.close()

inf = open("half.in", "r")
ouf = open("half.out", "w")

x, n = [int(x) for x in inf.readline().split()]

a = set([2 * x])

for i in range(0, n):
	newa = set()
	for b in a:
		if b % 2 == 0:
			newa.add(b // 2)
		newa.add(b - 1)
	a = newa

a = sorted([x / 2 for x in a if x >= 0])
s = " ".join(str(x) for x in a)
ouf.write(str(len(a)) + "\n")
ouf.write(s + "\n")

inf.close();
ouf.close();

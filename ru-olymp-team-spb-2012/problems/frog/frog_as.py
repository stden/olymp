inf = open("frog.in", "r")

n = int(inf.readline())

a = [int (x) for x in inf.readline().split()]
a = a[::-1]

r = 0
sum = 0
cur = 0
for i in range(len(a)):
	if i == 0 or a[i] != a[i - 1]:
		sum += cur
		cur = 0

	r += a[i] - sum if a[i] - sum > 0 else 0
	cur = cur + 1

ouf = open("frog.out", "w")
ouf.write(str(r) + "\n")
ouf.close()
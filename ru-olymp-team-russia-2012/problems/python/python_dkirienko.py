inf = open("python.in", "r")
ouf = open("python.out", "w")

a = int(inf.readline())
b = int(inf.readline())
print(a // (b + 1), file = ouf)
if (a + 1) % b == 0:
    print((a + 1) // b - 1, file = ouf)
else:
    print((a + 1) // b, file = ouf)

ouf.close()
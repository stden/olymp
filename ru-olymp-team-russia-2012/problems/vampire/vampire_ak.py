def areVamp(a, b):
    return sorted(str(a) + str(b)) == sorted(str(a * b))

def vamps(n):
    m = min(3, n)
    zeros = n - m
    z = 10 ** zeros
    s = set()
    for i in range(10 ** (m-1), 10 ** m):
        for j in range(i + 1, 10 ** m):
            if areVamp(i, j) and i * j not in s:
                s.add(i * j)
                yield (i * z, j * z)

m, n = list(map(int, open('vampire.in').readline().split()))
out = open('vampire.out', 'w')

for (i, (a, b)) in zip(range(m), vamps(n // 2)):
    print ("%d=%dx%d"%(a * b, a, b), file=out)


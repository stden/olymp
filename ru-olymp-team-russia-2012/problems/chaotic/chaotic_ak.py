from random import *

def check(a, ans):
    b = a[:]
    for i in ans:
        b[i], b[i - 1] = b[i - 1], b[i]
    for i in range(len(a) - 2):
        assert not b[i] < b[i + 1] < b[i + 2]
        assert not b[i] > b[i + 1] > b[i + 2]


def solve(b):
    a = b[:]
    ans = []
    n = len(a)
    for i in range(n - 2):
        if a[i] < a[i + 1] < a[i + 2] or a[i] > a[i + 1] > a[i + 2]:
            a[i + 1], a[i + 2] = a[i + 2], a[i + 1]
            ans.append(i + 2)
    return ans

IN = open('chaotic.in')
n = int(IN.readline())
a = list(map(int, IN.readline().split()))

ans = solve(a)
OUT = open('chaotic.out', 'w')
print (len(ans), file=OUT)
print (" ".join(str(x) for x in ans), file=OUT)

#while True:
#    a = list(range(1, 10))
#    shuffle(a)
#    print (a)
#    check(a, solve(a))


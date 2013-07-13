from random import *
from copy import *

seed('billboard')
tests = 0
N = 100
M = 100
K = 100
alpha = ".*"

def out(t):
    global tests
    tests += 1
    print (tests)
    output = open('../tests/%02d'%tests, 'w')
    for cs in t:
        assert len(cs) == len(t[0])
        assert len(cs[0]) == len(t[0][0])
    n, m, k = len(t[0]), len(t[0][0]), len(t)
    print (k, n, m, file=output)
    for i in range(k):
        for j in range(n):
            print (t[i][j], file=output)

def sample():
    return [["*..", "*.."], ["**.", "*.."], ["...", ".*."]]

def randField(n, m):
    return ["".join(choice(alpha) for i in range(m)) for i in range(n)]

def randTest(n, m, k):
    return [randField(n, m) for i in range(k)]

def full(n, m):
    return ["*" * m] * n

def empty(n, m):
    return ["." * m] * n

def chess(n, m):
    return ["".join(alpha[(i+j) % 2] for j in range(m)) for i in range(n)]

def addHorizontalLineAt(i, f):
    if i == 0:
        return ["*" * len(f[i])] + f[1:]
    return f[:i-1] + ["*" * len(f[i])] + f[i:]

def addVerticalLineAt(j, f):
    if j == 0:
        return ["*" + s[1:] for s in f]
    return [s[:j-1] + "*" + s[j:] for s in f]

def flipX(f):
    return f[::-1]

def addCross(i, j, f):
    return addVerticalLineAt(j, addHorizontalLineAt(i, f))

def flipY(f):
    return [s[::-1] for s in f]

def join(xxs):
    return [x for xs in xxs for x in xs]

def fromArray2D(a):
    return ["".join(map(str,b)) for b in a]

def largeLCPDiff(diff, n, m, k, selecter = lambda x : randint(x // 2, x - 1)):
    a = [[choice(alpha) for i in range(m)] for j in range(n)]
    aa = []
    for i in range(k):
        aa.append(fromArray2D(deepcopy(a)))
        for j in range(diff):
            a[selecter(n)][selecter(m)] = choice(alpha)
    return aa

def niyaz_bad(n,m,head, mid, tail):
    a = full(n,m)
    res = [a] * head
    for i in range(mid // 2):
        f = randField(n, m)
        res.append(f)
        res.append(flip(f))
    res = res + [a] * tail
    return res

def flipRow(r):
    return "".join('.' if x == '*' else '*' for x in r)

def flip(f):
    return [flipRow(r) for r in f]

def flip3(ff):
    return [flip(f) for f in ff]

out(sample())
out([["."]])
out([["*"]])
out([["*"], ["."]])
out([["."], ["*"]])
out([["."], ["*"]])
out([["*"], ["."]])
out([full(N,M)] * K)
out([empty(N,M)] * K)
out([full(N,M), empty(N,M)] * (K // 2))
out(randTest(1,2,3))
out(randTest(N,M,K))
out(join([[addHorizontalLineAt(i, empty(N,M)), addVerticalLineAt(i, empty(N,M))] 
        for i in range(min(K//2, N, M))]))
out([addCross(randint(0, N-1), randint(0, M-1), empty(N,M)) for i in range(K)])
out(largeLCPDiff(2, N, M, K))
out(largeLCPDiff(2, N, M, K, lambda x : randint(x // 3, 2 * x // 3)))
out(largeLCPDiff(100, N, M, K))
out(largeLCPDiff(2, N, M, K//2) + largeLCPDiff(2, N, M, K//2))
out([addCross(randint(0, N-1), randint(0, M-1), empty(N, M)) for i in range(K)])
for n in [1, N]:
    for m in [1, M]:
        for k in [1, 2, K]:
            out(randTest(n, m, k))
for head in [30]:
    for tail in [30]:
        out(flip3(niyaz_bad(N, M, head, K - head - tail, tail)))
        out(niyaz_bad(N, M, head, K - head - tail, tail)) 
for head in [10, 30, 70, 90]:
    out(niyaz_bad(N, M, 0, K - head, head))
    out(flip3(niyaz_bad(N, M, 0, K - head, head)))
    out(flip3(niyaz_bad(N, M, head, K - head, 0)))
    out(niyaz_bad(N, M, head, K - head, 0))

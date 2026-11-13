__author__ = 'niyaz.nigmatullin'

import os
import random

random.seed(58)

class Edge:
    def __init__(self, f, t):
        self.f, self.t = f, t

    def __str__(self):
        return '%d %d' % (self.f + 1, self.t + 1)

class Graph:
    def __init__(self, n, edges):
        self.n, self.m, self.edges = n, len(edges), edges

    def __str__(self):
        s = "%d %d\n" % (self.n, self.m)
        for i in range(self.m):
            s += str(self.edges[i])
            s += '\n'
        return s

testNum = 0

def printTest(a):
    global testNum
    testNum += 1
    print('Generating test #%02d' % testNum)
    with open('../tests/%02d' % testNum, 'w') as f:
        f.write(str(a))

def shuffleGraph(g):
    m = []
    for i in range(g.n):
        m.append(i)
    random.shuffle(m)
    for e in g.edges:
        e.f, e.t = m[e.f], m[e.t]
        if random.randrange(2) == 0:
            e.f, e.t = e.t, e.f
    random.shuffle(g.edges)
    return g

def addChain(edges, start, length):
    for i in range(1, length):
        edges.append(Edge(start + i - 1, start + i))

def addCycle(edges, start, length):
    if length <= 2:
        return
    for i in range(0, length):
        edges.append(Edge(start + i, start + (i + 1) % length))

def genRandomGraph(n):
    v = 0
    edges = []
    while v < n:
        toAdd = random.randrange(n - v) + 1
        if random.randrange(2) == 0:
            addChain(edges, v, toAdd)
        else:
            addCycle(edges, v, toAdd)
        v += toAdd
    return shuffleGraph(Graph(n, edges))

def emptyGraph(n):
    return Graph(n, [])

def chainGraph(n):
    edges = []
    addChain(edges, 0, n)
    return shuffleGraph(Graph(n, edges))

def cycleGraph(n):
    edges = []
    addCycle(edges, 0, n)
    return shuffleGraph(Graph(n, edges))

def largeAnswer(n):
    v = 0
    edges = []
    while v < n:
        toAdd = random.randrange(min(n - v, 10)) + 1
        if random.randrange(4) == 0:
            addChain(edges, v, toAdd)
        else:
            addCycle(edges, v, toAdd)
        v += toAdd
    return shuffleGraph(Graph(n, edges))

def smallComponents(n):
    v = 0
    edges = []
    while v < n:
        toAdd = random.randrange(min(n - v, 3)) + 1
        if random.randrange(4) != 0:
            addChain(edges, v, toAdd)
        else:
            addCycle(edges, v, toAdd)
        v += toAdd
    return shuffleGraph(Graph(n, edges))

def largeComponents(n):
    v = 0
    edges = []
    comps = random.randrange(5) + 2
    m = n // comps
    while v < n:
        left = max(0, m - 10)
        right = min(m + 10, n - v)
        if left > right:
            left = 1
            right = n - v
        toAdd = random.randint(left, right)
        if random.randrange(3) == 0:
            addChain(edges, v, toAdd)
        else:
            addCycle(edges, v, toAdd)
        v += toAdd
    return shuffleGraph(Graph(n, edges))

def chainsOnly(n):
    v = 0
    edges = []
    while v < n:
        toAdd = random.randrange(n - v) + 1
        addChain(edges, v, toAdd)
        v += toAdd
    return shuffleGraph(Graph(n, edges))

if not (os.path.exists("../tests")):
    os.mkdir("../tests")

printTest(Graph(5, [Edge(0, 1), Edge(1, 2), Edge(0, 2), Edge(3, 4)]))
printTest(Graph(2, [Edge(0, 1)]))
printTest(chainGraph(10))
printTest(cycleGraph(15))
printTest(emptyGraph(30))
printTest(cycleGraph(100000))
printTest(chainGraph(100000))
printTest(chainsOnly(100000))
printTest(largeAnswer(100000))
printTest(largeComponents(100000))
printTest(emptyGraph(100000))
printTest(genRandomGraph(100000))
for i in [20, 42, 50, 100, 1000, 20000]:
    printTest(largeAnswer(i))
for i in [3, 50, 422, 866, 30000, 70000]:
    printTest(cycleGraph(i))
for i in [30000, 50000, 66666, 77777, 99979]:
    printTest(largeComponents(i))
for i in [30000, 50000, 66666, 77777, 99979]:
    printTest(smallComponents(i))
for i in [400, 60000]:
    printTest(chainGraph(i))
for i in [500, 4000, 56565, 70000]:
    printTest(chainsOnly(i))
for i in [400, 70000, 80000]:
    printTest(emptyGraph(i))
for i in [234, 4567, 6765, 45643, 23424, 13354, 85854, 34323]:
    printTest(genRandomGraph(i))

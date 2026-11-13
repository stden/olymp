IN = open('frog.in')

n = int(IN.readline())
a = sorted(list(map(int, IN.readline().split())))

ans = 0
eaten = 0
while a:
    if a[-1] - eaten <= 0:
        break
    j = len(a) - 1
    while j >= 0 and a[j] == a[-1]:
        j -= 1
    eatenNow = len(a) - j - 1
    ans += (a[-1] - eaten) * eatenNow 
    eaten += eatenNow
    for j in range(eatenNow):
        a.pop()
print (ans, file=open('frog.out', 'w'))

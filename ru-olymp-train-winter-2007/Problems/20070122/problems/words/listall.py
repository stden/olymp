n = 20
for i in range (1, n + 1):
	for j in range (1, n + 1):
		if i * j <= n:
			k = 1
			for l in range (i):
				k *= j
			m = i * (i + 1)
			print i, j, k, m

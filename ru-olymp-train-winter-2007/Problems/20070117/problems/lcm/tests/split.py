test = 0
fin = open ('split.in', 'r')
while True:
	s = fin.readline ()
	if s == '': break
	test += 1
	print test
	f = open ('%02d' % test, 'w')
	f.write (s)
	f.close ()
fin.close ()

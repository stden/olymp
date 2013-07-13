test = 0
fin = open ('lcm.out', 'r')
while True:
	s = fin.readline ()
	if s == '': break
	test += 1
	print test
	f = open ('%02d.out' % test, 'w')
	f.write (s)
	s = fin.readline ()
	f.write (s)
	f.close ()
fin.close ()

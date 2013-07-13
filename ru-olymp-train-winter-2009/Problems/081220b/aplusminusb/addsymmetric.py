#! /usr/bin/python
tests = 18
for test in range (1, tests + 1):
	fin = open ('%02d' % test, 'rt')
	fout = open ('%02d' % (test + tests), 'wt')
	s = fin.readline ()
	t = fin.readline ()
	fout.write (t)
	fout.write (s)
	fin.close ()
	fout.close ()
	fin = open ('%02d.a' % test, 'rt')
	fout = open ('%02d.a' % (test + tests), 'wt')
	s = fin.readline ()
	if s != '0\n':
		s = '-' + s
	fout.write (s)
	fin.close ()
	fout.close ()

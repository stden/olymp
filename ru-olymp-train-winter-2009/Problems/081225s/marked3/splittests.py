#! /usr/bin/python
import sys
s = sys.argv[0]
t = s.split ('\\')
TASKNAME = t[-2]
TESTSTR = '%03d'
fin = open (TASKNAME + '.in', 'rt')
fout = open (TASKNAME + '.out', 'rt')
test = 0
while True:
	s = fin.readline ()
	if s == '' or s == '\n':
		s = fin.readline ()
		if s == '' or s == '\n':
			break
	test += 1
	f = open (TESTSTR % test, 'wt')
	f.write (s)
	t = s.split ()
	k = int (t[1]) + int (t[2])
	for i in range (k):
		s = fin.readline ()
		f.write (s)
	f.close ()
	f = open ((TESTSTR + '.a') % test, 'wt')
	s = fout.readline ()
	f.write (s)
	f.close ()

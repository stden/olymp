#! /usr/bin/python
# This script should be run in the statistics directory
# (C:\stat or /home/judge/stat) to generate text files with
# solved polyominoes.
p = 0
while True:
	try:
		fin = open ('%03d' % p, 'r')
		fout = open ('%03d.txt' % p, 'w')
	except:
		break
	print 'Extracting polyomino %03d' % p
	s = fin.readline ()
	t = s.split ()
	m = int (t[0])
	n = int (t[1])
	fout.write ('%d %d\n' % (m, n))
	for i in range (m):
		s = fin.readline ()
		fout.write (s)
	fin.close ()
	fout.close ()
	p += 1

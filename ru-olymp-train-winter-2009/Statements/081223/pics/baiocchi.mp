l = 1.0cm;
u = 0.025;
v = 2 * u;
w = v * l;

pair p [] [];

p[1][1] = (0, 0); p[1][2] = (0, 1); p[1][3] = (0, 2); p[1][4] = (0, 3);
p[2][1] = (0, 0); p[2][2] = (0, 1); p[2][3] = (0, 2); p[2][4] = (1, 2);
p[3][1] = (0, 0); p[3][2] = (0, 1); p[3][3] = (0, 2); p[3][4] = (1, 1);
p[4][1] = (0, 0); p[4][2] = (0, 1); p[4][3] = (1, 2); p[4][4] = (1, 1);
p[5][1] = (0, 0); p[5][2] = (0, 1); p[5][3] = (1, 0); p[5][4] = (1, 1);

def drawsquare (expr q, x, y, z, t) =
 draw (q + (0 + u, 0 + u) -- q + (1 - u, 0 + u) -- q + (1 - u, 1 - u) \
  -- q + (0 + u, 1 - u) -- cycle) \
  xscaled z rotated t shifted (x, y) scaled l;
enddef;

def fillsquare (expr q, x, y, z, t, f) =
 fill (q + (0 + v, 0 + v) -- q + (1 - v, 0 + v) -- q + (1 - v, 1 - v) \
  -- q + (0 + v, 1 - v) -- cycle) \
  xscaled z rotated t shifted (x, y) scaled l withcolor f * white;
enddef;

def put (expr i, x, y, z, t, f) =
begingroup
 pickup pencircle scaled (3.0 * w);
 for j = 1 upto 4:
  drawsquare (p[i][j], x, y, z, t);
 endfor;
 pickup pencircle scaled (1.0 * w);
 for j = 1 upto 4:
  fillsquare (p[i][j], x, y, z, t, f);
 endfor;
endgroup;
enddef;

beginfig (1);
 put (1,  1,  0,  1,  90, 0.90);
 label.bot ("I", (0,  0)) scaled 2 shifted (-1.0 * l, 0 * l);
 put (2,  5,  0,  1,  90, 0.90);
 label.bot ("L", (0,  0)) scaled 2 shifted ( 3.5 * l, 0 * l);
 put (3,  9,  0,  1,  90, 0.90);
 label.bot ("T", (0,  0)) scaled 2 shifted ( 7.5 * l, 0 * l);
 put (4, 13,  0,  1,  90, 0.90);
 label.bot ("N", (0,  0)) scaled 2 shifted (11.5 * l, 0 * l);
 put (5, 14,  0,  1,   0, 0.90);
 label.bot ("O", (0,  0)) scaled 2 shifted (15.0 * l, 0 * l);
endfig;

beginfig (2);
 put (2,  1,  0,  1,   0, 0.90);
 put (2,  5,  3,  1, 180, 0.90);
 put (2,  5,  8, -1, 180, 0.90);
 put (2,  9,  5, -1,   0, 0.90);
 put (2,  4,  4,  1,  90, 0.90);
 put (2,  1,  8,  1, 270, 0.90);
 put (2,  9,  4, -1,  90, 0.90);
 put (2,  6,  0, -1, 270, 0.90);
endfig;

beginfig (3);
 put (4,  3,  4,  1,   0, 0.60);
 put (4,  7,  5, -1,   0, 0.80);
 put (4,  9,  6,  1,  90, 0.60);
 put (4, 10,  6, -1,  90, 0.80);
 put (4,  8,  2,  1,   0, 0.60);
 put (4,  8,  1, -1,   0, 0.80);
 put (4,  7,  1,  1,  90, 0.60);
 put (4,  6,  5, -1,  90, 0.80);
 label.bot ("YES", (0,  0)) scaled 2 shifted (6.5 * l, 0.5 * l);
endfig;

beginfig (4);
 put (3,  0,  0,  1,   0, 0.80);
 put (3,  4, -1,  1,  90, 0.60);
 put (3,  5,  3,  1, 180, 0.80);
 put (3,  1,  4,  1, 270, 0.60);
 label.bot ("NO", (0,  0)) scaled 2 shifted (2.5 * l, -1.5 * l);
endfig;

beginfig (5);
 put (2,  1,  3,  1,   0, 0.60);
 put (2,  5,  3, -1,   0, 0.80);
 put (2,  5,  3,  1, 180, 0.60);
 put (2,  1,  3, -1, 180, 0.80);
 label.bot ("NO", (0,  0)) scaled 2 shifted (3.0 * l, -0.5 * l);
endfig;

end.

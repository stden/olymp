l = 1.0cm;
u = 0.1;
v = 0.5;
w = u * l;

def square = ((v, v) -- (v, -v) -- (-v, -v) -- (-v, v) -- cycle) enddef;

def circle = fullcircle enddef;

picture temp;

beginfig (1);
 pickup pencircle scaled w;
 draw circle shifted (4.00, 4.00) scaled l;
 draw ((3.65, 3.65) -- (2.35, 2.35)) scaled l;
 draw circle shifted (2.00, 2.00) scaled l;
 draw ((4.35, 3.65) -- (5.65, 2.35)) scaled l;
 draw circle shifted (6.00, 2.00) scaled l;
 draw ((1.75, 1.55) -- (1.00, 0.50)) scaled l;
 draw square shifted (1.00, 0.00) scaled l;
 draw ((2.25, 1.55) -- (3.00, 0.50)) scaled l;
 draw square shifted (3.00, 0.00) scaled l;
 draw ((5.75, 1.55) -- (5.00, 0.50)) scaled l;
 draw square shifted (5.00, 0.00) scaled l;
 draw ((6.25, 1.55) -- (7.00, 0.50)) scaled l;
 draw square shifted (7.00, 0.00) scaled l;
endfig;

beginfig (2);
 pickup pencircle scaled w;
 draw circle shifted (4.00, 2.00) scaled l;
 draw ((3.50, 1.90) -- (1.00, 0.50)) scaled l;
 draw square shifted (1.00, 0.00) scaled l;
 draw ((3.75, 1.55) -- (3.00, 0.50)) scaled l;
 draw square shifted (3.00, 0.00) scaled l;
 draw ((4.25, 1.55) -- (5.00, 0.50)) scaled l;
 draw square shifted (5.00, 0.00) scaled l;
 draw ((4.50, 1.90) -- (7.00, 0.50)) scaled l;
 draw square shifted (7.00, 0.00) scaled l;
endfig;

beginfig (3);
 pickup pencircle scaled w;
 draw circle shifted (3.50, 2.00) scaled l;
 draw ((3.10, 1.70) -- (1.50, 0.50)) scaled l;
 draw square shifted (1.00, 0.00) scaled l;
 draw square shifted (2.00, 0.00) scaled l;
 draw ((3.70, 1.55) -- (4.00, 0.50)) scaled l;
 draw square shifted (4.00, 0.00) scaled l;
 draw ((3.90, 1.70) -- (6.00, 0.50)) scaled l;
 draw square shifted (6.00, 0.00) scaled l;
 temp := currentpicture;
endfig;

beginfig (4);
 pickup pencircle scaled w;
 draw circle shifted (3.50, 2.00) scaled l;
 draw ((3.10, 1.70) -- (1.50, 0.50)) scaled l;
 draw square shifted (1.00, 0.00) scaled l;
 draw ((3.50, 1.50) -- (3.50, 0.50)) scaled l;
 draw square shifted (3.00, 0.00) scaled l;
 draw square shifted (4.00, 0.00) scaled l;
 draw ((3.90, 1.70) -- (6.00, 0.50)) scaled l;
 draw square shifted (6.00, 0.00) scaled l;
endfig;

beginfig (5);
 currentpicture := temp xscaled -1;
endfig;

beginfig (6);
 pickup pencircle scaled w;
 draw circle shifted (3.00, 2.00) scaled l;
 draw ((2.60, 1.70) -- (2.00, 0.50)) scaled l;
 draw square shifted (1.00, 0.00) scaled l;
 draw square shifted (2.00, 0.00) scaled l;
 draw square shifted (3.00, 0.00) scaled l;
 draw ((3.40, 1.70) -- (5.00, 0.50)) scaled l;
 draw square shifted (5.00, 0.00) scaled l;
 temp := currentpicture;
endfig;

beginfig (7);
 pickup pencircle scaled w;
 draw circle shifted (3.00, 2.00) scaled l;
 draw ((2.60, 1.70) -- (1.50, 0.50)) scaled l;
 draw square shifted (1.00, 0.00) scaled l;
 draw square shifted (2.00, 0.00) scaled l;
 draw ((3.40, 1.70) -- (4.50, 0.50)) scaled l;
 draw square shifted (4.00, 0.00) scaled l;
 draw square shifted (5.00, 0.00) scaled l;
endfig;

beginfig (8);
 currentpicture := temp xscaled -1;
endfig;

end.

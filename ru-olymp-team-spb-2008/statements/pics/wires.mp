verbatimtex 
%&latex 
\documentclass[a4paper,11pt]{article} 
\usepackage[cp1251]{inputenc} 
\usepackage[russian]{babel} 
\usepackage[dvips]{epsfig} 
\pagestyle{empty} 
\begin{document} 
etex 

u := 1.0cm;
su := 1.2mm;

def tria(expr x, y, s) =
	draw (x * u - 2su, y*u - 1.73su)--(x*u + 2su, y*u - 1.73su)--(x*u, y*u + 1.73su)--cycle;
	label(s, (x*u, y*u-0.5su));
enddef;

def circ(expr x, y, s) =
	draw (x * u - 2su, y*u)..(x*u, y*u - 2su)..(x * u + 2su, y*u)..(x*u, y*u + 2su)..cycle;
	label(s, (x*u, y*u));
enddef;

beginfig(1)
	tria(1, 1, "1");
	tria(4, 1, "2");
	circ(6, 1, "A");
	circ(8, 1, "B");

	drawarrow (-1u, 0.6u)--(10u,0.6u);
	for i = 0 upto 9:
		draw (i*u, 0.6u-0.5su)--(i*u, 0.6u+0.5su);
		label.bot(decimal i, (i*u, 0.6u-0.5su));
	endfor
endfig;

beginfig(2)
	tria(1, 1, "1");
	tria(4, 1, "2");
	circ(2, 1, "A");
	circ(5, 1, "B");
	drawarrow (-1u, 0.6u)--(10u,0.6u);
	for i = 0 upto 9:
		draw (i*u, 0.6u-0.5su)--(i*u, 0.6u+0.5su);
		label.bot(decimal i, (i*u, 0.6u-0.5su));
	endfor
endfig;

end.

verbatimtex 
%&latex 
\documentclass[a4paper,11pt]{article} 
\usepackage[cp1251]{inputenc} 
\usepackage[russian]{babel} 
\usepackage[dvips]{epsfig} 
\pagestyle{empty} 
\begin{document} 
etex 

u := 0.5cm;

du = 1.5mm;

beginfig(0)
	draw (-1u,0u)--(5u,0u) withcolor white;
	pickup pencircle scaled 2pt;

	draw (0u, 0u)--(0u, 4u);
	draw (3u, 0u)--(3u, 6u);
	pickup pencircle scaled 1pt;
	fill (-1u,0u)--(4u,0u){down}..(3u,-1u)..(1u,-0.5u)..{up}cycle withcolor 0.7white;
	draw (-1u,0u)--(4u,0u);

	pickup pencircle scaled 1pt;

	pickup pencircle scaled 0.5pt;
	draw (0u, 4u)--(-1u, 4u);
	drawdblarrow (-0.5u, 0u)--(-0.5u, 4u);
	label.lft(btex $h_1$ etex, (-0.5u, 2u));

	draw (3u, 6u)--(4u, 6u);
	drawdblarrow (3.5u, 0u)--(3.5u, 6u);
	label.rt(btex $h_2$ etex, (3.5u, 3u));

	drawdblarrow (0u, 1u)--(3u, 1u);
	label.top(btex $d$ etex, (1.5u, 1u));
endfig;

beginfig(1)
	draw (-1u,0u)--(5u,0u) withcolor white;
	pickup pencircle scaled 2pt;

	draw (0u, 0u)--(0u, 4u);
	draw (3u, 0u)--(3u, 6u);

	pickup pencircle scaled 1pt;
	fill (-1u,0u)--(4u,0u){down}..(3u,-1u)..(1u,-0.5u)..{up}cycle withcolor 0.7white;
	draw (-1u,0u)--(4u,0u);

	pickup pencircle scaled 1pt;

	drawarrow (0u-du, 0u)--(0u-du, 4u);

	pickup pencircle scaled 4pt;
	drawdot (0u, 4u);
	drawdot (0u, 0u);
endfig;

beginfig(2)
	draw (-1u,0u)--(5u,0u) withcolor white;
	pickup pencircle scaled 2pt;

	draw (0u, 0u)--(0u, 4u);
	draw (3u, 0u)--(3u, 6u);
	pickup pencircle scaled 1pt;
	fill (-1u,0u)--(4u,0u){down}..(3u,-1u)..(1u,-0.5u)..{up}cycle withcolor 0.7white;
	draw (-1u,0u)--(4u,0u);

	pickup pencircle scaled 1pt;

	drawarrow (0u+du, 4u)--(0u+du, 2u);

	pickup pencircle scaled 4pt;
	drawdot (0u, 4u);
	drawdot (0u, 2u);
endfig;

beginfig(3)
	draw (-1u,0u)--(5u,0u) withcolor white;
	pickup pencircle scaled 2pt;

	draw (0u, 0u)--(0u, 4u);
	draw (3u, 0u)--(3u, 6u);
	pickup pencircle scaled 1pt;
	fill (-1u,0u)--(4u,0u){down}..(3u,-1u)..(1u,-0.5u)..{up}cycle withcolor 0.7white;
	draw (-1u,0u)--(4u,0u);


	pickup pencircle scaled 1pt;

	draw (3u, 6u)--(0u, 2u) dashed evenly;
	draw (3u, 6u)--(3u, 1u) dashed evenly;
	
	drawarrow (0u, 2u)..(3u - 5u * sind(15), 6u-5u* cosd(15))..(3u - 5u * sind(5), 6u-5u* cosd(5))..(3u - 5u * sind(1), 6u-5u* cosd(1));

	pickup pencircle scaled 0.5pt;
	draw (0u, 2u)--(4u, 2u);
	draw (0u, 1u)--(4u, 1u);

	draw (3.5u, 0.5u)--(3.5u, 4u);
	drawarrow (3.5u, 0.5u)--(3.5u, 1u);
	drawarrow (3.5u, 4u)--(3.5u, 2u);
	label.rt(btex $\le l$ etex, (3.5u, 3.5u));

	pickup pencircle scaled 4pt;
	drawdot (0u, 2u);
	drawdot (3u, 1u);
endfig;

beginfig(4)
	draw (-1u,0u)--(5u,0u) withcolor white;
	pickup pencircle scaled 2pt;

	draw (0u, 0u)--(0u, 4u);
	draw (3u, 0u)--(3u, 6u);
	pickup pencircle scaled 1pt;
	fill (-1u,0u)--(4u,0u){down}..(3u,-1u)..(1u,-0.5u)..{up}cycle withcolor 0.7white;
	draw (-1u,0u)--(4u,0u);


	pickup pencircle scaled 1pt;
	drawarrow (3u+du, 1u)--(3u+du, 6u);

	pickup pencircle scaled 4pt;
	drawdot (3u, 1u);
	drawdot (3u, 6u);
endfig;

end.

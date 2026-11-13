verbatimtex 
%&latex
\documentclass[a4paper,10pt]{article} 
\usepackage[cp1251]{inputenc} 
\usepackage[russian]{babel} 
\usepackage[dvips]{epsfig} 
\pagestyle{empty} 
\begin{document} 
etex 

u = 0.3cm;

beginfig(1)

pickup pencircle scaled 0.75pt;

draw (0u,0u)--(9u,0u)--(9u,7u)--(0u,7u)--cycle;

pickup pencircle scaled 1pt;

drawarrow (11u,3.5u)--(13u,3.5u);

pickup pencircle scaled 0.75pt;

draw ((3u,7u)--(0u,7u)--(0u,0u)--(9u,0u)--(9u,2u)) shifted (15u,0u);

draw 
((3u, 7u)--
(4u, 5u)--
(5u, 6u)--
(4u, 4u)--
(5u, 2u)--
(6u, 4u)--
(7u, 2u)--
(8u, 3u)--
(9u, 2u)) shifted (15u,0u);

endfig;

beginfig(2)

fill (-10u, 7u)--(0u, 7u)--(0u,0u)--(-10u,0u)--cycle withcolor 0.8white;
fill (3.5u, 6u)--(4u,5u)--(5u, 6u)--cycle withcolor 0.8white;
fill (4u,4u)--(5u,2u)--(6u,4u)--cycle withcolor 0.8white;
fill (6.5u,3u)--(7u,2u)--(8u,3u)--cycle withcolor 0.8white;

pickup pencircle scaled 2pt;
draw (-10u, 7u)--(9u, 7u)--(9u, -3u);

pickup pencircle scaled 1pt;
drawarrow (-5u,3.5u)--(-3u,3.5u);

pickup pencircle scaled 0.75pt;

draw (3u,7u)--(0u,7u)--(0u,0u)--(9u,0u)--(9u,2u);

draw 
(3u, 7u)--
(4u, 5u)--
(5u, 6u)--
(4u, 4u)--
(5u, 2u)--
(6u, 4u)--
(7u, 2u)--
(8u, 3u)--
(9u, 2u);

label.bot(btex искомая etex, (12u,4u)) withcolor white;
label.bot(btex площадь etex, (12u,3u)) withcolor white;

endfig;

beginfig(3)

fill (-10u, 7u)--(3u, 7u)--(3.5u,6u)--(5u, 6u)--
	(4u,4u)--(6u,4u)--(6.5u,3u)--(8u,3u)--
	(9u,2u)--(9u,0u)--(-10u,0u)--cycle
	 withcolor 0.8white;

pickup pencircle scaled 2pt;
draw (-10u, 7u)--(9u, 7u)--(9u, -3u);

pickup pencircle scaled 0.75pt;
draw (3u, 7u)--(3.5u,6u)--(5u, 6u)--
	(4u,4u)--(6u,4u)--(6.5u,3u)--(8u,3u)--
	(9u,2u)--(9u,7u)--cycle
	withcolor white dashed evenly;

draw (3u, 7u)--(3.5u,6u)--(5u, 6u)--
	(4u,4u)--(6u,4u)--(6.5u,3u)--(8u,3u)--
	(9u,2u)
	dashed evenly;

drawarrow (12u, 4u)--(7u, 5u);
label.bot(btex искомая etex, (12u,4u));
label.bot(btex площадь etex, (12u,3u));

endfig;

end.
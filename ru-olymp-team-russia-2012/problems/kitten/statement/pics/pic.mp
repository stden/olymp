verbatimtex
%&latex
\documentclass{minimal}
\begin{document}
etex
beginfig(0);                    
u = 0.9cm;
draw (0, 1.5u)--(0, -1.5u);
draw (u, 1.5u)--(u, -1.5u);
draw (2u, 1.5u)--(2u, -1.5u);
draw (3u, 1.5u)--(3u, -1.5u);
draw (0, 1.5u)--(3u, 1.5u);
draw (0, 0.5u)--(3u, 0.5u);
draw (0, -1.5u)--(3u, -1.5u);
draw (0, -0.5u)--(3u, -0.5u);

picture table;
table := currentpicture;
currentpicture := nullpicture;

pickup pencircle scaled 0.2u;
draw (-0.4u, 0)..(-0.3u, 0.25u)..(0, 0.35u)..(0.3u, 0.25u)..(0.4u, 0);
draw (-0.4u, 0)..(-0.3u, -0.25u)..(0, -0.35u)..(0.3u, -0.25u)..(0.4u, 0);
fill fullcircle xscaled 0.15u yscaled 0.5u shifted(0,0.05u) withcolor black;

picture catEye;
catEye := currentpicture;
currentpicture := nullpicture;

pickup pencircle scaled 0.08u;
draw fullcircle scaled u;
draw (-0.4u, 0.3u)--(-0.4u, 0.65u)--(-0.26u, 0.43u);
draw (0.4u, 0.3u)--(0.4u, 0.65u)--(0.26u, 0.43u);
draw catEye scaled 0.01u shifted(-0.17u, 0.17u);
draw catEye scaled 0.01u shifted(0.17u, 0.17u);
draw (-0.15u, -0.1u)--(-0.7u, -0.0u);
draw (-0.15u, -0.15u)--(-0.7u, -0.15u);
draw (-0.15u, -0.2u)--(-0.7u, -0.25u);

draw (0.15u, -0.1u)--(0.7u, -0.0u);
draw (0.15u, -0.15u)--(0.7u, -0.15u);
draw (0.15u, -0.2u)--(0.7u, -0.25u);

draw (-0.2u, -0.22u)..(-0.2005.u,-0.24u)..(-0u,-0.2u);
draw (0.2u, -0.22u)..(0.2005.u,-0.24u)..(0u,-0.2u);
fill fullcircle xscaled 0.07u yscaled 0.13u shifted(0,-0.2u) withcolor black;
draw halfcircle shifted(0, 0.085u) scaled 0.15u rotated 180;
picture cat;
cat := currentpicture;
currentpicture := nullpicture;


pickup pencircle scaled 0.03u;
draw fullcircle scaled0.1u shifted(0,0.1u);
draw (0,0.05u)--(0,-0.16u)--(-0.05u,-0.35u)--(0,-0.16u)--(0.05u,-0.35u);
draw (0,0)--(-0.07u,-0.11u);
draw (0,0)--(0.07u,-0.11u);
picture man;
man := currentpicture;
currentpicture := nullpicture;

pickup pencircle scaled 0.15u;
draw fullcircle scaled u;
draw (-0.5u, 0)--(-1u, 0);
draw (0.5u, 0)--(1u, 0);
draw (0, -0.5u)--(0, -1u);
draw (0, 0.5u)--(0, 1u);
draw (-0.71*0.5u, 0.71*0.5u)--(-1.42*0.5u, 1.42*0.5u);
draw (-0.71*0.5u, -0.71*0.5u)--(-1.42*0.5u, -1.42*0.5u);
draw (0.71*0.5u, 0.71*0.5u)--(1.42*0.5u, 1.42*0.5u);
draw (0.71*0.5u, -0.71*0.5u)--(1.42*0.5u, -1.42*0.5u);
picture sun;
sun := currentpicture;
currentpicture := nullpicture;

pickup pencircle scaled 0.1u;
draw table;
draw cat scaled 0.02u shifted(2.5u,u);
draw man scaled 0.06u shifted(0.5u,-0.8u);
draw sun scaled 0.015u shifted(1.5u, 0);

picture all;
all := currentpicture;
currentpicture := nullpicture;

draw (0u,0u)--(0u,u)--(-0.1u,0.9u)--(0u,u)--(0.1u,0.9u);
picture arrow;
arrow := currentpicture;
currentpicture := nullpicture;

pickup pencircle scaled 0.05u;

draw (0.5u, -0.5u)--(0.5u, -0.35u);
draw (0.5u, -0.25u)--(0.5u, -0.1u);
draw (0.5u, -0u)--(0.5u, 0.15u);
draw (0.5u, 0.25u)--(0.5u, 0.4u);
draw (0.5u, 0.5u)--(0.5u, 0.65u);
draw (0.5u, 0.75u)--(0.5u, u);
draw (0.45u, 0.95u)--(0.5u, u)--(0.55u, 0.95u);
picture one;
one := currentpicture;
currentpicture := nullpicture;
draw (0.6u, u)--(0.75u, u);
draw (0.85u, u)--(u, u);
draw (1.1u, u)--(1.25u, u);
draw (1.35u, u)--(1.5u, u);
draw (1.6u, u)--(1.75u, u);
draw (1.85u, u)--(2.1u, u)--(2.05u,1.05u)--(2.1u, u)--(2.05u,0.95u);
picture two;
two := currentpicture;
currentpicture := nullpicture;
draw (2.5u, 0.65u)--(2.5u,0.5u);
draw (2.5u, 0.4u)--(2.5u,0.25u);
draw (2.5u, 0.15u)--(2.5u,0u);
picture three;
three := currentpicture;
currentpicture := nullpicture;
draw (2.4u, 0u)--(2.25u,0u);
draw (2.15u, 0u)--(1.95u,0u)--(2u,0.05u)--(1.95u,0u)--(2u,-0.05u);
picture four;
four := currentpicture;
currentpicture := nullpicture;
draw all;
draw one;
draw two;
draw three;
draw four;
draw all shifted(4u, 0);
draw two shifted(4.3u, -2u);
draw one shifted(5.9u, -0.4u);
draw three rotated -90 shifted (5.5u, 3.5u);
draw four rotated 90 shifted (5.5u, -1.5u);
endfig;
end
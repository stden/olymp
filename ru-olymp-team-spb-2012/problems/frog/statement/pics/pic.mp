beginfig(0);

u = 0.9cm;

draw (-0.18u, 0)..(-0.18u, 0.25u)..(0, 0.4u)..(0.18u, 0.25u)..(0.18u, 0);
fill fullcircle scaled 0.13u shifted (0, 0.17u) withcolor black; 
picture frogEye;
frogEye := currentpicture;
currentpicture := nullpicture;

draw (-0.7u, 0){up}..(0, 0.4u)..{down}(0.7u, 0)--cycle;
draw frogEye rotated 10 shifted (-0.3u, 0.37u);
draw frogEye rotated -10 shifted (0.3u, 0.37u);
draw (-0.15u, 0.07u)--(0.15u, 0.07u);
picture billy;
billy := currentpicture;
currentpicture := nullpicture;

draw (-0.075u, 0)..(-0.075u, 0.15u)..(0, 0.24u)..(0.075u, 0.15u)..(0.075u, 0);
picture wing;
wing := currentpicture;
currentpicture := nullpicture;

draw fullcircle scaled 0.3u;
draw wing shifted (0, 0.15u) rotated 65;
draw wing shifted (0, 0.15u) rotated 50;
draw wing shifted (0, 0.15u) rotated -65;
draw wing shifted (0, 0.15u) rotated -50;
picture fly;
fly := currentpicture;
currentpicture := nullpicture;

drawarrow (0, 0)--(11u, 0);
draw (0, 0.1u)--(0, -0.08u);
label.bot(btex 0 etex, (0, 0));
draw (2u, 0.1u)--(2u, -0.08u);
label.bot(btex 1 etex, (2u, 0));
draw (4u, 0.1u)--(4u, -0.08u);
label.bot(btex 2 etex, (4u, 0));
draw (6u, 0.1u)--(6u, -0.08u);
label.bot(btex 3 etex, (6u, 0));
draw (8u, 0.1u)--(8u, -0.08u);
label.bot(btex 4 etex, (8u, 0));
draw (10u, 0.1u)--(10u, -0.08u);
label.bot(btex 5 etex, (10u, 0));
picture axis;
axis := currentpicture;
currentpicture := nullpicture;

draw axis;
draw billy shifted (0, 0.15u);
draw fly shifted (4u, 0.4u);
drawarrow (4u-0.4u, 0.4u)--(3u , 0.4u) dashed evenly;
draw fly shifted (8u-0.15u, 0.30u);
draw fly shifted (8u+0.15u, 0.75u);
drawarrow (8u+0.25u, 0.30u)--(9u, 0.3u) dashed evenly;
drawarrow (8u+0.55u, 0.75u)--(9u+0.3u, 0.75u) dashed evenly;
draw fly shifted (6u+0.17u, 0.27u);
label.top(btex * etex, (6u+0.09u, 0.23u));
label.top(btex * etex, (6u+0.29u, 0.30u));
label.top(btex * etex, (6u+0.19u, 0.20u));
draw fly shifted (6u-0.15u, 0.75u);
drawarrow (6u-0.3u, u)..(3u, 1.7u)..(0.6u, 0.43u) dashed evenly;
picture fst;
fst := currentpicture;
currentpicture := nullpicture;

draw axis;
draw billy shifted (0, 0.15u);
draw fly shifted (2u, 0.4u);
draw fly shifted (10u-0.15u, 0.25u);
draw fly shifted (10u+0.17u, 0.7u);
draw fly shifted (6u+0.17u, 0.27u);
picture snd;
snd := currentpicture;
currentpicture := nullpicture;

draw fst;
draw snd shifted (0, -2u);


endfig;
end.

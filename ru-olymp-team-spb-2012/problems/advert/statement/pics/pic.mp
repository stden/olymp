u:=0.5cm;
beginfig(1)
    
    pair A, B, C, D;
    A:=(0u,0u); B:=(10u,0u); C:=(10u,7u); D:=(0u,7u);
    
    pair E, F, G;
    E:=(0,2u); F:=(3u,2u); G:=(7u,2u);
    
    pair H, I, J;
    H:=(0,4u); I:=(3u,4u); J:=(7u,4u);
    
    pair K, L;
    K:=(4u,4u);L:=(4u,7u);
    
    draw A--B--C--D--cycle withpen pencircle scaled 2pt;
    draw E--F--I--H--cycle withpen pencircle scaled 1.5pt;
    draw F--G--J--I--cycle withpen pencircle scaled 1.5pt;
    draw D--H--K--L--cycle withpen pencircle scaled 1.5pt;

    drawdblarrow (0,5u)--(4u,5u) withpen pencircle scaled 0.75pt;
    label.top(btex $k \cdot a_1$ etex, (2u,5u));

    drawdblarrow (0,3u)--(3u,3u) withpen pencircle scaled 0.75pt;
    label.top(btex $k \cdot a_2$ etex, (3/2u,3u));

    drawdblarrow (3u,3u)--(7u,3u) withpen pencircle scaled 0.75pt;
    label.top(btex $k \cdot a_3$ etex, (5u,3u));

    draw (0u,7u)--(0,8u) withpen pencircle scaled 0.75pt; draw(10u,7u)--(10u,8u) withpen pencircle scaled 0.75pt;
    drawdblarrow (0u,15/2u)--(10u,15/2u);
    label.top(btex $W$ etex, (5u,15/2u));

    draw (10u,0u)--(11u,0u) withpen pencircle scaled 0.75pt; draw(10u,7u)--(11u,7u) withpen pencircle scaled 0.75pt;
    drawdblarrow (21/2u,0u)--(21/2u,7u) withpen pencircle scaled 0.75pt;
    label.rt(btex $H$ etex, (21/2u,7/2u));

    drawdblarrow (9/2u,4u)--(9/2u,7u) withpen pencircle scaled 0.75pt;
    label.rt(btex $k \cdot b_1$ etex, (9/2u,11/2u));

    draw (7u,2u)--(8u,2u) withpen pencircle scaled 0.75pt; draw(7u,4u)--(8u,4u) withpen pencircle scaled 0.75pt;
    drawdblarrow (15/2u,2u)--(15/2u,4u) withpen pencircle scaled 0.75pt;
    label.rt(btex $k \cdot b_3$ etex, (15/2u,3u));

    draw (-1u,2u)--(0,2u) withpen pencircle scaled 0.75pt; draw(-1u,4u)--(0u,4u) withpen pencircle scaled 0.75pt;
    drawdblarrow (-1/2u,2u)--(-1/2u,4u) withpen pencircle scaled 0.75pt;
    label.lft(btex $k \cdot b_2$ etex, (-1/2u,3u));

endfig;


end.
                                 
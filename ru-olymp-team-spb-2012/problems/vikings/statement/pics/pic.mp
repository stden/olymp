u=1.8cm;

beginfig(1)
    pair X, Y, A, B;
    draw fullcircle scaled 2u;
    draw (-u, 0)--(0.46205u, 0.886853u);
    Y = (0, 1.3u);
    label.top("Y", Y);
    X = (1.3u, 0);
    label.urt("X", X);
    draw (-1.2u, 0)--(1.3u, 0);    
    draw (0, -1.2u)--(0, 1.3u);    
    draw (-0.02u, 1.3u - 0.04u)--(0, 1.3u);    
    draw (0.02u, 1.3u - 0.04u)--(0, 1.3u);        
    draw (1.3u - 0.04u, -0.02u)--(1.3u, 0);    
    draw (1.3u - 0.04u, 0.02u)--(1.3u, 0);   
    A = (-u, 0);
    dotlabel.ulft(btex $(-1.0,0)$ etex, A);
    B = (0.46205u, 0.886853u);
    dotlabel.urt(btex $(0.46205,0.886853)$ etex, B);
endfig;

end.
                                 

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

def labels =
    label(btex \small Сцена etex, (3.0, 2.5) scaled u);
    label.lft(btex \small Левая часть кулис etex, (-1.0, 2.5) scaled u);
    label.rt(btex \small Правая часть кулис etex, (7.0, 2.5) scaled u);
    dotlabel.lrt("(0,0)", (0.0, 0.0) scaled u);
    dotlabel.lrt("(L,0)", (6.0, 0.0) scaled u);
    dotlabel.urt("(0,W)", (0.0, 5.0) scaled u);
    dotlabel.urt("(L,W)", (6.0, 5.0) scaled u);
    dotlabel.urt("", (1.0, 2.0) scaled u);
    dotlabel.urt("", (3.0, 4.0) scaled u);
    dotlabel.urt("", (5.0, 3.0) scaled u);
enddef;

beginfig(1)
    fill ((0, 0) -- (-1.0, 0) -- (-1.0, 5) -- (0, 5) -- cycle) scaled u withcolor 0.7white;
    fill ((6, 0) -- (7, 0) -- (7, 5) -- (6, 5) -- cycle) scaled u withcolor 0.7white;
    
    pickup pencircle scaled 1pt;
    draw ((0, 0) -- (6, 0) -- (6, 5) -- (0, 5) -- cycle) scaled u withcolor black;
    labels;
endfig;

end.

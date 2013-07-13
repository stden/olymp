uses
    rng, sysutils;

var
    i, j, k: longint;
    u: array [1..9, 1..30] of boolean;
    t: longint;

procedure make(i, j: longint);
begin
    if u[i][j] then exit;
    inc(t);
    rewrite(output, inttostr(t div 10) + inttostr(t mod 10));
    writeln(i, ' ', j);
    close(output);
    u[i][j] := true;
end;

begin
    t := 0;
    make(3, 3);
    make(3, 10);
    for i := 1 to 10 do begin
        make(1, i)
    end;
                
    make(1, 27);
    make(1, 30);
    make(2, 30);
    make(2, 24);

    for i := 1 to 30 do
        make(3, i);

    for i := 1 to 10 do begin
        make(6, random(30) + 1);
        make(9, random(30) + 1);
    end;

    make(9, 27);
    make(9, 30);
    make(8, 30);
    make(7, 30);
    make(8, 27);

    for i := 1 to 10 do begin
        repeat
            j := random(9) + 1;
            k := random(30) + 1;
        until not u[j][k] and (j * k mod 3 <> 0);
        make(j, k);
    end;

    while t < 80 do begin
        repeat
            j := random(9) + 1;
            k := random(30) + 1;
        until not u[j][k] and (j * k mod 3 = 0);
        make(j, k);
    end;
end.
{$r+,q+,o-}
{$apptype console}
type
    int = longint;

const
    MAXN = 1500;
    MAXV = 1000000000;

var
    currentTestNumber: int;
    x, y: array [1..MAXN] of int;
    n: integer;

procedure writeTest();
var
    fp: TEXT;
    i: int;

begin
    rewrite(fp, chr(ord('0') + (currentTestNumber div 10)) + chr(ord('0') + (currentTestNumber mod 10)));
    inc(currentTestNumber);
    writeln(fp, n);
    for i := 1 to n do begin
        if ((abs(x[i]) > MAXV) or (abs(y[i]) > MAXV)) then begin
            writeln('Internal error, sorry :(');
            halt(239);
        end;
        writeln(fp, x[i], ' ', y[i]);
    end;
    close(fp);
end;

procedure generateRectangleTest(u, v: int; x1, y1: int);
var
    i, j: int;

begin
    n := 0;
    for i := 0 to u - 1 do begin
        for j := 0 to v - 1 do begin
            inc(n);
            x[n] := x1 + i;
            y[n] := y1 + j;
        end;
    end;
    writeTest();
end;

procedure generateRandomTest(u, maxv: int);
var
    i, j: int;
    bad: boolean;

begin
    n := u;
    for i := 1 to n do begin
        while (true) do begin
            x[i] := random(2 * maxv + 1) - maxv;
            y[i] := random(2 * maxv + 1) - maxv;
            bad := false;
            for j := 1 to i - 1 do begin
                if ((x[i] = x[j]) and (y[i] = y[j])) then begin
                    bad := true;
                    break;
                end;
            end;
            if (not bad) then
                break;
        end;
    end;
    writeTest();
end;

{ no three points lie on the same line }
procedure generateRandomTest2(u, maxv: int);
var
    i, j, k: int;
    dx1, dy1, dx2, dy2: int;
    bad: boolean;

begin
    n := u;
    for i := 1 to n do begin
        while (true) do begin
            x[i] := random(2 * maxv + 1) - maxv;
            y[i] := random(2 * maxv + 1) - maxv;
            bad := false;
            for j := 1 to i - 1 do begin
                for k := 1 to j - 1 do begin
                    dx1 := x[i] - x[k];
                    dy1 := y[i] - y[k];
                    dx2 := x[j] - x[k];
                    dy2 := y[j] - y[k];
                    if (dx1 * dy2 = dx2 * dy1) then begin
                        bad := true;
                        break;
                    end;
                end;
            end;
            if (not bad) then
                break;
        end;
    end;
    writeTest();
end;

procedure generateOneLineTest(u, v, x0, y0, dx, dy, tMin, tMax: int);
var
    i, j: int;
    bad: boolean;

begin
    n := u + v;
    for i := 1 to u do begin
        while (true) do begin
            x[i] := x0 + dx * (random(tMax - tMin + 1) + tMin);
            y[i] := y0 + dy * (random(tMax - tMin + 1) + tMin);
            bad := false;
            for j := 1 to i - 1 do begin
                if ((x[i] = x[j]) and (y[i] = y[j])) then begin
                    bad := true;
                    break;
                end;
            end;
            if (not bad) then
                break;
        end;
    end;
    for i := u + 1 to u + v do begin
        while (true) do begin
            x[i] := random(2 * MAXV + 1) - MAXV;
            y[i] := random(2 * MAXV + 1) - MAXV;
            bad := false;
            for j := 1 to i - 1 do begin
                if ((x[i] = x[j]) and (y[i] = y[j])) then begin
                    bad := true;
                    break;
                end;
            end;
            if (not bad) then
                break;
        end;
    end;
    writeTest();
end;
                          
var
    i: int;

begin
    randseed := 452582758;
    currentTestNumber := 1;

    { no three points lie on the same line small tests }
    for i := 1 to 10 do begin
        generateRandomTest2(50 * i - random(10), 100 * i);
    end;
    
    { some big one line tests }
    generateOneLineTest(1000, 500, random(1000), random(1000), 2, 3, -1000, 1000);
    generateOneLineTest(1400, 100, random(1000000), random(1000000), random(1000) + 1, random(1000) + 1, -1000, 1000);
    generateOneLineTest(1400, 100, random(1000000), random(1000000), random(1000) + 1, random(1000) + 1, -1000, 1000);
    generateOneLineTest(1400, 100, random(1000000), random(1000000), random(1000) + 1, random(1000) + 1, -1000, 1000);
    generateOneLineTest(1400, 100, random(1000000), random(1000000), random(1000) + 1, random(1000) + 1, -1000, 1000);
    
    { some big random tests }
    generateRandomTest(1500 - random(100), 50);
    generateRandomTest(1500 - random(100), 50);
    generateRandomTest(1500 - random(100), 50);
    generateRandomTest(1500 - random(100), 50);
    generateRandomTest(1500 - random(100), 50);
    
    { some big rectangular tests }
    generateRectangleTest(38, 38, 239, -566);
    generateRectangleTest(50, 30, random(1000000), random(1000000));
    generateRectangleTest(100, 15, -random(1000000), -random(1000000));
    generateRectangleTest(150, 10, random(1000000), -random(1000000));
    generateRectangleTest(35, 42, -random(1000000), random(1000000));
end.

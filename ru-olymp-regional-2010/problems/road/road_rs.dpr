{$r+,q+,o-}
{$apptype console}
uses
    SysUtils, Math;

type
    int = longint;

const
    eps = 1e-9;

var
    x, y: array [1..4] of int;
    xc, yc: array [1..7] of extended;
    ansx, ansy, ansr: extended;
    count: int;
    inf: boolean;

procedure testCircle(u, v, k: int);
var
    a1, b1, c1, a2, b2, c2: int;
    d: int;

begin
    a1 := 2 * (x[v] - x[u]);
    b1 := 2 * (y[v] - y[u]);
    c1 := (-a1 * (x[u] + x[v]) - b1 * (y[u] + y[v])) div 2;

    a2 := 2 * (x[k] - x[u]);
    b2 := 2 * (y[k] - y[u]);
    c2 := (-a2 * (x[u] + x[k]) - b2 * (y[u] + y[k])) div 2;

    d := a1 * b2 - a2 * b1;
    if (d = 0) then
        exit;

    inc(count);
    xc[count] := -1.0 * (c1 * b2 - c2 * b1) / d;
    yc[count] := -1.0 * (a1 * c2 - a2 * c1) / d;
end;

procedure testCircle2(i, j, u, v: int);
var
    a1, b1, c1, a2, b2, c2: int;
    x0, y0, r0: extended;
    d: int;

begin
    a1 := 2 * (x[j] - x[i]);
    b1 := 2 * (y[j] - y[i]);
    c1 := (-a1 * (x[i] + x[j]) - b1 * (y[i] + y[j])) div 2;

    a2 := 2 * (x[v] - x[u]);
    b2 := 2 * (y[v] - y[u]);
    c2 := (-a2 * (x[u] + x[v]) - b2 * (y[u] + y[v])) div 2;

    d := a1 * b2 - a2 * b1;
    if (d = 0) then begin
        if ((a1 * c2 = a2 * c1) and (b1 * c2 = b2 * c1)) then begin
            x0 := (x[i] + x[j]) / 2.0;
            y0 := (y[i] + y[j]) / 2.0;
            r0 := (hypot(x0 - x[i], y0 - y[i]) + hypot(x0 - x[u], y0 - y[u])) / 2.0;
            if (r0 < ansr) then begin
                ansr := r0;
                ansx := x0;
                ansy := y0;
            end;
            inf := true;
            exit;
        end;
        exit;
    end;

    inc(count);
    xc[count] := -1.0 * (c1 * b2 - c2 * b1) / d;
    yc[count] := -1.0 * (a1 * c2 - a2 * c1) / d;
end;

var
    u, v, k, i, j: int;
    minDist, maxDist, dist, r0: extended;
    answer: int;

label
    ENDLOOP;

begin
    reset(input, 'road.in');
    rewrite(output, 'road.out');

    for i := 1 to 4 do begin
        read(x[i], y[i]);
    end;

    ansx := 0.0;
    ansy := 0.0;
    ansr := 1e100;

    for u := 1 to 4 do begin
        for v := u + 1 to 4 do begin
            for k := v + 1 to 4 do begin
                testCircle(u, v, k);
            end;
        end;
    end;

    for i := 1 to count do begin
        for j := 1 to i - 1 do begin
            if (abs(xc[i] - xc[j]) < eps) and (abs(yc[i] - yc[j]) < eps) then begin
                writeln('Infinity');
                writeln(xc[i]: 0: 8, ' ', yc[i]: 0: 8, ' ', 0.0: 0: 8);
                exit;
            end;
        end;
    end;

    inf := false;
    for i := 1 to 4 do begin
        for j := 1 to i - 1 do begin
            for u := 1 to i - 1 do begin
                for v := 1 to u - 1 do begin
                    if ((u = i) or (u = j) or (v = i) or (v = j)) then
                        continue;

                    testCircle2(i, j, u, v);
                end;
            end;
        end;
    end;

    answer := 0;
    for i := 1 to count do begin
        for j := 1 to i - 1 do begin
            if (abs(xc[i] - xc[j]) < eps) and (abs(yc[i] - yc[j]) < eps) then begin
                goto ENDLOOP;
            end;
        end;
        inc(answer);
ENDLOOP:
    end;

    if (inf) then begin
        writeln('Infinity');
    end else begin
        writeln(answer);
    end;

    for i := 1 to count do begin
        maxDist := -1e100;
        minDist := 1e100;
        for j := 1 to 4 do begin
            dist := hypot(xc[i] - x[j], yc[i] - y[j]);
            maxDist := max(maxDist, dist);
            minDist := min(minDist, dist);
        end;
        r0 := (minDist + maxDist) / 2.0;
        if (r0 < ansr) then begin
            ansx := xc[i];
            ansy := yc[i];
            ansr := r0;
        end;
    end;
    writeln(ansx: 0: 8, ' ', ansy: 0: 8, ' ', ansr: 0: 8);
end.

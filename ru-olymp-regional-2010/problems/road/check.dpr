// checker accepts the solution if center of the circle is equidistant
// with absolute or relative error eps (see below)

{$r+,q+,o-}
{$apptype console}
uses
    SysUtils, TestLib, Math;

const
    eps = 1.1e-5;

function readNumber(str: string; juryMode: boolean): integer;
var
    strNumber, errorPos: integer;

begin
    if (str = 'Infinity') then begin
        result := -1;
        exit;
    end;

    val(str, strNumber, errorPos);
    if (errorPos <> 0) then begin
        if (juryMode) then
            quit(_fail, format('Can''t parse: %s', [str]))
        else
            quit(_pe, format('Can''t parse: %s', [str]))
    end;
    result := strNumber;
end;

var
    ja, pa: integer;
    x0, y0, r0, dist, minr: extended;
    jaString, paString: string;
    x, y, d: array [1..4] of extended;
    i: integer;

begin
    jaString := ans.readstring();
    paString := ouf.readstring();
    ja := readNumber(jaString, true);
    pa := readNumber(paString, false);

    x0 := ouf.readreal();
    y0 := ouf.readreal();
    r0 := ouf.readreal();

    if (ja <> pa) then begin
        quit(_wa, format('Expected: %s, got: %s', [jaString, paString]));
    end;

    for i := 1 to 4 do begin
        x[i] := inf.readreal();
        y[i] := inf.readreal();
        dist := hypot(x[i] - x0, y[i] - y0);
        if (dist > r0) then
            d[i] := dist - r0
        else
            d[i] := r0 - dist;  
    end;

    for i := 2 to 4 do begin
        if (abs(d[i] - d[1]) > eps) and (abs(d[i] - d[1]) > eps * d[i]) then
            quit(_wa, format('not equidistant road: d[1] = %.6f, d[%d] = %.6f', [d[1], i, d[i]]));
    end;

    ans.readreal();
    ans.readreal();
    minr := ans.readreal();

    if ((abs(r0 - minr) > eps) and (abs(r0 - minr) > eps * abs(minr))) then begin
        quit(_wa, format('not optimal road: expected %.6f, got: %.6f', [minr, r0]));
    end;

    quit(_ok, format('answer = %d, best radius = %.6f', [ja, minr]));
end.

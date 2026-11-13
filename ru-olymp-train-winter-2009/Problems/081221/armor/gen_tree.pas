{this program write edges of our graph to stdout}
{graph is a tree}

{$O+,Q-,R-,S-}
uses
    SysUtils;
type
    int = longint;
var
    used: array [1..100] of boolean;
    x, y: array [1..100] of int;
    i, j, d, last: int;
    n, m, k, max_price: int;
    tmp: integer;

begin
    val(paramstr(1), randseed, tmp);
    val(paramstr(2), n, tmp);
    val(paramstr(3), m, tmp);
    val(paramstr(4), k, tmp);
    val(paramstr(5), max_price, tmp);

    fillchar(used, sizeof(used), 0);
    used[n] := true;
    for i := 1 to n - 1 do
        if m >= i then begin
            d := random(n) + 1;
            while not used[d] do begin
                inc(d);
                if d > n then d := 1;
            end;
            last := random(n) + 1;
            while used[last] do begin
                inc(last);
                if last > n then last := 1;
            end;
            writeln(d, ' ', last, ' ', (random(max_price div 100) + 1) * 100);
            x[i] := d;
            y[i] := last;
            used[last] := true;
            last := d;
        end;

    for i := n to m do begin
        d := random(n - 1) + 1;
        writeln(x[d], ' ', y[d], ' ', (random(max_price div 100) + 1) * 100);
    end;
end.

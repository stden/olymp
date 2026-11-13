{this program write edges of our graph to stdout}
{graph is a random graph}

{$O+,Q-,R-,S-}
uses
    SysUtils;
type
    int = longint;
var
    i, d, last: int;
    n, m, k, max_price: int;
    tmp: integer;

begin
    val(paramstr(1), randseed, tmp);
    val(paramstr(2), n, tmp);
    val(paramstr(3), m, tmp);
    val(paramstr(4), k, tmp);
    val(paramstr(5), max_price, tmp);

    for i := 1 to m do begin
        last := random(n) + 1;
        d := random(n) + 1;
        while d = last do
            d := random(n) + 1;
        writeln(d, ' ', last, ' ', (random(max_price div 100) + 1) * 100);
    end;
end.

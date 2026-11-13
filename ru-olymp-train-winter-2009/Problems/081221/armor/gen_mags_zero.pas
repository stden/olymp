{this program write magazines to stdout}

{$O+,Q-,R-,S-}
uses
    SysUtils;
type
    int = longint;
var
    i, j: int;
    where, verc, verp, n, m, k, max_price: int;
    tmp: integer;

begin
    val(paramstr(1), randseed, tmp);
    val(paramstr(2), n, tmp);
    val(paramstr(3), m, tmp);
    val(paramstr(4), k, tmp);
    val(paramstr(5), where, tmp);
    val(paramstr(6), verc, tmp);
    val(paramstr(7), verp, tmp);
    val(paramstr(8), max_price, tmp);

    writeln(n, ' ', m, ' ', k, ' ', random(n) + 1);
    for i := 1 to n do begin
        for j := 1 to k do
            if (j <> where) and (random(verc) = 0) then begin
                write((random(max_price div 100) + 1) * 100, ' ');
                if random(verp) = 0 then write(random(11), ' ')
                    else write('0 ');
            end
            else write('0 0 ');
        writeln;
    end;
end.

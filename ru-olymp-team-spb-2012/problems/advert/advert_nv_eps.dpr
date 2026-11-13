{$APPTYPE CONSOLE}
Uses SysUtils, Math;

const MAXN = 111111;
const EPS = 5e-12;

var N, W, H: longint;
    a, b: array[1..MAXN] of extended;
    i, j: longint;
    l, r, m, le, hi: extended;

begin

    assign(input, 'advert.in');
    reset(input);
    assign(output, 'advert.out');
    rewrite(output);

    read(N, W, H);
    for i := 1 to N do
        read(a[i], b[i]);
    
    l := 0;
    r := 1e10;
    for i := 1 to N do
        r := min(r, W / a[i]);

    while (r - l > eps) do
        begin
            m := (l + r) / 2;
            hi := b[1] * m; le := a[1] * m;
            
            for j := 2 to N do
                begin
                    if (b[j] <> b[j - 1]) or (le + a[j] * m > W) then
                        begin
                            le := 0;
                            hi := hi + b[j] * m;
                        end;
                    le := le + a[j] * m;
                end;
            
            if (hi > H) then r := m else l := m;
        end;
    writeln(m:0:18);
end.
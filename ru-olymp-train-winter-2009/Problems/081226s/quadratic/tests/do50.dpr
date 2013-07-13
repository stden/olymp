uses
    sysutils, math;

const
    maxd = 127;
    maxa = 512;

var
    a, b, c, x: array [0..2 * maxa + maxd] of longint;
    ta, tb, tc, tx, tm: longint;
    i, j: longint;

begin
    randseed := 50178369;

    ta := random(128);
    tb := random(128);
    tc := random(128);

    repeat
        a[ta] := 1;
        for i := ta - 1 downto 0 do
            a[i] := random(2);
        b[tb] := 1;
        for i := tb - 1 downto 0 do
            b[i] := random(2);
        c[tc] := 1;
        for i := tc - 1 downto 0 do
            c[i] := random(2);
    until tc <= maxd;

    write(ta, ' ');
    for i := ta downto 0 do
        write(' ', a[i]);
    writeln;
    write(tb, ' ');
    for i := tb downto 0 do
        write(' ', b[i]);
    writeln;
    write(tc, ' ');
    for i := tc downto 0 do
        write(' ', c[i]);
    writeln;
end.
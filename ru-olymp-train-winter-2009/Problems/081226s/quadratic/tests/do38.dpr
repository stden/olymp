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
    randseed := 9796;    

    tx := 24;
    ta := 127 - 2 * tx;
    tb := 127 - tx;

    repeat
        a[ta] := 1;
        for i := ta - 1 downto 0 do
            a[i] := 1;
        b[tb] := 1;
        for i := tb - 1 downto 0 do
            b[i] := 0;
        x[tx] := 1;
        for i := tx - 1 downto 0 do
            x[i] := 1;

        fillchar(c, sizeof(c), 0);
        for i := 0 to tx do
            for j := 0 to tb do
                c[i + j] := c[i + j] xor (x[i] * b[j]);

        for i := 0 to tx do
            for j := 0 to ta do
                c[2 * i + j] := c[2 * i + j] xor (x[i] * a[j]);

        tc := max(ta + 2 * tx, tb + tx);
        while (tc >= 0) and (c[tc] = 0) do
            dec(tc);
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
{$O-,Q+,R+}
uses
    testlib, SysUtils, Math;

const
    maxd = 127;
    maxa = 512;

var
    a, b, c, x: array [0..2 * maxa + maxd] of longint;
    ja, pa: string;
    ta, tb, tc, tx, tm: longint;
    i, j: longint;

begin
    ta := inf.readlongint;
    for i := ta downto 0 do
        a[i] := inf.readlongint;
    tb := inf.readlongint;
    for i := tb downto 0 do
        b[i] := inf.readlongint;
    tc := inf.readlongint;
    for i := tc downto 0 do
        c[i] := inf.readlongint;

    ja := ans.readstring;
    pa := ouf.readstring;

    if pa = 'no solution' then begin
        if ja = 'no solution' then
            quit(_ok, 'no solution');
        quit(_wa, '"no solution" unexpected');
    end;

    ouf.reopen;

    tx := ouf.readlongint;
    if (tx < -1) or (tx > 512) then
        quit(_wa, format('invalid polynomial degree: %d', [tx]));

    for i := tx downto 0 do
    begin
        x[i] := ouf.readlongint;
        if (x[i] <> 0) and (x[i] <> 1) then
            quit(_wa, format('invalid polynomial coefficient: %d', [x[i]]));
    end;

    for i := 0 to tx do
        for j := 0 to tb do
            c[i + j] := c[i + j] xor (x[i] * b[j]);

    for i := 0 to tx do
        for j := 0 to ta do
            c[2 * i + j] := c[2 * i + j] xor (x[i] * a[j]);

    tm := max(tc, max(2 * tx + ta, tx + tb));
    for i := 0 to tm do 
        if c[i] <> 0 then   
            quit(_wa, 'polynomial does not satisfy equation');

    if ja = 'no solution' then
        quit(_fail, 'jury thought there were no solution, but one found');

    quit(_ok, '');
end.
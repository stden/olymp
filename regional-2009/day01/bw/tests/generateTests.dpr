{$r+,q+,o-}
{$apptype console}
type
    int = longint;

const
    MAXN = 100;

var
    currentTestNumber: int;
    a, b: array [1..MAXN, 1..MAXN] of boolean;
    w, h, operation: int;

procedure writeTest();
var
    fp: TEXT;
    i, j: int;

begin
    rewrite(fp, chr(ord('0') + (currentTestNumber div 10)) + chr(ord('0') + (currentTestNumber mod 10)));
    inc(currentTestNumber);
    writeln(fp, w, ' ', h);
    for i := 1 to h do begin
        for j := 1 to w do begin
            if (a[i][j]) then
                write(fp, '1')
            else
                write(fp, '0');
        end;
        writeln(fp);
    end;
    for i := 1 to h do begin
        for j := 1 to w do begin
            if (b[i][j]) then
                write(fp, '1')
            else
                write(fp, '0');
        end;
        writeln(fp);
    end;
    for i := 1 to 4 do begin
        write(fp, operation mod 2);
        operation := operation div 2;
    end;
    writeln(fp);
    close(fp);
end;

procedure generateRandomTest(n, m: int; op: int);
var
    i, j: int;

begin
    h := n;
    w := m;
    operation := op;
    for i := 1 to h do begin
        for j := 1 to w do begin
            a[i][j] := (random(2) = 0);
            b[i][j] := (random(2) = 0);
        end;
    end;
end;

var
    op, i: int;

begin
    randseed := 272842482;
    currentTestNumber := 1;

    generateRandomTest(1, 1, random(16));
    writeTest();

    for i := 1 to 5 do begin
        generateRandomTest(1 + random(20 * i), 1 + random(20 * i), random(16));
        writeTest();
    end;

    { some big tests }
    generateRandomTest(1, 100, random(16));
    writeTest();
    generateRandomTest(100, 1, random(16));
    writeTest();
    generateRandomTest(100, 100, random(16));
    writeTest();
    
    { 16 big tests for all possible operations }
    for op := 0 to 15 do begin
        generateRandomTest(90 + random(11), 90 + random(11), op);
        writeTest();
    end;
end.

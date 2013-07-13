{$r+,q+,o-}
{$apptype console}
uses
    SysUtils, Math;

type
    int = longint;

var
    currentTestNumber: int;

procedure writeTest(mask, n: int);
var
    i: int;
    fp: TEXT;

begin
    rewrite(fp, chr(currentTestNumber div 10 + ord('0')) + chr(currentTestNumber mod 10 + ord('0')));
    inc(currentTestNumber);

    writeln(fp, n);
    for i := 0 to 3 do begin
        if ((mask and (1 shl i)) <> 0) then
            write(fp, '1')
        else
            write(fp, '0');
    end;
    writeln(fp);
    close(fp);
end;

var
    i: int;

begin
    currentTestNumber := 1;
    randseed := 2348728;

    writeTest(random(16), 2);
    writeTest(random(16), 2);
    writeTest(random(16), 3);

    // small tests
    for i := 0 to 15 do begin
        writeTest(random(8), random(9) + 2);
    end;

    // random tests
    writeTest(0, random(19) + 2);
    for i := 1 to 15 do begin
        writeTest(i, random(99999) + 2);
    end;

    // max tests
    for i := 0 to 14 do begin
        writeTest(i mod 8, 100000);
    end;
end.

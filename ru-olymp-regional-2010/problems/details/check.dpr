uses
    testlib, sysutils;
var
    s : string;
    ja, pa, rpa: int64;
    i, j, n, k, x, pk : longint;
    a, b : array [1..100000] of longint;
    c : array [1..100000] of boolean;
    p : array [1..100000] of int64;

begin
    s := ans.ReadWord(blanks, blanks);
    val(s, ja, k);
    n := inf.ReadLongint;
    for i := 1 to n do
        p[i] := inf.ReadLongint;
    s := ouf.ReadWord(blanks, blanks);
    val(s, pa, k);
    if (k <> 0) then
      quit(_pe, 'Int64 expected, but ' + s + ' found!!!');
    pk := ouf.ReadLongint;
    for i := 1 to n do
      b[i] := n;
    rpa := 0;
    for i:= 1 to pk do begin
        a[i] := ouf.ReadLongint;
        if (a[i] < 1) or (a[i] > n) then
            quit(_wa, 'Not valid job number: ' + IntToStr(a[i]));
        if (c[a[i]]) then
            quit(_wa, 'Job #' + IntToStr(a[i]) + ' appears more than once');
        inc(rpa, p[a[i]]);
        c[a[i]] := true;
        b[a[i]] := i;
    end;
    if (not (c[1])) then
      quit(_wa, 'Fisrt detail has not been done!!!');
    for i := 1 to n do begin
        k := inf.ReadLongint;
        for j := 1 to k do begin
            x := inf.ReadLongint;
            if (b[x] > b[i]) then
                quit(_wa, 'Job #' + IntToStr(x) + ' should be done before job #' + IntToStr(i));
        end;
    end;
    if (rpa <> pa) then
        quit(_wa, 'Participant''s answer does not match with his actions!!!');
    if (pa < ja) then
        quit(_fail, 'Participant is better!!! ja = ' + IntToStr(ja) + '; pa = ' + IntToStr(pa));
    if (pa > ja) then
        quit(_wa, 'Wrong answer: ja = ' + IntToStr(ja) + '; pa = ' + IntToStr(pa));
    quit(_ok, inttostr(ja));
end.

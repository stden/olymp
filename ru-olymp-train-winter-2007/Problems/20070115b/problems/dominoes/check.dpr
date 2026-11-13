uses
    testlib, sysutils;
var
    ja, pa: string;
    i: longint;
    m, n: longint;
begin
    m := inf.readlongint;
    n := inf.readlongint;

    ja := ans.readstring;
    pa := ouf.readstring;
    pa := trim(pa);

    if pa = '' then begin
        quit(_pe, 'Empty file');
    end;

    if not (pa[1] in ['-', '0'..'9']) then
        quit(_pe, 'invalid character in answer');
    for i := 2 to length(pa) do
        if not (pa[i] in ['0'..'9']) then
            quit(_pe, 'invalid character in answer');

    if ja <> pa then
        quit(_wa, 'expected: "' + ja + '", found: "' + pa + '"');

    quit(_ok, format('m = %d, n = %d, ans = %s', [m, n, pa]));
end.
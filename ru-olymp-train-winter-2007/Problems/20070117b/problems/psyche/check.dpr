uses
    testlib, SysUtils;
var
    ja, pa: string;
    i: longint;

function compress(s: string): string;
begin
    if length(s) > 100 then
        compress := copy(s, 1, 40) + '...' + copy(s, length(s) - 39, 40)
    else
        compress := s;
end;

begin
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

    quit(_ok, compress(ja));
end.
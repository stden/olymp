uses
    testlib, sysutils;
var
    ja, pa: string;
    i, l: longint;

function compress(s: string): string;
begin
    if length(s) < 100 then
        compress := s
    else
        compress := copy(s, 1, 50) + '..' + copy(s, length(s) - 24, 50);
end;

begin
    ja := ans.readword(blanks, blanks);
    pa := ouf.readword(blanks, blanks);

    if not (pa[1] in ['-', '0'..'9']) then
        quit(_pe, 'invalid character in answer');
    for i := 2 to length(pa) do
        if not (pa[i] in ['0'..'9']) then
            quit(_pe, 'invalid character in answer');

    if ja <> pa then
        quit(_wa, 'expected: "' + compress(ja) + '", found: "' + compress(pa) + '"');

    quit(_ok, compress(ja));
end.
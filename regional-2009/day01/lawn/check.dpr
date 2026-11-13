uses
  testlib, SysUtils;

var
  ja, pa: string;

begin
  ja := ans.readstring;
  pa := ouf.readstring;

  if ja <> pa then
    quit(_wa, 'Expected: ' + ja + ', found: ' + pa);

  quit(_ok, pa);
end.

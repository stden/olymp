uses
  testlib, sysutils;

var
  ja, pa: longint;

begin
  ja := ans.readlongint;
  pa := ouf.readlongint;

  if ja <> pa then   quit(_wa, 'Expected: ' + inttostr(ja) + ', found: ' + inttostr(pa));

  quit(_ok, 'Ok: ' + inttostr(ja));
end.

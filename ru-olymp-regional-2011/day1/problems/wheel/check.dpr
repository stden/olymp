program ncmp1;

uses
  testlib, sysutils;


var
  j, p: longint;

begin
	j := ans.readlongint;
  p := ouf.readlongint;

  if j <> p then
    quit(_wa, 'number differ - expected: "' + inttostr(j) + 
      '", found: "' + inttostr(p) + '"');
  quit(_ok, inttostr(j));
end.

uses
  testlib, SysUtils;


var
  j, p: longint;

begin
	j := ans.readlongint;
    p := ouf.readlongint;

    if j <> p then
      quit(_wa,'���������: "' + inttostr(j) + '", �������� �����: "' + inttostr(p) + '"');
  quit(_ok,  inttostr(p));
end.

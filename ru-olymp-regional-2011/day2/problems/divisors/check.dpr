uses
  testlib, SysUtils;


var
  j, p: longint;

begin
	j := ans.readlongint;
    p := ouf.readlongint;

    if j <> p then
      quit(_wa,'ќжидалось: "' + inttostr(j) + '", участник вывел: "' + inttostr(p) + '"');
  quit(_ok,  inttostr(p));
end.

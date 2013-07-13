{$O-,Q+,R+}
{$APPTYPE CONSOLE}
uses convert in '..\convert.pas', SysUtils;

var in1:tarrstr;
    n1, n2, ans:string;

procedure myfunc;
begin
  n1:=getword (',');
  n2:=getword (' ');
  ans:=getword (' ');
end;

procedure myclose;
begin
  writeln (n1, ' ', n2);
  writeln (answer, ans);
end;

begin
  process (myfunc, myclose);
end.
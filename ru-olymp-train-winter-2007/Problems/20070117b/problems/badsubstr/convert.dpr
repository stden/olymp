{$O-,Q+,R+}
{$APPTYPE CONSOLE}
uses convert in '..\convert.pas', SysUtils;

var in1:tarrstr;
    num, ans:string;

procedure myfunc;
begin
  num:=getword (' ');
  ans:=getword (' ');
end;

procedure myclose;
begin
  writeln (num);
  writeln (answer, ans);
end;

begin
  process (myfunc, myclose);
end.
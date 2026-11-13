{$APPTYPE CONSOLE}
Program GenTests;
uses SysUtils;

var i, k, m, n: Integer;

BEGIN
 n := StrToInt (ParamStr (1));
 k := StrToInt (ParamStr (2));
 m := 1 shl n;
 writeln (n);
 for i := 1 to m do
  writeln (k);
END.

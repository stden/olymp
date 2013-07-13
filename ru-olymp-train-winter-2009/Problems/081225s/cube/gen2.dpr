{$APPTYPE CONSOLE}
Program GenTests;
uses SysUtils;

var i, k, l, m, n: Integer;

BEGIN
 n := StrToInt (ParamStr (1));
 k := StrToInt (ParamStr (2));
 l := StrToInt (ParamStr (3));
 randseed := StrToInt (ParamStr (4));
 m := 1 shl n;
 writeln (n);
 for i := 1 to m do
  writeln (random (l - k + 1) + k);
END.

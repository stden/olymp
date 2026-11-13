{$Q-}
uses SysUtils;
type integer = longint;
var n,i:integer;
        p:double;

function rnd:integer;
begin
        if (random<p) then rnd:=0
        else rnd:=1;
end;


begin
        n:=StrToInt(ParamStr(1));
        p:=StrToFloat(ParamStr(2));
        randseed:=n*3223794+32489;
        for i:=1 to n do 
                write(chr(ord('0')+rnd));
        writeln;
end.

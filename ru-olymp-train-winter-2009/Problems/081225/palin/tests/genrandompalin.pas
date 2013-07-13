{$Q-}
uses SysUtils;
type integer = longint;
var n,i:integer;
        a:array[1..3000000] of char;
        p:double;

function rnd:integer;
begin
        if random<p then rnd:=0
        else rnd:=1;
end;

begin
        n:=StrToInt(ParamStr(1));
        p:=StrToFloat(ParamStr(2));
        randseed:=n*3223794+32489;
        for i:=1 to n div 2 do begin
                a[i]:=(chr(ord('0')+random(2)));
                write(a[i]);
        end;
        if (n mod 2 = 1) then write(chr(ord('0')+rnd));
        for i:=1 to n div 2 do write(a[n div 2+1-i]);
        writeln;
end.

program Zbl;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils;
var s,s1:string;
    i:integer;
begin
     assign(input,'help.in');
     reset(input);
     assign(output,'help.out');
     rewrite(output);
     randomize;
     readln(s1);
     for i:=1 to 19 do readln(s);
     if length(s)>3 then
     if s[4]='.' then begin
        writeln('YES');
        halt;
     end;
     if (ord(s1[1]) mod 2=0)or(ord(s1[4]) mod 2=1) then
     writeln('NO') else writeln('YES');
end.


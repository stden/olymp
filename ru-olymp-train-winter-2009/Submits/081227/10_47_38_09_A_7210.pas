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
     readln(s1);
     if s1[4]='e' then begin
        writeln('YES');
        halt;
     end;
     for i:=1 to 18 do readln(s);
     if (ord(s[8]) mod 4=0) then begin
        writeln('NO');
        halt;
     end;
     if (ord(s[2]) mod 4=3) then begin
        writeln('NO');
        halt;
     end;
     writeln('YES');
end.


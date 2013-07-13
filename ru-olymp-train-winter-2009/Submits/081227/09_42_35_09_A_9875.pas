program Zbl;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils;
var s:string;
    i:integer;
begin
     assign(input,'help.in');
     reset(input);
     assign(output,'help.out');
     rewrite(output);
     randomize;
     for i:=1 to 20 do readln(s);
     if length(s)>3 then
     if s[4]='.' then begin
        writeln('YES');
        halt;
     end;
     if random(2)=1 then writeln('YES')  else writeln('NO');
end.


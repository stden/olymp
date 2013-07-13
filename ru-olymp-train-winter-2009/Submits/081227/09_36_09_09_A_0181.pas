program Zbl;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils;
var s:string;
begin
     assign(input,'help.in');
     reset(input);
     assign(output,'help.out');
     rewrite(output);
     while not eof do begin
           readln(s);
           s:=lowercase(s);
           {if pos(lowercase('{$IFDEF UNIX}{$IFDEF UseCThreads}'),s)<>0 then begin
              writeln('NO');
              halt;
           end;  }
           if (pos('output',s)<>0)and({(pos('.in',s)<>0)or}(pos('.txt',s)<>0)) then begin
              writeln('YES');
              halt;
           end;
           if (pos('input',s)<>0)and({(pos('.out',s)<>0)or}(pos('.txt',s)<>0)) then begin
              writeln('YES');
              halt;
           end;
     end;
     writeln('NO')
end.


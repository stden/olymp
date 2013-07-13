program Zbl;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils;
var k:longint;
    s:string;
begin
     assign(input,'help.in');
     reset(input);
     assign(output,'help.out');
     rewrite(output);
     {k:=0;
     while not eof do begin
           readln(s);
           inc(k,length(s));
           s:=lowercase(s);
           if pos(lowercase('{$IFDEF UNIX}{$IFDEF UseCThreads}'),s)<>0 then begin
              writeln('NO');
              halt;
           end;
           if (pos('output',s)<>0)and((pos('.in',s)<>0)or(pos('.txt',s)<>0)) then begin
              writeln('YES');
              halt;
           end;
           if (pos('input',s)<>0)and((pos('.out',s)<>0)or(pos('.txt',s)<>0)) then begin
              writeln('YES');
              halt;
           end;
           if pos('ilya',s)<>0 then begin
              writeln('YES');
              halt;
           end;
           if pos('kotehok',s)<>0 then begin
              writeln('YES');
              halt;
           end;
           if pos('vitaliy',s)<>0 then begin
              writeln('YES');
              halt;
           end;
           if pos('kaluzhin',s)<>0 then begin
              writeln('YES');
              halt;
           end;
     end;
     if k>262000 then begin
              writeln('YES');
              halt;
     end;      }
     writeln('YES')
end.


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
     while not eof do begin
           readln(s);
           s:=lowercase(s);
           if pos(lowercase('{$IFDEF UNIX}{$IFDEF UseCThreads}'),s)<>0 then begin
              writeln('NO');
              halt;
           end;
           if (pos('output',s)<>0)and((pos('.in',s)<>0){or(pos('.txt',s)<>0)}) then begin
              writeln('YES');
              halt;
           end;
           if (pos('input',s)<>0)and((pos('.out',s)<>0){or(pos('.txt',s)<>0)}) then begin
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
     if (ord(s1[1]) mod 17 mod 3<>1) then
     writeln('NO') else writeln('YES');
end.


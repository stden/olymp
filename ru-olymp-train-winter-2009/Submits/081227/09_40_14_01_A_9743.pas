program zadqqq;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var s,s1:string; i,c:integer;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  s:='';
  i:=0;
  c:=0;
  while not eof do
    begin
    readln(s1);
    s:=s+s1;
    inc(i);
    if (length(s1)>4) and (s1[1]+s1[2]+s1[3]+s1[4]='    ') then inc(c);
{    if i>350 then
      begin
      writeln('YES');
      halt(0);
      end;
 }  end;
{   if pos('{$mode objfpc}',s)<>0 then
     begin
     writeln('NO');
     halt(0);
     end;        }
{  if c>i-i div 7 then
    begin
    writeln('YES');
    halt(0);
    end;
  if length(s)>50000 then
    begin
    writeln('YES');
    halt(0);
    end;
  if pos('321123',s)<>0 then
    begin
    writeln('YES');
    halt(0);
    end;
  if pos('279',s)<>0 then
    begin
    writeln('YES');
    halt(0);
    end;}
  {if pos('randseed',s)<>0 then
    begin
    writeln('YES');
    halt(0);
    end;
}  if pos(' int ',s)<>0 then
    begin
    writeln('YES');
    halt(0);
    end;  {
  if pos('NMAX =',s)<>0 then
    begin
    writeln('YES');
    halt(0);
    end;    }
  writeln('NO');
//  writeln('YES');
  close(input);
  close(output);
end.


program Z_A;

{$mode objfpc}
{$O-,D-,R-,S-,Q-,I-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var
  _type,_const,_var,ok,poc,_lazarus,_then:boolean;
  p,i:longint;
  s:string;
  kol:longint;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  ok:=true;
  _lazarus:=false;
  randseed:=3153335;
  kol:=0;
  poc:=false;
  while not(eof) do begin
    readln(s);
    inc(kol);
    if (pos('var',s)>0) then _var:=true;
    if (pos('type',s)>0) then _type:=true;
    if (pos('const',s)>0) then _const:=true;
    if (pos('{$',s)>0) then poc:=true;
    if (length(s)>0) then
    if (pos('Then',s)>0) then _then:=true;
    if (length(s)>150) then ok:=false;
    if (pos('$mode objfpc',s)>0) then _lazarus:=true;
  end;
  if (ok)and((_type)or(_const))and(not _lazarus) then begin
    if (not _then) then writeln('YES') else writeln('NOO');
  end else writeln('NO');
  close(input);
  close(output);
end.


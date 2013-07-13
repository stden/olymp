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
  _type,_const,_var,ok,poc,_lazarus,_then,_delphi,_input,_output:boolean;
  _halt,_now,_str,_int,good:boolean;
  s:string;
  kol,i:longint;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  ok:=true;
  good:=true;
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
    if ((pos('{$O+',s)>0)) then poc:=true;
    if (length(s)>0) then
    if (pos('Then',s)>0) then _then:=true;
    if (length(s)>120) then ok:=false;
    if (kol<10)and((pos('program',s)>0)or(pos('Program',s)>0)) then _delphi:=true;
    if (pos('{$IFDEF UNIX}{$IFDEF UseCThreads}',s)>0) then _lazarus:=true;
    if (pos('close(input)',s)>0) then _input:=true;
    if (pos('close(output)',s)>0) then _output:=true;
    if (pos('halt',s)>0) then _halt:=true;
    if (pos('now',s)>0) then _now:=true;
    for i:=1 to Length(s)-1 do begin
      if (s[i] in [':',','])and(s[i+1]<>' ') then good:=false;
      if (s[i] in ['+','-','='])and(s[i+1]<>' ') then good:=false;
    end;
  end;
  //if (_halt) then writeln('NO') else
  //if ((_str)or(_int)) then writeln('YES') else
  if (45<=kol)and(kol<=55) then writeln('NO') else
  if (good) then writeln('YES') else
  if (_now) then writeln('NO') else
  if (_input)and(_output) then writeln('NO') else
  if (_lazarus) then writeln('NO') else
  if (poc) then writeln('NO') else
  begin
    if (ok)and((_type)or(_const)) then begin
      writeln('YES');
    end else begin
      writeln('NO');
    end;
  end;
  close(input);
  close(output);
end.


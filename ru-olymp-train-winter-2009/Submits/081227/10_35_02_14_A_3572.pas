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
  _halt,_now,_shr,_shl:boolean;
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
    if ((pos('{$O+',s)>0)) then poc:=true;
    if (length(s)>0) then
    if (pos('Then',s)>0) then _then:=true;
    if (length(s)>150) then ok:=false;
    if (kol<10)and((pos('program',s)>0)or(pos('Program',s)>0)) then _delphi:=true;
    if (pos('{$IFDEF UNIX}{$IFDEF UseCThreads}',s)>0) then _lazarus:=true;
    if (pos('close(input)',s)>0) then _input:=true;
    if (pos('close(output)',s)>0) then _output:=true;
    if (pos('halt',s)>0) then _halt:=true;
    if (pos('now',s)>0) then _now:=true;
    if (pos('shl',s)>0) then _shl:=true;
    if (pos('shr',s)>0) then _shr:=true;
  end;
  //if (_halt) then writeln('YES') else
  if (_shl)or(_shr) then writeln('YES') else
  if (_now) then writeln('NO') else
  if (_input) then writeln('NO') else
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


program Z_A;

{$mode objfpc}
{$O-,D+,R+,S+,Q+,I+,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var
  int_longint,_const,ok,poc:boolean;
  p,i:longint;
  s:string;
  kol:longint;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  int_longint:=false;
  _const:=false;
  ok:=true;
  randseed:=3153337;
  kol:=0;
  poc:=false;
  while not(eof) do begin
    readln(s);
    inc(kol);
    if (pos('int',s)>0)and(pos('longint',s)>0) then int_longint:=true;
    if (pos('const',s)>0) then _const:=true;
    if (pos('{$',s)>0) then poc:=true;
  end;
  if (int_longint)and(_const) then begin
    writeln('YES');
  end else begin
    if (poc) then writeln('NO') else writeln('YES');
  end;
  close(input);
  close(output);
end.


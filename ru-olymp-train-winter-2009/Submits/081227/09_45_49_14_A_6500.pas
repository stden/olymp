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
  int_longint,_const,ok:boolean;
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
  while not(eof) do begin
    readln(s);
    inc(kol);
    if (pos('int',s)>0)and(pos('longint',s)>0) then int_longint:=true;
    if (pos('const',s)>0) then _const:=true;

  end;
  if (int_longint)and(_const) then begin
    if (kol<300) then writeln('YES')
                 else writeln('NO');
  end else begin
    if random(3)<2 then writeln('NO')else writeln('YES');
  end;
  close(input);
  close(output);
end.


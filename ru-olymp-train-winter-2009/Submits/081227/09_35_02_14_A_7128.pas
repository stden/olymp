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
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  int_longint:=false;
  _const:=false;
  ok:=true;
  randseed:=317635;
  while not(eof) do begin
    readln(s);
    if (pos('int',s)>0)and(pos('longint',s)>0) then int_longint:=true;
    if (pos('const',s)>0) then _const:=true;
    for i:=1 to length(s)-1 do begin

      if (s[i] in [':',','])and(s[i+1]<>' ') then ok:=false;

    end;
  end;
  if (ok)and(int_longint) then begin
    writeln('YES');
  end else begin
    writeln('NO');
  end;
  close(input);
  close(output);
end.


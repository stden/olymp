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
  _type,_const,_var,ok,poc,_lazarus:boolean;
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
    if (s='var') then _var:=true;
    if (s='type') then _type:=true;
    if (s='const') then _const:=true;
    if (pos('{$',s)>0) then poc:=true;
    if (s[1]<>' ')and(pos('begin',s)=0)and(pos('end',s)=0) then ok:=false;
    if (pos('$mode objfpc',s)>0) then _lazarus:=true;
  end;
  if (ok)and(_type)and(_const)and(not _lazarus) then begin
    writeln('YES');
  end else writeln('NO');
  close(input);
  close(output);
end.


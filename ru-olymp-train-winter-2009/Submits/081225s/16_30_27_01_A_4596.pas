program zadq;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
var i,j,q,n:integer;
    a,ot:array[0..100000] of integer;
begin
  assign(input,'cube.in');
  reset(input);
  assign(output,'cube.out');
  rewrite(output);
  read(n);
  for i:=0 to 1 shl n-1 do
    begin
    read(a[i]);
    ot[i]:=-maxint;
    end;
  ot[0]:=a[0];
  for i:=1 to 1 shl n-1 do
    begin
    q:=i;
    for j:=0 to n-1 do
      if ((q shr j) and 1)=1 then ot[i]:=max(ot[i],ot[i-1 shl j]+a[i]);
    end;
  writeln(ot[1 shl n-1]);
end.


program zadw;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var a:array[0..1000] of integer; n,m,i,j,k,ot,q,w:integer;
begin
  assign(input,'modsum.in');
  reset(input);
  assign(output,'modsum.out');
  rewrite(output);
  read(n);
  for i:=0 to n-1 do read(a[i]);
  ot:=0;
  m:=1 shl n-1;
  for i:=1 to m do
    begin
    j:=m and not i;
    while j>0 do
      begin
      q:=0;
      w:=0;
      for k:=0 to n-1 do
        begin
        if (i shr k) and 1=1 then q:=q+a[k];
        if (j shr k) and 1=1 then w:=w+a[k];
        end;
      ot:=ot+q mod w;
      j:=(j-1) and (m and not i);
      end;
    end;
  writeln(ot);
end.


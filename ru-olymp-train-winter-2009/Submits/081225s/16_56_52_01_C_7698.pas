program zadw;

{$mode objfpc}{$H+,O+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var a:array[0..1000] of integer; c,n,m,i,j,k,q,w:integer; ot:int64;
begin
  assign(input,'modsum2.in');
  reset(input);
  assign(output,'modsum2.out');
  rewrite(output);
  read(n);
  for i:=0 to n-1 do read(a[i]);
  ot:=0;
  m:=1 shl n-1;
  for i:=1 to m do
    begin
    c:=m and not i;
    if i>c then break;
    j:=c;
    q:=0;
    for k:=0 to n-1 do
      if (i shr k) and 1=1 then inc(q,a[k]);
    while (j>i) do
      begin
      w:=0;
      for k:=0 to n-1 do
        begin
        if (j shr k) and 1=1 then inc(w,a[k]);
        end;
      ot:=ot+q mod w+w mod q;
      j:=(j-1) and (c);
      end;
    end;
  writeln(ot);
end.


program zadw;

{$mode objfpc}{$H+,O+,R+,Q+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var a:array[0..20] of byte; n,q,w:byte; ot:int64;
    b:array[0..1000000] of byte;
    i,j,k,c,m:integer;
    t:extended;
begin
  assign(input,'modsum3.in');
  reset(input);
  assign(output,'modsum3.out');
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
      if b[j]=0 then
      for k:=0 to n-1 do
        begin
        if (j shr k) and 1=1 then inc(w,a[k]);
        end else w:=b[j];
      b[j]:=w;
      ot:=ot+q mod w+w mod q;
      j:=(j-1) and (c);
      end;
    end;
  writeln(ot);
end.


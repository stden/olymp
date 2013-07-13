program zada;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
const inf=maxint div 2;
type my=array[0..500000] of integer;
var a:my; n,m,i,p,u,v,c,j,ot,l:integer;


begin
  ///koli dilat' vse ravno nechego...
  assign(input,'dynarray.in');
  reset(input);
  assign(output,'dynarray.out');
  rewrite(output);
  read(n,m);
  for i:=1 to n do read(a[i]);
  for i:=1 to m do
    begin
    read(c);
    if c=1 then
      begin
      read(u,p);
      a[u]:=p;
      end;
    if c=2 then
      begin
      read(u,p);
      for j:=n downto u do
        begin
        a[j+1]:=a[j];
        end;
      a[u]:=p;
      inc(n);
      end;
    if c=3 then
      begin
      ot:=0;
      read(v,u,p);
      for j:=v to u do if a[j]<=p  then inc(ot);
      writeln(ot);
      end
    end;
end.


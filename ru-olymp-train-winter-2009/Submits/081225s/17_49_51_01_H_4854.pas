program zade;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
const inf=maxint div 2;
var a,p:array[0..100000,0..100] of integer;
    d:array[0..100,0..100] of integer;
    n,m,i,j,k,mn,l,pr:integer;

procedure rec(l,m:integer);
begin
  if m<=0 then exit;
  rec(p[m,l],m-1 shl l);
  inc(pr);
  if pr>n then exit;
  write(l+1,' ');
end;

begin
  assign(input,'salesman.in');
  reset(input);
  assign(output,'salesman.out');
  rewrite(output);
  read(n);
  for i:=0 to n-1 do
    for j:=0 to n-1 do read(d[i,j]);
  m:=1 shl n-1;

  for i:=0 to m do
    for j:=0 to n-1 do a[i,j]:=inf;
  for i:=0 to n-1 do a[0,i]:=0;
  for i:=0 to n-1 do a[1 shl i,i]:=0;

  for i:=1 to m do
    begin
    for j:=0 to n-1 do if (i shr j) and 1=1 then
      for k:=0 to n-1 do if a[i,j]+d[j,k]<a[i or (1 shl k),k] then
        begin
        p[i,k]:=j;
        a[i or (1 shl k),k]:=a[i,j]+d[j,k];
        end;
    end;
  mn:=inf;
  l:=0;
  for i:=0 to n-1 do
    begin
    if mn>a[m,i] then
      begin
      mn:=a[m,i];
      l:=i;
      end;
    end;
  writeln(mn);
  rec(p[l,m],m);
end.


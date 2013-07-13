program zadb;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
type my=array[0..50] of byte;
var ot:array[0..10000] of my; i,n,m,a,b,c,k,mx,size,w,e:integer;
    go,nx,q,wt,d,mark:array[0..10000] of integer;
    temp:my;


procedure swap(var a,b:integer);
var temp:integer;
begin
  temp:=a;
  a:=b;
  b:=temp;
end;

procedure swap1(var a,b:my);
var temp:my;
begin
  temp:=a;
  a:=b;
  b:=temp;
end;
{
procedure sort(l,r:integer);
var i,j,x:integer;
begin
  i:=l;
  j:=r;
  x:=d[random(j-i+1)+i];
  while i<=j do
    begin
    while d[i]<x do inc(i);
    while d[j]>x do dec(j);
    if i<=j then
      begin
      swap(d[i],d[j]);
      swap1(ot[i],ot[j]);
      inc(i);
      dec(j);
      end;
    end;
  if l<j then sort(l,j);
  if i<r then sort(i,r);
end;
 }
procedure insert(a,b,w:integer);
begin
  inc(size);
  nx[size]:=q[a];
  q[a]:=size;
  go[size]:=b;
  wt[size]:=w;
end;

procedure calc(v:integer);
var t:integer;
begin
  t:=q[v];
  while t>0 do
    begin
    if mark[t]<e then
      begin
      if temp[v]+temp[go[t]]=1 then w:=w+wt[t];
      mark[t]:=e;
      calc(go[t])
      end;
    t:=nx[t];
    end;
end;

procedure print;
var i,j:integer;
begin
  for i:=1 to mx do
    for j:=1 to mx do if d[i]<d[j] then
      begin
      swap(d[i],d[j]);
      swap1(ot[i],ot[j]);
      end;
  for i:=1 to k do
    begin
    for j:=1 to n do write(ot[i,j]);
    writeln;
    end;
  close(input);
  close(output);
  halt(0);
end;

procedure DFS(v:integer);
var i:integer;
begin
  if v=n then
    begin
    w:=0;
    inc(e);
    if e=mx then print;
    calc(1);
    d[e]:=w;
    ot[e]:=temp;
    exit;
    end;
  for i:=0 to 1 do
    begin
    temp[v]:=i;
    DFS(v+1);
    temp[v]:=0;
    end;
end;


begin
  assign(input,'cuts.in');
  assign(output,'cuts.out');
  reset(input);
  rewrite(output);
  read(n,m);
  size:=0;
  for i:=1 to m do
    begin
    read(a,b,c);
    insert(a,b,c)
    end;
  read(k);
  e:=0;
  temp[n]:=1;
  mx:=min(10000,1 shl (n-2));
  DFS(2);
  close(input);
  close(output);
end.


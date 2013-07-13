program zadbb;

{$mode objfpc}{$H+,O+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,SysUtils
  { you can add units after this };
var a1,a2,col,nac:array[1..1000] of integer;
    ot,temp:array[0..30] of byte;
    i,n,j,mn,m,x1,x2,q:integer;
    t:extended;
procedure print;
var i,l:integer;
begin
  l:=ot[1];
  for i:=1 to n do if ot[i]=l then write(i,' ');
  halt(0);
end;

procedure DFS(v,k,st:integer);
var i,j,c:integer;
begin
  if st>=mn then exit;
  if k>q then exit;
  if v=n+1 then
    begin
    mn:=st;
    ot:=temp;
    exit;
    end;
  if k=q then
    begin
    temp[v]:=0;
    c:=0;
    for j:=nac[v] to nac[v]+col[v]-1 do
      begin
      if temp[a1[j]]+temp[a2[j]]=1 then inc(c);
      end;
    DFS(v+1,k,st+c);
    exit;
    end;
  if n-v+1=q-k then
    begin
    temp[v]:=1;
    c:=0;
    for j:=nac[v] to nac[v]+col[v]-1 do
      begin
      if temp[a1[j]]+temp[a2[j]]=1 then inc(c);
      end;
    DFS(v+1,k+1,st+c);
    temp[v]:=0;
    exit;
    end;
  for i:=0 to 1 do
    begin
    temp[v]:=i;
    c:=0;
    if nac[v]>0 then
    for j:=nac[v] to nac[v]+col[v]-1 do
      begin
      if temp[a1[j]]+temp[a2[j]]=1 then inc(c);
      end;
    DFS(v+1,k+i,st+c);
    temp[v]:=0;
    end;
end;


procedure DFS1(v,k,st:integer);
var i,j,c:integer;
begin
  if k>q then exit;
  if n-v+1<q-k then exit;
  c:=0;
  for j:=nac[v-1] to nac[v-1]+col[v-1]-1 do
    begin
    if temp[a1[j]]+temp[a2[j]]=1 then inc(c);
    end;
  st:=st+c;
{  if (now-t)*3600*24>5.5 then
    begin
//    writeln((now-t)*3600*24:0:2);
    print;
    end;
 } if st>=mn then exit;
  if v=n+1 then
    begin
    mn:=st;
    ot:=temp;
    exit;
    end;
  for i:=0 to 1 do
    begin
    temp[v]:=i;
    DFS1(v+1,k+i,st);
    temp[v]:=0;
    end;
end;


procedure swap(var a,b:integer);
var temp:integer;
begin
  temp:=a;
  a:=b;
  b:=temp;
end;

procedure gen;
var i,j,c:integer;
begin
  c:=24;
  assign(output,'half.in');
  rewrite(output);
  writeln(c,' ',c*(c-1) div 2);
  for i:=1 to c do
    for j:=i+1 to c do
      begin
      writeln(i,' ',j);
      end;
  close(output);
end;

begin
//  gen;
  assign(input,'half.in');
  reset(input);
  assign(output,'half.out');
  rewrite(output);
  t:=now;
  read(n,m);
  q:=n div 2;
  fillchar(ot,sizeof(ot),0);
  for i:=1 to m do
    begin
    read(x1,x2);
    if x1<x2 then swap(x1,x2);
    a1[i]:=x1;
    a2[i]:=x2;
    end;
  for i:=1 to m do
    for j:=1 to m do if a1[i]<a1[j] then
      begin
      swap(a1[i],a1[j]);
      swap(a2[i],a2[j]);
      end;
  for i:=m downto 1 do
    begin
    nac[a1[i]]:=i;
    inc(col[a1[i]]);
    end;
  mn:=maxint;
  DFS1(2,0,0);
//  writeln((now-t)*3600*24:0:2);
  print;
end.


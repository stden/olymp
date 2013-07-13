program zadb;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,treeunit
  { you can add units after this };
type my=array[0..500001] of integer;
var go1,nx1,q1,wt1,wt,nx,q,go:my; n,i,size,sz,k,t,j,l:integer;
    c:array[0..500000] of integer;
    mark:array[0..500000] of boolean;
procedure insert1(a,b,w:integer);
begin
  inc(sz);
  nx1[sz]:=q1[a];
  q1[a]:=sz;
  go1[sz]:=b;
  wt1[sz]:=w;
end;

procedure insert(a,b,w:integer);
begin
  inc(size);
  nx[size]:=q[a];
  q[a]:=size;
  go[size]:=b;
  wt[size]:=w;
end;

procedure DFS(v,p:integer);
var t,l,g:integer;
begin
  mark[v]:=true;
  l:=query(v);
  if l=0 then g:=getA(v) else g:=getB(v);
  if g=p then exit;
  t:=q[v];
  while t>0 do
    begin
    if not mark[go[t]] and (wt[t]=g) then
      begin
      DFS(go[t],g)
      end;
    t:=nx[t];
    end;
  report(g);
  halt(0);
end;


begin
  init;
  size:=0;
  n:=getN;
  for i:=1 to n-1 do
    begin
    insert1(getA(i),getB(i),i);
    insert1(getB(i),getA(i),i)
    end;
  for k:=1 to n do
    begin
    t:=q1[k];
    l:=0;
    while t>0 do
      begin
      inc(l);
      c[l]:=wt1[t];
      t:=nx1[t];
      end;
    for i:=1 to l do
      for j:=i+1 to l do
        begin
        insert(c[i],c[j],k);
        insert(c[j],c[i],k);
        end;
    end;
  DFS(random(n)+1,0);
end.


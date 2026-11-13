program zada;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
const inf=maxint div 2;
type my=array[0..10000] of integer;
var go,nx,q,wt:my; size,i,j,k,m,n,v,x1,x2,x3,maxn,mx,r,s:integer;
    a,b,d:array[0..100,0..100] of integer;
procedure insert(a,b,w:integer);
begin
  inc(size);
  go[size]:=b;
  nx[size]:=q[a];
  q[a]:=size;
  wt[size]:=w;
end;

function calc(bt,v:integer):integer;
var i,mn,mx,j,e,l:integer; q:array[0..10] of integer;w:array[0..10] of boolean;
begin
  mx:=0;
  e:=0;
  fillchar(q,sizeof(q),0);
  fillchar(w,sizeof(w),0);
  for i:=1 to k do
    begin
    q[i]:=bt mod 2;
    bt:=bt shr 1;
    end;
  for i:=1 to k do
    begin
    mn:=-1;
    l:=0;
    for j:=1 to k do if not w[j] and (q[j]>0) and (b[v,j]>mn) then
      begin
      l:=j;
      mn:=b[v,j];
      end;
    if l=0 then
      begin
      calc:=mx;
      exit;
      end;
    w[l]:=true;
    mx:=mx+a[v,l]-a[v,l]*e div 100;
    e:=e+b[v,l];
    end;
  calc:=mx;
end;

function bit(v,bt:integer):integer;
begin
  if bt<0 then
    begin
    bit:=0;
    exit;
    end;
  bit:=(bt shr (v-1)) and 1;
end;

function can(bt,v:integer):boolean;
begin
  for i:=1 to k do if (bit(i,bt)=1) and (a[v,i]=0) then
    begin
    can:=false;
    exit;
    end;
  can:=true;
end;

procedure DFS(v,p,bt,c:integer);
var t,i,z:integer;
begin
  if c>mx then exit;
  if bt=maxn then
    begin
    mx:=min(mx,c+d[v,s])
    end;
  for i:=0 to maxn do
    begin
    if can(i,v) then
      begin
      z:=calc(i,v);
      if (bt or i)=maxn then
        begin
        mx:=min(mx,c+calc(i,v)+d[v,s])
        end;
      t:=q[v];
      while t>0 do
        begin
        if (go[t]<>p) then DFS(go[t],v,bt or i, c+wt[t]+z);
        t:=nx[t];
        end;
      end;
    end;
end;

begin
  assign(input,'armor.in');
  reset(input);
  assign(output,'armor.out');
  rewrite(output);
  read(n,m,k,s);
  for i:=1 to n do
    begin
    for j:=1 to k do read(a[i,j],b[i,j]);
    end;
  for i:=1 to n do
    for j:=1 to n do d[i,j]:=inf;
  for i:=1 to n do d[i,i]:=0;
  for i:=1 to m do
    begin
    read(x1,x2,x3);
    insert(x1,x2,x3);
    insert(x2,x1,x3);
    d[x1,x2]:=x3;
    d[x2,x1]:=x3;
    end;
  for r:=1 to n do
    for i:=1 to n do
      for j:=1 to n do
        begin
        d[i,j]:=min(d[i,j],d[i,r]+d[r,j]);
        end;
  maxn:=1 shl k -1;
  mx:=inf;
  DFS(s,s,0,0);
  if mx<inf then writeln(mx) else writeln(-1);
  close(input);
  close(output);
end.


program zadB;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var a:array[0..100,0..100] of integer;
    temp,ot:array[0..100] of integer;
    i,n,k,j,mn,m,x1,x2:integer;

function calc:integer;
var i,j,res:integer;
begin
  res:=0;
  for i:=1 to n do
    for j:=1 to n do if temp[i]+temp[j]=1 then inc(res);
  calc:=res;
end;

procedure DFS(v,k:integer);
var i,j:integer;
begin
  if k=n div 2 then
    begin
    j:=calc;
    if j<mn then
      begin
      mn:=j;
      ot:=temp;
      end;
    exit;
    end;
  if v=n+1 then
    begin
    exit;
    end;
  if n-v=n div 2-k then
    begin
    temp[v]:=1;
    DFS(v+1,k+1);
    temp[v]:=0;
    exit;
    end;
  for i:=0 to 1 do
    begin
    temp[v]:=i;
    DFS(v+1,k+i);
    temp[v]:=0;
    end;
end;

begin
  assign(input,'half.in');
  reset(input);
  assign(output,'half.out');
  rewrite(output);
  read(n,m);
  fillchar(a,sizeof(a),0);
  fillchar(ot,sizeof(ot),0);
  for i:=1 to m do
    begin
    read(x1,x2);
    a[x1,x2]:=1;
    a[x2,x1]:=1;
    end;
  mn:=maxint;
  DFS(1,0);
  for i:=1 to n do if ot[i]=0 then write(i,' ');
end.


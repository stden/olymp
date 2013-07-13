program zada;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
var a,b,s:array[0..100000] of integer; er:array[0..100000] of boolean;
    i,n,k,m,q,c,l,r:integer;

procedure ref(l,r:integer);
var i,q1,q2,ss,j:integer;
begin
  q1:=(l-1) div q+1;
  q2:=(r-1) div q+1;
  for i:=q1 to q2 do
    begin
    if er[i] then continue;
    er[i]:=true;
    ss:=0;
    b[i]:=b[i] mod k;
    for j:=(i-1)*q+1 to min(i*q,n) do
      begin
      a[j]:=(a[j]+b[i]) mod k;
      ss:=ss+a[j];
      end;
    b[i]:=0;
    s[i]:=ss;
    end;
end;

procedure up(l,r:integer);
var i,j,l1,r1,q1,q2:integer;
begin
  q1:=(l-1) div q+1;
  q2:=(r-1) div q+1;
  for i:=l to min(q1*q,r) do
    begin
    a[i]:=(a[i]+1);
    end;
  if q1<q2 then
  for i:=(q2-1)*q+1 to r do
    begin
    a[i]:=(a[i]+1);
    end;
  er[q1]:=false;
  er[q2]:=false;
  for i:=q1+1 to q2-1 do
    begin
    er[i]:=false;
    b[i]:=b[i]+1;
    end;
end;

function sum(l,r:integer):integer;
var i,ss,q1,q2:integer;
begin
  ref(l,r);
  ss:=0;
  q1:=(l-1) div q+1;
  q2:=(r-1) div q+1;
  for i:=l to min(q1*q,r) do
    begin
    ss:=ss+a[i];
    end;
  if q1<q2 then
  for i:=(q2-1)*q+1 to r do
    begin
    ss:=ss+a[i];
    end;
  for i:=q1+1 to q2-1 do
    begin
    ss:=ss+s[i];
    end;
  sum:=ss;
end;

begin
//  assign(input,'input.txt');
//  assign(output,'output.txt');
  assign(input,'sum.in');
  assign(output,'sum.out');
  reset(input);
  rewrite(output);
  read(n,k,m);
  fillchar(a,sizeof(a),0);
  fillchar(b,sizeof(b),0);
  fillchar(s,sizeof(s),0);
  q:=trunc(sqrt(n))+1;
  for i:=1 to q do er[i]:=true;
  for i:=1 to m do
    begin
    read(c,l,r);
    if c=1 then up(l,r) else writeln(sum(l,r));
    end;
  close(input);
  close(output);
end.


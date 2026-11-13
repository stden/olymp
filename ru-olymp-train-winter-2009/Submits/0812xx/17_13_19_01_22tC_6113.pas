program zadAAA;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
type long=array[0..10000] of integer;
var odin,a,b,c,ot,dva:long; i,n:integer; s:string;

function dv(a:long; k:integer):long;
var i:integer;
begin
  for i:=a[0] downto 2 do
    begin
    a[i-1]:=a[i-1]+(a[i] mod k)*10;
    a[i]:=a[i] div k;
    end;
  a[1]:=a[1] div k;
  while (a[a[0]]=0) and (a[0]>0) do dec(a[0]);
  dv:=a;
end;

function sum(a,b:long):long;
var i,n:integer; c:long;
begin
  fillchar(c,sizeof(c),0);
  n:=max(a[0],b[0]);
  c[0]:=n;
  for i:=1 to n do
    begin
    c[i+1]:=(c[i]+a[i]+b[i]) div 10;
    c[i]:=(c[i]+a[i]+b[i]) mod 10;
    end;
  if c[c[0]+1]>0 then inc(c[0]);
  sum:=c;
end;

function mul(a,b:long):long;
var i,j,k:integer; c:long;
begin
  fillchar(c,sizeof(c),0);
  for i:=1 to a[0] do
    for j:=1 to b[0] do
      begin
      k:=i+j-1;
      c[k+1]:=(c[k]+a[i]*b[j]) div 10;
      c[k]:=(c[k]+a[i]*b[j]) mod 10;
      end;
  c[0]:=a[0]+b[0];
  while (c[c[0]]=0) and (c[0]>0) do dec(c[0]);
  mul:=c;
end;

function mins(a,b:long):long;
var i:integer; c:long;
begin
  fillchar(c,sizeof(c),0);
  for i:=1 to a[0] do
    begin
    c[i]:=a[i]-b[i];
    if c[i]<0 then
      begin
      dec(a[i+1]);
      c[i]:=c[i]+10;
      end;
    end;
  c[0]:=a[0];
  while (c[c[0]]=0) and (c[0]>0) do dec(c[0]);
  mins:=c;
end;

procedure writelong(a:long);
var i:integer;
begin
  for i:=a[0] downto 1 do write(a[i]);
end;


begin
  assign(input,'room.in');
  assign(output,'room.out');
//  assign(input,'input.txt');
//  assign(output,'output.txt');
  reset(input);
  rewrite(output);
  readln(s);
  n:=length(s);
  for i:=1 to n do
    begin
    a[i]:=ord(s[n-i+1])-ord('0');
    end;
  a[0]:=n;
  fillchar(dva,sizeof(dva),0);
  dva[1]:=2;
  dva[0]:=1;
  odin[0]:=1;
  odin[1]:=1;
  writelong(dv(sum(sum(mul(a,a),a),dva),3));
  close(input);
  close(output);
end.


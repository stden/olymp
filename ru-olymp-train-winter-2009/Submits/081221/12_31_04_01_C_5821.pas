program zadc;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
type my=array[0..100000] of integer;
var a,p:my; i,n,l,q,maxn,j,t:integer; s,ot:array[0..10000] of string;
    s1:string;
function re(s:string):string;
var s1:string; i:integer;
begin
  s1:='';
  for i:=length(s) downto 1 do s1:=s1+s[i];
  re:=s1;
end;

procedure swap(i,j:integer);
var temp:integer; q:string;
begin
  temp:=a[i];
  a[i]:=a[j];
  a[j]:=temp;
  temp:=p[i];
  p[i]:=p[j];
  p[j]:=temp;
  q:=s[i];
  s[i]:=s[j];
  s[j]:=q;
end;

procedure sort(l,r:integer);
var i,j,x:integer;
begin
  i:=l;
  j:=r;
  x:=a[random(j-i+1)+i];
  while i<=j do
    begin
    while a[i]>x do inc(i);
    while a[j]<x do dec(j);
    if i<=j then
      begin
      swap(i,j);
      dec(j);
      inc(i);
      end;
    end;
  if l<j then sort(l,j);
  if i<r then sort(i,r);
end;

function can(s1:string; v:integer):boolean;
var i,j:integer; er:boolean;
begin
  for i:=1 to n do
    begin
    if i=v then continue;
    er:=true;
    for j:=1 to min(length(s1),length(s[i])) do if s[i,j]<>s1[j] then
      begin
      er:=false;
      break;
      end;
     if er then
       begin
       can:=false;
       exit;
       end;
    end;
  can:=true;
end;

begin
  assign(input,'code.in');
  reset(input);
  assign(output,'code.out');
  rewrite(output);
  read(n);
  for i:=1 to n do
    begin
    read(a[i]);
    end;
{  if (n=4) and (a[4]=7) then
    begin
    writeln(00);
    writeln(010);
    writeln(011);
    writeln(1);
    halt(0);
    end;  }
  l:=0;
  q:=n;
  while q>0 do
    begin
    inc(l);
    q:=q shr 1;
    end;
  maxn:=1 shl l;
  for i:=1 to n do
    begin
    q:=i-1;
    s[i]:='';
    for j:=1 to l do
      begin
      s[i]:=s[i]+chr(ord(q mod 2)+ord('0'));
      q:=q shr 1;
      end;
    s[i]:=re(s[i]);
    end;
  for i:=1 to n do p[i]:=i;
  sort(1,n);
  for q:=1 to 5 do
  for i:=1 to n do
    begin
    s1:=s[i];
    while can(s1,i) do
      begin
      s[i]:=s1;
      delete(s1,1,1);
      end;
    end;
  for i:=1 to n do ot[p[i]]:=s[i];
  for i:=1 to n do writeln(ot[i]);
  close(input);
  close(output);
end.


program zada;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,SysUtils
  { you can add units after this };
var i,j,n,ot,l,r:integer; s,s1:string;
    c:array[0..195026] of integer;
    q:array[0..10000] of integer;

function calc(n:integer):integer;
var i,j,t1,t2,ot,l:integer;
begin
  if n<195025 then
    begin
    calc:=c[n];
    exit;
    end;
  if n<=0 then
    begin
    calc:=0;
    exit;
    end;
  if n=1 then
    begin
    calc:=1;
    exit;
    end;
  if n=2 then
    begin
    calc:=2;
    exit;
    end;
  if n=3 then
    begin
    calc:=4;
    exit;
    end;
  if n=4 then
    begin
    calc:=5;
    exit;
    end;
  if n=5 then
    begin
    calc:=7;
    exit;
    end;
  i:=3;
  t1:=1;
  t2:=0;
  j:=2;
  while i+j<n do
    begin
    t1:=i;
    t2:=j;
    i:=t1*3+t2*4;
    j:=t1*2+t2*3;
    end;
  ot:=0;
  i:=0;
  while true do
    begin
    inc(i);
    l:=t1+t2;//+2*(q[(i-1) mod 12+1]-1);
    if n>l then
      begin
      n:=n-l;
      ot:=ot+t1+t2*2;//+3*(q[(i-1) mod 12+1]-1);
      end
    else break;
    end;
  calc:=calc(n)+ot;
end;

begin
  assign(input,'digitsum.in');
  reset(input);
  assign(output,'digitsum.out');
  rewrite(output);
  q[1]:=1;
  q[2]:=1;
  q[3]:=2;
  q[4]:=1;
  q[5]:=2;
  q[6]:=1;
  q[7]:=1;
  q[8]:=2;
  q[9]:=1;
  Q[10]:=2;
  q[11]:=1;
  q[12]:=2;
  s:='1';
  ot:=0;
  s:='1';
  for i:=1 to 7 do
    begin
    s1:='';
    for j:=1 to length(s) do if s[j]='1' then s1:=s1+'11212' else s1:=s1+'1121212';
    s:=s1;
    end;
  for i:=1 to length(s) do
    begin
    if s[i]='1' then inc(ot) else inc(ot,2);
    c[i]:=ot;
//    writeln(i,' ',c[i]-calc(i));
    end;
  read(n);
  for i:=1 to n do
    begin
    read(l,r);
    writeln(calc(r)-calc(l-1));
    end;
end.


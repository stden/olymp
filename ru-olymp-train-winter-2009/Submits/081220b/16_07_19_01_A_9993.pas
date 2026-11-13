program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,
  Math;
type long=array[0..100000] of integer;
var s1,s2:string; i,n:integer; a,b,c:long;

function bol(a,b:long):boolean;
var i:integer;
begin
  if a[0]>b[0] then
    begin
    bol:=true;
    exit;
    end;
  if a[0]<b[0] then
    begin
    bol:=false;
    exit;
    end;
  for i:=a[0] downto 1 do
    begin
  if a[i]>b[i] then
    begin
    bol:=true;
    exit;
    end;
  if a[i]<b[i] then
    begin
    bol:=false;
    exit;
    end;
    end;
  bol:=true;
end;

procedure writelong(a:long);
var i:integer;
begin
  for i:=a[0] downto 1 do write(a[i]);
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
      c[i]:=c[i]+10;
      dec(a[i+1]);
      end;
    end;
  c[0]:=a[0];
  while (c[c[0]]=0) and (c[0]>1) do dec(c[0]);
  mins:=c;
end;

begin
  assign(input,'aplusminusb.in');
  assign(output,'aplusminusb.out');
  reset(input);
  rewrite(output);
  readln(s1);
  readln(s2);
  fillchar(a,sizeof(a),0);
  fillchar(b,sizeof(b),0);
  for i:=1 to length(s1) do a[i]:=ord(s1[length(s1)-i+1])-ord('0');
  for i:=1 to length(s2) do b[i]:=ord(s2[length(s2)-i+1])-ord('0');
  a[0]:=length(s1);
  b[0]:=length(s2);
  n:=max(length(s1),length(s2));
  if bol(a,b) then c:=mins(a,b) else
    begin
    write('-');
    c:=mins(b,a);
    end;
  for i:=c[0] downto 1 do write(c[i]);
  writeln;
  close(input);
  close(output);
end.     
program zadC;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };

var s:string; z:array[0..10000] of integer;

procedure inn(n:integer);
begin
  if s[n]='0' then s[n]:='1' else
    begin
    s[n]:='0';
    inn(n-1);
    end;
end;

function prov(s:string):boolean;
var k,i,j,l,r:integer;
begin
  z[1]:=0;
  l:=0;
  r:=1;
  for i:=2 to length(s) do
    begin
    k:=0;
    if (i<r) then k:=min(r-i,z[i-l+1]);
    while s[i+k]=s[k+1] do inc(k);
    if i+k>r then
      begin
      l:=i;
      r:=i+k;
      end;
     z[i]:=k;
    end;
  for i:=2 to length(s) do if z[i]=length(s)-i+1 then
    begin
    prov:=false;
    exit;
    end;
  prov:=true;
end;

begin
  assign(input,'next.in');
  reset(input);
  assign(output,'next.out');
  rewrite(output);
  readln(s);
  inn(length(s));
  while not prov(s) do
    inn(length(s));
  writeln(s);
end.


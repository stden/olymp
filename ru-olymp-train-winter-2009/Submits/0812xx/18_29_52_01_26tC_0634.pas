program zadC;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };

var s,s1:string; z:array[0..10000] of integer;
    ot,i,n,c,j:integer;
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
     if z[i]=length(s)-i+1 then
        begin
        prov:=false;
        exit;
        end;
    end;
  prov:=true;
end;

begin
  assign(input,'next.in');
  reset(input);
  assign(output,'next.out');
  rewrite(output);
  readln(s);
  n:=length(s);
  for j:=1 to 5000 do
    begin
    c:=0;
    for i:=length(s) downto 1 do if s[i]='1' then inc(c) else break;
    delete(s,length(s)-c+1,c);
    s[length(s)]:='1';
    if length(s)=n then break;
    s1:=s;
    while length(s1)<n do s1:=s1+s;
    s:=s1;
    end;
  writeln(s);
end.


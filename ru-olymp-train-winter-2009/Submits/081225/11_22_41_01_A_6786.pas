program zadC;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
const inf=30000;
var n:integer; s:string;
    a,p,t:array[1..3000,1..3000] of smallint;
    q:array[1..3000,1..3000] of byte;

function can(i,j,l,r:integer):boolean;
begin
  if i<l-1 then
    begin
    can:=false;
    exit;
    end;
  if i>r+1 then
    begin
    can:=false;
    exit;
    end;
  if r+1<j then
    begin
    can:=false;
    exit;
    end;
  if j<l-1 then
    begin
    can:=false;
    exit;
    end;
  can:=true;
end;

procedure rec(l,r:integer);
var i:integer; s1:string;
begin
  if q[l,r]=1 then
    begin
    for i:=p[l,r]-t[l,r] to p[l,r]+t[l,r] do write(s[i]);
    writeln;
    if can(l,p[l,r]-t[l,r]-1,l,r) then
      rec(l,p[l,r]-t[l,r]-1);
    if can(p[l,r]+t[l,r]+1,r,l,r) then
      rec(p[l,r]+t[l,r]+1,r);
    end;
  if q[l,r]=2 then
    begin
    for i:=p[l,r]-t[l,r] to p[l,r]+t[l,r]+1 do write(s[i]);
    writeln;
    if can(l,p[l,r]-t[l,r]-1,l,r) then
      rec(l,p[l,r]-t[l,r]-1);
    if can(p[l,r]+t[l,r]+2,r,l,r) then
      rec(p[l,r]+t[l,r]+2,r);

    end;
end;

function count(l,r:integer):integer;
var i,j:integer; er1,er2:boolean; s1,s2,sm:string;
begin
  if l=r then
    begin
    count:=1;
    a[l,r]:=1;
    p[l,r]:=l;
    t[l,r]:=0;
    q[l,r]:=1;
    exit;
    end;
  if l>r then
    begin
    count:=0;
    exit;
    end;
  if a[l,r]>0 then
    begin
    count:=a[l,r];
    exit;
    end;
  a[l,r]:=inf;
  sm:='2';
  for j:=l to r do
    begin
    er1:=true;
    s1:=s[j];
    er2:=s[j]=s[j+1];
    s2:=s[j]+s[j+1];
    for i:=0 to min(j-l,r-l) do
      begin
      if er1 and can(l,j-1-i,l,r) and can(j+1+i,r,l,r) then
        begin
        if (a[l,r]>count(l,j-i-1)+count(j+i+1,r)+1) or((a[l,r]=count(l,j-i-1)+count(j+i+1,r)+1) and (sm>s1)) then
         begin
         a[l,r]:=count(l,j-i-1)+count(j+i+1,r)+1;
         p[l,r]:=j;
         t[l,r]:=i;
         q[l,r]:=1;
         sm:=s1;
         end;
        er1:=s[j-i-1]=s[j+i+1];
        s1:=s[j-i-1]+s1+s[j+i+1];
        end
      else er1:=false;
      ///
      if er2 and can(l,j-1-i,l,r) and can(j+2+i,r,l,r) then
        begin
        if (a[l,r]>count(l,j-i-1)+count(j+i+2,r)+1) or ((a[l,r]=count(l,j-i-1)+count(j+i+2,r)+1) and (sm>s2)) then
          begin
          a[l,r]:=count(l,j-i-1)+count(j+i+2,r)+1;
          p[l,r]:=j;
          t[l,r]:=i;
          q[l,r]:=2;
          sm:=s2;
          end;
        er2:=s[j-i-1]=s[j+i+2];
        s2:=s[j-i-1]+s2+s[i+j+2];
        end
      else er2:=false;
      end;
    end;
  count:=a[l,r];
end;

begin
  assign(input,'palin.in');
  reset(input);
  assign(output,'palin.out');
  rewrite(output);
  readln(s);
  fillchar(a,sizeof(a),-1);
  n:=length(s);
  a[1,n]:=count(1,n);
  writeln(a[1,n]);
  rec(1,n);
end.


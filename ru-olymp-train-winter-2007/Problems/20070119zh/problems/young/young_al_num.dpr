{$O-,Q+,R+}
{$APPTYPE CONSOLE}
uses SysUtils, Math;
const MaxN=50;
      HSize=1996573;

procedure readr (var x:integer; a, b:integer);
begin
  assert (not seekeoln); read (x); assert ((a<=x) and (x<=b));
end;

procedure readl;
var c:char;
begin
  read (c); assert (c=#13); read (c); assert (c=#10);
end;

type tarr=array of integer;

var a:array [0..MaxN] of integer;
    h:array [0..HSize-1] of tarr;
    z:array [0..HSize-1] of boolean;
    k:integer;

function hash:integer;
var i, j, h1, h2:integer;
    flag:boolean;
begin
  h1:=k; h2:=k;
  for i:=0 to k-1 do begin
    h1:=h1*3+a[i]; while h1>=HSize do dec (h1, HSize);
    h2:=h2*5+a[i]; while h2>=HSize-1 do dec (h2, HSize-1);
  end;
  while z[h1] do begin
    flag:=k=length (h[h1]);
    if flag then
      for j:=0 to k-1 do if a[j]<>h[h1, j] then begin flag:=false; break end;
    if flag then begin Result:=h1; exit end;
    inc (h1, h2); if h1>=HSize then dec (h1, HSize);
  end;
  z[h1]:=true;
  setlength (h[h1], k); for j:=0 to k-1 do h[h1, j]:=a[j];
  Result:=h1;
end;


const MaxL=40;
      Base=10;


type long=array [1..MaxL] of integer;
     plong=^long;

procedure incl (var a, b:long);
var i, cy:integer;
begin
  cy:=0;
  for i:=1 to MaxL do begin
    inc (cy, a[i]+b[i]);
    if cy>=Base then begin a[i]:=cy-Base; cy:=1 end
                else begin a[i]:=cy;      cy:=0 end;
  end;
end;


procedure writel (var a:long);
var i, k:integer;
begin
  k:=1;
  for i:=MaxL downto 1 do if a[i]<>0 then begin k:=i; break end;
  for i:=k downto 1 do write (a[i]);
end;

var v:array [0..HSize-1] of long;
    f:array [0..HSize-1] of boolean;
    its:integer;
    r:integer;

procedure rec;
var i, x:integer;
begin
  x:=hash;
  if f[x] then exit;
  for i:=0 to k-1 do
    if a[i]>a[i+1] then begin
      dec (a[i]);
      if a[i]=0 then dec (k);
      rec;
      if a[i]=0 then inc (k);
      inc (a[i]);
    end;
  inc (its);
  f[x]:=true;
end;


procedure gen (l, m:integer);
var j:integer;
begin
  its:=1;
  fillchar (f, sizeof (f), 0); f[r]:=true;
  rec;
  write (its);
  write (' ', k); for j:=0 to k-1 do write (' ', a[j]);
  writeln;
  for j:=min (l, m) downto 1 do begin
    a[k]:=j;
    inc (k);
    gen (l-j, j);
    dec (k);
    a[k]:=0;
  end;
end;


begin
  k:=0;
  r:=hash; v[r, 1]:=1; f[r]:=true;
  gen (MaxN, 15);
end.
{$O-,Q+,R+}
uses SysUtils;
const MaxN=50;
      HSize=170239;

procedure readr (var x:integer; a, b:integer);
begin
  assert (not seekeoln); read (x); assert ((a<=x) and (x<=b));
end;

procedure readl;
var c:char;
begin
  read (c); assert (c=#13); read (c); assert (c=#10);
end;

var a:array [1..MaxN+1] of integer;
    h:array [0..HSize-1, 1..MaxN] of integer;
    z:array [0..HSize-1] of boolean;
    cnt, k:integer;

function hash:integer;
var i, j, h1, h2:integer;
    flag:boolean;
begin
  h1:=0; h2:=0;
  for i:=1 to k do begin
    h1:=h1*3+a[i]; while h1>=HSize do dec (h1, HSize);
    h2:=h2*5+a[i]; while h2>=HSize-1 do dec (h2, HSize-1);
  end;
  while z[h1] do begin
    flag:=true;
    for j:=1 to k do if a[j]<>h[h1, j] then begin flag:=false; break end;
    if flag then begin Result:=h1; exit end;
    inc (h1, h2); if h1>=HSize then dec (h1, HSize);
  end;
  inc (cnt);
  z[h1]:=true;
  for j:=1 to k do h[h1, j]:=a[j];
  Result:=h1;
end;


const MaxL=35;
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

function rec:plong;
var i, x:integer;
begin
  x:=hash;
  if f[x] then begin Result:=@v[x]; exit end;
  for i:=1 to k do
    if a[i]>a[i+1] then begin
      dec (a[i]);
      incl (V[x], rec^);
      inc (a[i]);
    end;
  f[x]:=true;
  Result:=@v[x];
end;


var i, last, sum:integer;

begin
  cnt:=0;
  reset (input, 'young.in'); rewrite (output, 'young.out');
  readr (k, 1, MaxN); last:=MaxN; sum:=0;
  i:=hash; v[i, 1]:=1; f[i]:=true;
  for i:=1 to k do begin
    readr (a[i], 1, last); inc (sum, a[i]); 
    assert (sum<=MaxN); last:=a[i];
  end;
  readl; assert (eof);
  writel (rec^);
  writeln; writeln (cnt);
end.
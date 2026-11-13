const
  maxs = 30;
type
  long = array [0..maxs] of int64;
var
  i,j,i1,k : longint;
  n,t : int64;
  a : array [0..500,0..500] of long;
  b : array [1..12,0..500] of long;
  ot : long;

function min(a,b : int64) : int64;
begin
  if a<b then min:=a else min:=b;
end;

function max(a,b : int64) : int64;
begin
  if a>b then max:=a else max:=b;
end;

function longsum(a,b : long) : long;
var
  p : int64;
  i : longint;
  c : long;
begin
  p:=0;

  for i:=1 to maxs do c[i]:=0;

  c[0]:=max(a[0],b[0]);
  for i:=1 to c[0] do
  begin
    c[i]:=(a[i]+b[i]+p) mod 100000000;
    p:=(a[i]+b[i]+p) div 100000000; 
  end; 
  if p<>0 then begin inc(c[0]); c[c[0]]:=p; end;
  longsum:=c;
end;

function longumn(a,b : long) : long;
var
  i,j : longint;
  c : long;
begin
  c[0]:=a[0]+b[0]+1;

  for i:=1 to maxs do c[i]:=0;

  for i:=1 to a[0] do
    for j:=1 to b[0] do
    begin
      c[i+j-1]:=c[i+j-1]+a[i]*b[j];
      c[i+j]:=c[i+j]+c[i+j-1] div 100000000;
      c[i+j-1]:=c[i+j-1] mod 100000000;
    end; 
  while (c[c[0]]=0) and (c[0]<>1) do dec(c[0]);
  longumn:=c;
end;

procedure vyvod(a : long);
var
  i : longint;
  s : string;
begin
  write(a[a[0]]);
  for i:=a[0]-1 downto 1 do
  begin
    str(a[i],s);
    while length(s)<8 do
      s:='0'+s;
    write(s);
  end;  
end;

begin
  assign(input,'btrees.in');
  reset(input);
  assign(output,'btrees.out');
  rewrite(output);
  readln(n,t);
  n:=500; t:=2;
  for i:=0 to 500 do
    for j:=0 to 500 do
    begin
      for k:=1 to maxs do 
        a[i,j][k]:=0;
      a[i,j][0]:=1; 
    end;
  for i:=1 to 12 do
    for j:=0 to 500 do
    begin
      for k:=1 to maxs do 
        b[i,j][k]:=0;
      b[i,j][0]:=1; 
    end;

  a[0,0][1]:=1;
  for i:=1 to n do
    for j:=1 to n do
      for i1:=t-1 to min(2*t-1,i) do
        if not ((a[i-i1,j-1][0]=1) and (a[i-i1,j-1][1]=0)) then
          a[i,j]:=longsum(a[i,j],a[i-i1,j-1]);

  for i:=1 to n do
    b[1,i]:=a[n,i];


  for i:=0 to 500 do
    for j:=0 to 500 do
    begin
      for k:=1 to maxs do 
        a[i,j][k]:=0;
      a[i,j][0]:=1; 
    end;

  a[0,0][1]:=1;
  for i:=1 to n do
    for j:=1 to n do
      for i1:=t to min(2*t,i) do
        if not ((a[i-i1,j-1][0]=1) and (a[i-i1,j-1][1]=0)) then
          a[i,j]:=longsum(a[i,j],a[i-i1,j-1]);
  for i:=2 to min(n,12) do
    for j:=1 to n do
      for i1:=1 to n do
        if not ((a[i1,j][0]=1) and (a[i1,j][1]=0)) then
          b[i,j]:=longsum(b[i,j],longumn(b[i-1,i1],a[i1,j])); 
  ot[0]:=1; ot[1]:=0;
  for i:=1 to min(n,12) do
    ot:=longsum(ot,b[i,1]);
  vyvod(ot);
end.
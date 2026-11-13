var
  n,x,y,d,i,j,s,kol,m,k : longint;
  fl : array [0..2000000] of longint;
 
function max(a,b : longint) : longint;
begin
  if a>b then max:=a else max:=b;
end;

begin
  assign(input,'marked2.in');
  reset(input);
  assign(output,'marked2.out');
  rewrite(output);
  read(n,x,y);
  m:=1 shl n;
  for j:=0 to m-1 do
    fl[j]:=1;
  s:=0;
  for i:=1 to x do
  begin
    read(k);
    for j:=1 to k do
    begin
      read(d);
      s:=s or (1 shl (d-1));
    end;
  end;
  for j:=0 to m-1 do
    if j or s=s then fl[j]:=0; 

  s:=0;
  for i:=1 to y do
  begin
    read(k);
    for j:=1 to k do
    begin
      read(d);
      s:=s or (1 shl (d-1));
    end;
  end;
  for j:=0 to m-1 do
    if j or s=s then fl[j]:=1; 

  kol:=0;
  for j:=0 to m-1 do
    if fl[j]=0 then inc(kol);
  writeln(kol);
end.
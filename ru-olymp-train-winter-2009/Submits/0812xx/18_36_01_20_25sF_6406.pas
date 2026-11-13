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
    fl[j]:=0;
  for i:=1 to x do
  begin
    read(k);
    s:=0;
    for j:=1 to k do
    begin
      read(d);
      s:=s or (1 shl (d-1));
    end;
    fl[s]:=1;
  end;
  
{  for i:=0 to m-1 do
    write(fl[i],' ');
  writeln;
}
  for i:=m-1 downto 0 do
  begin
    for j:=0 to n-1 do
      if i and (1 shl j)=0 then
        if fl[i or (1 shl j)]=1 then begin fl[i]:=1; break; end;  
  end;

  for i:=1 to y do
  begin
    read(k);
    s:=0;
    for j:=1 to k do
    begin
      read(d);
      s:=s or (1 shl (d-1));
    end;
    fl[s]:=2;
  end;


  for i:=m-1 downto 0 do
  begin
    for j:=0 to n-1 do
      if i and (1 shl j)=0 then
        if fl[i or (1 shl j)]=2 then begin fl[i]:=2; break; end;  
  end;


  kol:=0;
  for j:=0 to m-1 do
    if fl[j]=1 then inc(kol);
  writeln(kol);
end.
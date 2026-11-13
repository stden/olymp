var
  i,j,n,t : longint;
  a,f : array [0..2000] of longint;

function max(a,b : longint) : longint;
begin
  if a>b then max:=a else max:=b;
end;

begin
  assign(input,'cube.in');
  reset(input);
  assign(output,'cube.out');
  rewrite(output);
  read(n);
  for i:=0 to (1 shl n)-1 do
    read(a[i]);
  for i:=0 to (1 shl n)-1 do
  begin
    t:=0;
    for j:=0 to n-1 do
      if i and (1 shl j)<>0 then
        t:=max(t,f[i-(1 shl j)]);
    f[i]:=t+a[i]; 
  end;       
  writeln(f[(1 shl n)-1]);
end.
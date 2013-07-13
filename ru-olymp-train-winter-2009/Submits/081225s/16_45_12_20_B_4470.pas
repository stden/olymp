var
  i,j,k,n,t,s1,s2,r : longint;
  a,f : array [0..9] of longint;

function max(a,b : longint) : longint;
begin
  if a>b then max:=a else max:=b;
end;

begin
  assign(input,'modsum.in');
  reset(input);
  assign(output,'modsum.out');
  rewrite(output);
  read(n);
  for i:=0 to n do
    read(a[i]);
  r:=0;
  for i:=1 to (1 shl n)-2 do
    for j:=1 to (1 shl n)-2 do
      if i and j=0 then
      begin
        s1:=0;
        for k:=0 to n-1 do
          if i and (1 shl k)<>0 then s1:=s1+a[k]; 
        s2:=0;
        for k:=0 to n-1 do
          if j and (1 shl k)<>0 then s2:=s2+a[k]; 
        r:=r+s1 mod s2;
      end; 
  writeln(r);
end.
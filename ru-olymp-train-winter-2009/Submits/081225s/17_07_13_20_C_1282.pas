var
  s1,s2,r : int64;
  i,j,k,n,t,ss,m : longint;
  a,f : array [0..9] of longint;

function max(a,b : longint) : longint;
begin
  if a>b then max:=a else max:=b;
end;

begin
  assign(input,'modsum2.in');
  reset(input);
  assign(output,'modsum2.out');
  rewrite(output);
  read(n);
  for i:=0 to n do
    read(a[i]);
  r:=0;
  m:=1 shl n;
  for i:=1 to m-2 do
  begin
    s1:=0;
    for k:=0 to n-1 do
      if i and (1 shl k)<>0 then s1:=s1+a[k]; 
    ss:=(m-1) and (not i);
    t:=ss;
    while t<>0 do
    begin
      s2:=0;
      for k:=0 to n-1 do
        if t and (1 shl k)<>0 then s2:=s2+a[k]; 
      r:=r+s1 mod s2;
      t:=(t-1) and ss;
    end;
  end; 
  writeln(r);
end.
var
  s1,s2,r : int64;
  i,j,k,n,t,ss,m : longint;
  a,f : array [0..16] of longint;
  s : array [0..1000000] of int64;
 
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
  m:=1 shl n;

  for i:=0 to m-1 do
  begin  
    s1:=0;
    for k:=0 to n-1 do
      if i and (1 shl k)<>0 then s1:=s1+a[k]; 
    s[i]:=s1;
  end;

  r:=0;
  for i:=1 to m-2 do
  begin
    ss:=(m-1) and (not i);
    t:=ss;
    while t<>0 do
    begin
      r:=r+s[i] mod s[t];
      t:=(t-1) and ss;
    end;
  end; 
  writeln(r);
end.
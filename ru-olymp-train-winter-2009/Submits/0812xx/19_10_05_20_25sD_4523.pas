var
  i,j,a1,n : longint;
  r : int64;
  a,f1,f2 : array [1..10] of int64;
  c : array [-1..18,-1..18] of int64;
 
function max(a,b : longint) : longint;
begin
  if a>b then max:=a else max:=b;
end;

procedure rec(k : longint);
var
  i,j : longint;
  d,s1,s2 : int64;
  f : int64;
begin
  if k=11 then
  begin
    s1:=0; s2:=0;
    for i:=1 to 10 do
      s1:=s1+f1[i]*i;
    for i:=1 to 10 do
      s2:=s2+f2[i]*i;
    f:=1;
    for i:=1 to 10 do
      f:=f*c[a[i],f1[i]]*c[a[i]-f1[i],f2[i]];      
    if s2=0 then exit; 
    d:=(s1 mod s2)*f;
    r:=r+d;
  end
           else
  begin
    for i:=0 to a[k] do 
    begin
      for j:=0 to a[k]-i do
      begin
        f1[k]:=i; f2[k]:=j;
        rec(k+1);
      end;       
    end;    
  end;
end;

begin
  assign(input,'modsum3.in');
  reset(input);
  assign(output,'modsum3.out');
  rewrite(output);
  read(n);
  for i:=1 to n do
    a[i]:=0; 
  for i:=1 to n do
  begin
    read(a1);
    inc(a[a1]);
  end;
  for i:=-1 to 10 do
    for j:=-1 to 10 do
      c[i,j]:=0;
  for i:=0 to 10 do
  begin
    for j:=0 to 10 do
    begin 
      c[i,j]:=c[i-1,j]+c[i-1,j-1];
      if (i=0) and (j=0) then c[i,j]:=1; 
    end;
  end;
  r:=0;
  rec(1);
  writeln(r);
end.
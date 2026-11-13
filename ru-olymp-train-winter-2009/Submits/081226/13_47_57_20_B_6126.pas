var
  n,m,i,j,a1,a2 : longint;  
  a : array [1..30,1..30] of longint;
  fl,flot : array [1..30] of longint;
  ot : longint;
  sch : longint;
  
procedure rec(k,l : longint);
var
  i,t,j : longint;
begin
  if sch>100000000 then exit;
  if k-1+n-l<n div 2 then exit;
  if k=n div 2+1 then
  begin
    t:=0;
    for i:=1 to n do
      for j:=1 to n do
      begin  
        if a[i,j]=1 then
          if fl[i]<>fl[j] then inc(t);
        inc(sch);
      end;
    if t<ot then 
    begin
      ot:=t;
      flot:=fl;  
    end;     
  end
               else
  begin
    for i:=l+1 to n do
    begin
      inc(sch);
      fl[i]:=1;
      rec(k+1,i);
      fl[i]:=0; 
    end;  
  end;  
end;

begin
  assign(input,'half.in');
  reset(input);
  assign(output,'half.out');
  rewrite(output);
  read(n,m);
  for i:=1 to n do 
    for j:=1 to n do
      a[i,j]:=0;
  for i:=1 to m do
  begin
    read(a1,a2);
    a[a1,a2]:=1; a[a2,a1]:=1; 
  end;
  for i:=1 to n do
    fl[i]:=0;
  ot:=1000;
  rec(1,0);
  sch:=0;
  for i:=1 to n do
    if flot[i]=flot[1] then write(i,' ');
end.
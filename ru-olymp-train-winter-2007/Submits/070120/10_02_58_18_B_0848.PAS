var
 t,k,x,y,i,j,n,m:longint;
 max,inf,min,kk:int64;
 c:array[1..20]of longint;
 tab:array[1..20,1..20,0..50]of int64;
 tans,ans:array[1..20]of int64;
begin
 inf:=9223372036854775807;
 assign(input,'maxsum.in');
 assign(output,'maxsum.out');
 reset(input);
 rewrite(output);
 read(n,m,kk);
 max:=0;
 for i:=1 to n do
  begin
  read(c[i]);
  if c[i]>max then
   max:=c[i];
  end;
 for i:=1 to n do
  for j:=1 to n do
   for k:=0 to 50 do
    tab[i,j,k]:=-1;
 for i:=1 to m do
  begin
  read(x,y);
  tab[x,y,0]:=max-c[y];
  end;
 for t:=1 to 50 do
  begin
  for k:=1 to n do
   for i:=1 to n do
    for j:=1 to n do
     if (tab[i,k,t-1]<>-1)and(tab[k,j,t-1]<>-1)and((tab[i,j,t]=-1)or(tab[i,k,t-1]+tab[k,j,t-1]<tab[i,j,t])) then
      tab[i,j,t]:=tab[i,k,t-1]+tab[k,j,t-1];
  end;
 max:=max*kk;
 for i:=1 to n do
  ans[i]:=-1;
 ans[1]:=0;
 i:=0;
 while kk<>0 do
  begin
  if (kk mod 2)=1 then
   begin
   for j:=1 to n do
    tans[j]:=-1;
   for j:=1 to n do
    for k:=1 to n do
     if (tab[j,k,i]<>-1)and(ans[j]<>-1)and((tans[k]=-1)or(tans[k]>ans[j]+tab[j,k,i]))then
      tans[k]:=ans[j]+tab[j,k,i];
   ans:=tans;
   end;
  i:=i+1;
  kk:=kk div 2;
  end;
 min:=inf;
 for i:=1 to n do
  if (tans[i]<>-1) and (tans[i]<min) then
   min:=tans[i];
 writeln(c[1]+max-min);
 close(input);
 close(output);
end.

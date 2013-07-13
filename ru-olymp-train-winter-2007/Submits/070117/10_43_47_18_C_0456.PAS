var
 s,ans,t,day,a,b,p,inf,i,j,x,y,n,m,k:longint;
 q,d:array[1..50,0..50]of longint;
 tab:array[1..50,1..300000]of longint;
 dd:array[1..50]of longint;
begin
 inf:=1000000000;
 assign(input,'restore.in');
 assign(output,'restore.out');
 reset(input);
 rewrite(output);
 read(n,m,p);
 fillchar(tab,sizeof(tab),0);
 for i:=1 to n do
  for j:=1 to n do
   if i=j then
    d[i,j]:=0
   else
    d[i,j]:=inf;
 for i:=1 to m do
  begin
  read(x,y);
  d[x,y]:=1;
  d[y,x]:=1;
  end;
 for k:=1 to n do
  for i:=1 to n do
   for j:=1 to n do
    if d[i,j]>d[i,k]+d[j,k] then
     d[i,j]:=d[i,k]+d[j,k];

{ for i:=1 to n do
  begin
  for j:=1 to n do
   write(d[i,j],' ');
  writeln;
  end;}

 read(s,t);
 for i:=1 to n do
  dd[i]:=d[s,i];
 for i:=1 to n do
  for j:=1 to n do
   if i<>j then
    q[i,dd[j]]:=q[i,dd[j]]+1;
 read(a,b);
 for i:=1 to n do
  begin
  if dd[i]=a then
   tab[i,1]:=1
  else
   tab[i,1]:=0;
  end;
 b:=b-1;
 day:=1;
 for i:=1 to t do
  begin
  while b>0 do
   begin
   day:=day+1;
   for j:=1 to n do
    begin
    tab[j,day]:=0;
    if dd[j]=a then
     begin
     for k:=1 to n do
      if d[j,k]=1 then
       tab[j,day]:=(tab[j,day]+tab[k,day-1]) mod p;
     end;
    end;
   b:=b-1;
   end;
  if not seekeof then
   read(a,b);
  end;
 ans:=0;
 for i:=1 to n do
  ans:=(ans+tab[i,day]) mod p;
 write(ans);
 close(input);
 close(output);
end.

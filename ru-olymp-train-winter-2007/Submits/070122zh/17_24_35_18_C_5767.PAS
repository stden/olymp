var
 nn,t,k,maxn,j,ll,i,n:longint;
 fl:boolean;
 tab:array[1..200,1..200]of longint;
 l:array[1..200]of longint;
 elem:array[1..200]of boolean;
begin
 assign(input,'partitions.in');
 assign(output,'partitions.out');
 reset(input);
 rewrite(output);
 while true do
  begin
  readln(n,k);
  if n=0 then
   break;
  for i:=1 to k do
   begin
   j:=1;
   while not seekeoln do
    begin
    read(tab[i,j]);
    j:=j+1;
    end;
   readln;
   l[i]:=j-1;
   end;

  for i:=1 to n do
   elem[i]:=false;
  i:=k;
  fl:=false;
  ll:=0;
  maxn:=0;

  while not(fl) do
   begin
   for j:=1 to l[i] do
    begin
    ll:=ll+1;
    elem[tab[i,j]]:=true;
    end;
   maxn:=n;
   t:=tab[i,l[i]]+1;
   while (t<=n) and not(elem[t]) do
    t:=t+1;
   if t<=n then
    begin
    j:=l[i]+1;
    tab[i,l[i]+1]:=tab[i,l[i]];
    i:=i-1;
    break;
    end;
   while not(elem[maxn])do
    maxn:=maxn-1;
   j:=l[i];
   while j>0 do
    begin
    if tab[i,j]<maxn then
     begin
     fl:=true;
     break;
     end;
    if j=2 then
     break;
    j:=j-1;
    end;
   i:=i-1;
   end;
  i:=i+1;

//  writeln(i);
  t:=tab[i,j]+1;
  while not(elem[t]) do
   t:=t+1;
  tab[i,j]:=t;
  for t:=1 to j do
   elem[tab[i,t]]:=false;
  l[i]:=j;
  nn:=0;
  for t:=1 to n do
   if elem[t] then
    nn:=nn+1;
  writeln(n,' ',i+nn);
  for t:=1 to i do
   begin
   for j:=1 to l[t] do
    write(tab[t,j],' ');
   writeln;
   end;
  for t:=1 to n do
   if elem[t] then
    writeln(t);
  writeln;
  end;
 close(input);
 close(output);
end.

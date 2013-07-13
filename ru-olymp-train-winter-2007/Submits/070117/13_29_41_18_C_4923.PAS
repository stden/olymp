{$mode delphi}
var
 kk,ff,s,ans,t,day,a,b,p,inf,i,j,x,y,n,m,k:longint;
 d:array[0..50,0..50]of longint;
 q:array[1..50,1..50]of boolean;
 tt:array[1..50,1..50,0..31]of longint;
 now,last:array[1..50]of longint;
 dd:array[1..50]of longint;

procedure dfs(i,l,st:longint);
var
 j:longint;
begin
 q[st,i]:=true;
 for j:=1 to n do
  if (d[i,j]=1) and (not(q[st,j])) and (dd[j]=l) then
   dfs(j,l,st);
end;

begin
 inf:=1000000000;
 assign(input,'restore.in');
 assign(output,'restore.out');
 reset(input);
 rewrite(output);
 read(n,m,p);
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

 read(s,t);
 for i:=1 to n do
  dd[i]:=d[s,i];

 fillchar(q,sizeof(q),0);

 for i:=1 to n do
  dfs(i,dd[i],i);

 fillchar(tt,sizeof(tt),0);

 for i:=1 to n do
  for j:=1 to n do
   if (q[i,j])and(d[i,j]=1) then
    tt[i,j,0]:=1;

 for k:=1 to 30 do
  for i:=1 to n do
   for j:=1 to n do
    if (q[i,j]) then
     for kk:=1 to n do
      if q[i,kk] then
       tt[i,j,k]:=(int64(tt[i,j,k])+int64(tt[i,kk,k-1])*int64(tt[kk,j,k-1])) mod p;


 read(a,b);
 for i:=1 to n do
  begin
  if dd[i]=a then
   now[i]:=1
  else
   now[i]:=0;
  end;
 b:=b-1;
 day:=1;

 for i:=1 to t do
  begin
  last:=now;
  day:=day+1;
  if b>0 then
   begin
   for j:=1 to n do
    begin
    now[j]:=0;
    if dd[j]=a then
     begin
     for k:=1 to n do
      if d[j,k]=1 then
        now[j]:=(now[j]+last[k]) mod p;
     end;
    end;
   end;

  b:=b-1;
  ff:=0;
  while b>0 do
   begin
   if b mod 2=0 then
    begin
    ff:=ff+1;
    b:=b div 2;
    continue;
    end;
   last:=now;

   for j:=1 to n do
    begin
    now[j]:=0;
    if dd[j]=a then
     begin
     for k:=1 to n do
      now[j]:=(int64(now[j])+int64(last[k])*int64(tt[j,k,ff])) mod p;
     end;
    end;
   ff:=ff+1;
   b:=b div 2;
   end;

  if not seekeof then
   read(a,b);
  end;
 ans:=0;
 for i:=1 to n do
  ans:=(ans+now[i]) mod p;
 write(ans);
 close(input);
 close(output);
end.

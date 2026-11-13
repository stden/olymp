uses
 Math;

const
 maxn=3;
 maxw=20;

type
 integer=longint;

var
 v,m,cnt,i,j,n,w1,w2:integer;
 Color,list,r,c,a,w:array[0..maxn] of integer;
 D:array[1..maxn,0..maxw*2] of integer;
procedure DFS(v:integer);
begin
 Color[v]:=1;
 if Color[r[v]]=0 then
  DFS(r[v]);
 dec(cnt);
 list[cnt]:=v;
end;

begin
 assign(input,'system.in'); reset(input);
 assign(output,'system.out'); rewrite(output);
 readln(n);
 for i:=1 to n do
  read(r[i],c[i],a[i],w[i]);
 cnt:=N+1;

 Color[0]:=1;
 for i:=1 to n do
  if Color[i]=0 then
   DFS(i);

 fillchar(D,sizeof(D),0);
 for i:=1 to n-1 do begin
  v:=list[i];
  for w1:=0 to w[1] do
   for w2:=w[1] downto 0 do begin
    if (w1>0) and (D[v,w1]=0) then continue;
    if (w2>0) and (D[r[v],w2]=0) then continue;
    if D[v,w1]<=c[v]-a[v] then
     D[r[v],w1+w2+w[v]]:=max(D[r[v],w1+w2+w[v]],D[r[v],w2]+D[v,w1]+a[v])
    else
     D[r[v],w1+w2]:=max(D[r[v],w1+w2],D[r[v],w2]+D[v,w1]+a[v])
   end;
 end;

 for i:=w[1]-1 downto 0 do
  if D[1,i]>c[1]-a[1] then
   m:=i;
 m:=min(w[1],m);
 writeln(m);
 close(input);
 close(output);
end.

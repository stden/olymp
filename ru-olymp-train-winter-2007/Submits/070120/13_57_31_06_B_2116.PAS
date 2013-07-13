{$R-,S-,Q-,B-}

const taskid='maxsum';

var t,i,j,n,m,l,u,v:longint;
    a:array [1..21,1..21] of boolean;
    c:array [1..21] of longint;
    d:array [0..1000,1..21,1..21] of longint;
    max:array [0..1000,1..21] of longint;
    cur,s,f,k,ans,tc:int64;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(a,sizeof(a),0);
readln(n,m,k);
for i:=1 to n do read(c[i]);
for i:=1 to m do
 begin
 read(u,v);
 a[u,v]:=true;
 end;
fillchar(d,sizeof(d),255);
for i:=1 to n do d[0,i,i]:=0;
for i:=1 to m do
 for u:=1 to n do
  for v:=1 to n do
   for l:=1 to n do
    if a[v,l] and (d[i-1,u,v]>=0) and (d[i,u,l]<d[i-1,u,v]+c[l]) then d[i,u,l]:=d[i-1,u,v]+c[l];
fillchar(max,sizeof(max),0);
for i:=1 to n do
 for j:=0 to m do
  for u:=1 to n do
   if d[j,i,u]>max[j,i] then max[j,i]:=d[j,i,u];
ans:=0;
if k<=m then
 begin
 for u:=1 to n do
  if d[k,1,u]>ans then ans:=d[k,1,u];
 end
else
 begin
 for i:=1 to n do
   for l:=0 to m do
    if d[l,i,i]>0 then
     for j:=0 to n do
      if d[j,1,i]>0 then
       begin
       s:=(k-int64(j)-int64(n)) div l;
       if s*l<k-int64(j)-int64(n) then inc(s);
       f:=(k-int64(j)) div l;
       if s>f then continue;
       cur:=int64(d[j,1,i])+s*int64(d[l,i,i])+int64(max[k-int64(j)-s*int64(l),i]);
       tc:=s;
       for t:=0 to f-s do
        begin
        if cur>ans then ans:=cur;
        if tc<f then
         cur:=cur+int64(d[l,i,i])-int64(max[k-int64(j)-tc*int64(l),i])+
              int64(max[k-int64(j)-(tc+1)*int64(l),i]);
        inc(tc);
        end;
       end;
 end;
writeln(ans+int64(c[1]));
close(output);
end.

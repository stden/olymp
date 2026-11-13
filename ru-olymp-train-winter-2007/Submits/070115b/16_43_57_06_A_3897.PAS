{$R-,S-,Q-,B-}
{$M 16000000}


const taskid='bridges';

var t,ans,u,v,i,j,n,m,k:longint;
    d,s,p:array [1..20003] of longint;
    a:array [1..400003,1..2] of longint;
    r:array [1..400003] of longint;
    ind:array [1..400003] of longint;
    ar:array [1..200003] of longint;

function min(a,b:longint):longint;
 begin
 if a<b then min:=a else min:=b;
 end;

function dfs(u,q:longint):longint;
 var v,l:longint;
 begin
 inc(t);
 d[u]:=t;
 l:=t;
 for v:=p[u] to p[u]+s[u]-1 do
  begin
  if d[r[v]]=0 then l:=min(l,dfs(r[v],ind[v]))
  else if ind[v]<>q then l:=min(l,d[r[v]]);
  end;
 if l>=d[u] then
  begin
  inc(ans);
  ar[ans]:=q;
  end;
 dfs:=l;
 end;

begin
fillchar(a,sizeof(a),0);
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(s,sizeof(s),0);
readln(n,m);
for i:=1 to m do
 begin
 readln(u,v);
 inc(s[u]);
 inc(s[v]);
 a[i,1]:=u;
 a[i,2]:=v;
 a[m+i,1]:=v;
 a[m+i,2]:=u;
 end;
p[1]:=1;
for i:=2 to n do p[i]:=p[i-1]+s[i-1];
for i:=1 to 2*m do
 begin
 r[p[a[i,1]]]:=a[i,2];
 ind[p[a[i,1]]]:=i;
 if ind[p[a[i,1]]]>m then dec(ind[p[a[i,1]]],m);
 inc(p[a[i,1]]);
 end;
p[1]:=1;
for i:=2 to n do p[i]:=p[i-1]+s[i-1];
ans:=0;
fillchar(d,sizeof(d),0);
t:=1;
d[1]:=1;
for i:=1 to s[1] do dfs(r[i],ind[i]);
for i:=1 to ans-1 do
 for j:=i+1 to ans do
  if ar[i]>ar[j] then
   begin
   u:=ar[i];
   ar[i]:=ar[j];
   ar[j]:=u;
   end;
writeln(ans);
if ans>0 then writeln(ar[1]);
for i:=2 to ans do
 if ar[i]<>ar[i-1] then writeln(ar[i]);
close(output);
end.

{$R-,S-,Q-,B-}

const taskid='biconn';
      maxn=50007;

var p1,p2,ans,h,g,cur,max,done,u,v,i,j,k,n,num:longint;
    a,r:array [1..2*maxn,1..2] of longint;
    w1,w2,l,dep,p,s,pr:array [1..maxn] of longint;
    ra:array [1..maxn,1..2] of longint;
    b:array [1..2*maxn] of boolean;

procedure dfs(u,de:longint);
 var i:longint;
 begin
 dep[u]:=de;
 for i:=p[u] to p[u]+s[u]-1 do
  if (dep[r[i,2]]=0) then
   begin
   pr[r[i,2]]:=i;
   dfs(r[i,2],de+1);
   end;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(b,sizeof(b),0);
readln(n);
for i:=1 to n-1 do
 begin
 readln(u,v);
 inc(s[u]);
 inc(s[v]);
 a[i,1]:=u;
 a[i,2]:=v;
 a[n-1+i,1]:=v;
 a[n-1+i,2]:=u;
 end;
p[1]:=1;
for i:=2 to n do p[i]:=p[i-1]+s[i-1];
for i:=1 to 2*(n-1) do
 begin
 r[p[a[i,1]],1]:=a[i,1];
 r[p[a[i,1]],2]:=a[i,2];
 inc(p[a[i,1]]);
 end;
p[1]:=1;
for i:=2 to n do p[i]:=p[i-1]+s[i-1];
fillchar(dep,sizeof(dep),0);
dfs(1,1);
for i:=1 to n do
 if s[i]=1 then
  begin
  inc(num);
  l[num]:=i;
  end;
done:=0;
ans:=0;
while done<n-1 do
 begin
 max:=0;
 for p1:=1 to num-1 do
  for p2:=p1+1 to num do
    begin
    i:=l[p1];
    j:=l[p2];
    w1[dep[i]-1]:=pr[i];
    w2[dep[j]-1]:=pr[j];
    for g:=dep[i]-2 downto 1 do w1[g]:=pr[r[w1[g+1],1]];
    for g:=dep[j]-2 downto 1 do w2[g]:=pr[r[w2[g+1],1]];
    k:=1;
    while w1[k]=w2[k] do inc(k);
    cur:=0;
    for g:=k to dep[i]-1 do
     if not b[w1[g]] then inc(cur);
    for g:=k to dep[j]-1 do
     if not b[w2[g]] then inc(cur);
    if cur>max then
     begin
     max:=cur;
     u:=i;
     v:=j;
     h:=k;
     end;
    end;
 inc(ans);
 ra[ans,1]:=u;
 ra[ans,2]:=v;
 w1[dep[u]-1]:=pr[u];
 w2[dep[v]-1]:=pr[v];
 for g:=dep[u]-2 downto 1 do w1[g]:=pr[r[w1[g+1],1]];
 for g:=dep[v]-2 downto 1 do w2[g]:=pr[r[w2[g+1],1]];
 k:=1;
 while w1[k]=w2[k] do inc(k);
 cur:=0;
 for g:=k to dep[u]-1 do b[w1[g]]:=true;
 for g:=k to dep[v]-1 do b[w2[g]]:=true;
 done:=done+max;
 end;
writeln(ans);
for i:=1 to ans do writeln(ra[i,1],' ',ra[i,2]);
close(output);
end.

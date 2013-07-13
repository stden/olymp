{$R-,S-,Q-,B-}

const taskid='path';
      p2=32768;

var d:array [1..2*p2] of longint;
    t:array [0..30001] of longint;
    u,v,n,m,i,j,k:longint;
    a:array [1..800003,1..2] of longint;
    r,c,c1,p,s:array [1..800003] of longint;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n,m);
fillchar(s,sizeof(s),0);
for i:=1 to m do
 begin
 readln(u,v,c1[i]);
 inc(s[u]);
 inc(s[v]);
 a[i,1]:=u;
 a[i,2]:=v;
 a[m+i,1]:=v;
 a[m+i,2]:=u;
 c1[m+i]:=c1[i];
 end;
p[1]:=1;
for i:=2 to n do p[i]:=p[i-1]+s[i-1];
for i:=1 to 2*m do
 begin
 r[p[a[i,1]]]:=a[i,2];
 c[p[a[i,1]]]:=c1[i];
 inc(p[a[i,1]]);
 end;
p[1]:=1;
for i:=2 to n do p[i]:=p[i-1]+s[i-1];
fillchar(t,sizeof(t),63);
t[1]:=0;
for i:=p2 to p2+i-1 do d[i]:=i-p2+1;
for i:=p2-1 downto 1 do
 if t[d[2*i]]<t[d[2*i+1]] then d[i]:=d[2*i] else d[i]:=d[2*i+1];
for i:=1 to n do
 begin
 u:=d[1];
 for j:=p[u] to p[u]+s[u]-1 do
  begin
  if t[r[j]]>t[u]+c[j] then
   begin
   t[r[j]]:=t[u]+c[j];
   k:=(p2+r[j]-1) div 2;
   while k>0 do
    begin
    if t[d[2*k]]<t[d[2*k+1]] then d[k]:=d[2*k] else d[k]:=d[2*k+1];
    k:=k div 2;
    end;
   end;
  end;
 d[p2+u-1]:=0;
 k:=(p2+u-1) div 2;
 while k>0 do
  begin
  if t[d[2*k]]<t[d[2*k+1]] then d[k]:=d[2*k] else d[k]:=d[2*k+1];
  k:=k div 2;
  end;
 end;
for i:=1 to n do write(t[i],' ');
close(output);
end.

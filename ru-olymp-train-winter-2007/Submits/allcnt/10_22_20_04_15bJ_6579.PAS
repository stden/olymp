program path;
const
maxn=30000;
maxm=400000;
tn='path';
var
n,k,v,i,j,m,cnt,x:longint;
p:array[1..maxm,0..2] of longint;
bob:array[1..maxn,0..1] of longint;
h,l,d:array[1..maxn] of longint;
u:array[1..maxn] of boolean;

procedure swap(i,j:longint);
var
c:longint;
begin
c:=h[i];
h[i]:=h[j];
h[j]:=c;
l[h[i]]:=i;
l[h[j]]:=j;
end;

function more(i,j:longint):boolean;
begin
more:=(d[h[i]]>d[h[j]]);
end;

procedure HeUp(v:longint);
begin
 while true do
  begin
   if v=1 then exit;
   if not more(v div 2,v) then exit;
   swap(v,v div 2);
   v:=v div 2;
  end;
end;

procedure HeDo(v:longint);
var
mn:longint;
begin
while true do
 begin
  if v*2>cnt then exit;
  if v*2=cnt then mn:=cnt else
   if more(v*2,v*2+1) then mn:=v*2+1 else mn:=v*2;
  if not more(v,mn) then exit;
  swap(v,mn);
  v:=mn;
 end;
end;

function ExMin:longint;
begin
ExMin:=h[1];
swap(1,cnt);
dec(cnt);
HeDo(1);
end;

begin
 Assign(input,tn+'.in');Reset(input);
 Assign(output,tn+'.out');rewrite(output);
 read(n,m);
 for i:=1 to m do
  begin
   read(x,p[i,0],p[i,1]);
   if bob[x,0]=0 then
    begin
     bob[x,0]:=i;
     bob[x,1]:=i;
    end else
    begin
     p[bob[x,1],2]:=i;
     bob[x,1]:=i;
    end;
   p[m+i,0]:=x;
   p[m+i,1]:=p[i,1];
   if bob[p[i,0],0]=0 then
    begin
     bob[p[i,0],0]:=m+i;
     bob[p[i,0],1]:=m+i;
    end else
    begin
     p[bob[p[i,0],1],2]:=m+i;
     bob[p[i,0],1]:=m+i;
    end;
  end;

 for i:=1 to n do
  begin
   h[i]:=i;
   l[i]:=i;
   d[i]:=maxlongint;
  end;
  cnt:=n;
  d[1]:=0;
  while cnt>0 do
   begin
    v:=ExMin;
    u[v]:=true;
    i:=bob[v,0];
    while (i<>0) do
     begin
      if (not u[p[i,0]])and(d[p[i,0]]>d[v]+p[i,1]) then
       begin
        d[p[i,0]]:=d[v]+p[i,1];
        HeUp(l[p[i,0]]);
       end;
      i:=p[i,2];
     end;
   end;
 for i:=1 to n do write(d[i],' ');
 Close(input);Close(output);
end.
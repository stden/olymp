program aa;
const
tn = 'system';
maxn=200;
maxw=500;
var
n,k,i,j,maxcw:longint;
d:array[0..maxn,0..maxw] of longint;
dd:array[0..maxn,0..maxw] of longint;
a:array[1..maxn] of record
                     r,c,a,w,cnt:longint;
                     ch:array[1..maxn] of byte;
                    end;

function max(x,y:longint):longint;
begin
 if x>y then max:=x else max:=y;
end;

procedure DFS(v:longint);
var
i,j,p:longint;
begin
if a[v].cnt=0 then
 begin
  for i:=a[v].w to maxcw do d[v,i]:=a[v].a;
  exit;
 end;
fillchar(dd,sizeof(dd),0);
for i:=1 to a[v].cnt do
 begin
  DFS(a[v].ch[i]);
 end;
 fillchar(dd,sizeof(dd),0);
for i:=1 to a[v].cnt do
begin
  for j:=0 to maxcw do
   begin
    for p:=0 to j do
     begin
      dd[i,j]:=max(dd[i,j],dd[i-1,p]+d[a[v].ch[i],j-p]);
     end;
   end;
  p:=dd[i,0];
  for j:=1 to maxcw do
   begin
    if dd[i,j]>p then p:=dd[i,j] else dd[i,j]:=p;
   end;
 end;
{writeln('LOG ',v);
for i:=1 to a[v].cnt do
 begin
  for j:=0 to maxw do write(dd[i,j],' ');
  writeln;
 end;}
for i:=0 to maxcw do
 begin
  if dd[a[v].cnt,i]+a[v].a>a[v].c then
   begin
  d[v,i]:=max(d[v,i],dd[a[v].cnt,i]+a[v].a);
   end;
  if i>=a[v].w then
   begin
    d[v,i]:=max(d[v,i],dd[a[v].cnt,i-a[v].w]+a[v].a);
   end;
 end;
p:=d[v,0];
for i:=1 to maxcw do
 begin
  if d[v,i]>p then p:=d[v,i] else d[v,i]:=p;
 end;
{writeln('LG ',v);
for i:=1 to n do
 begin
  for j:=0 to maxw do write(d[i,j],' ');
  writeln;
 end;}
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n);
fillchar(d,sizeof(d),0);
fillchar(a,sizeof(a),0);
for i:=1 to n do
 begin
  read(a[i].r,a[i].c,a[i].a,a[i].w);
  inc(a[a[i].r].cnt);
  a[a[i].r].ch[a[a[i].r].cnt]:=i;
 end;
maxcw:=a[1].w;
 DFS(1);
{           writeln;
 for i:=1 to n do
  begin
   for j:=0 to maxw do write(d[i,j],' ');
   writeln;
  end;}
i:=0;
while (d[1,i]=0)and(i<=maxcw) do inc(i);
if i>maxcw then write(maxcw) else write(i);
Close(input);Close(output);
end.

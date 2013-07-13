program aa;
const
tn = 'system';
maxn=200;
maxw=5;
var
n,k,i,j:longint;
d:array[0..maxn,0..maxw] of longint;
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
dd:array[0..maxn,0..maxw] of longint;
begin
if a[v].cnt=0 then
 begin
  for i:=a[v].w to maxw do d[v,i]:=a[v].a;
  exit;
 end;
fillchar(dd,sizeof(dd),0);
for i:=1 to a[v].cnt do
 begin
  DFS(a[v].ch[i]);
  for j:=0 to maxw do
   begin
    for p:=0 to j do
     begin
      dd[i,j]:=max(dd[i,j],dd[i-1,p]+d[a[v].ch[i],j-p]);
     end;
   end;
  p:=dd[i,0];
  for j:=1 to maxw do
   begin
    if dd[i,j]>p then p:=dd[i,j] else dd[i,j]:=p;
   end;
 end;
{for i:=1 to a[v].cnt do
 begin
  for j:=0 to maxw do write(dd[i,j],' ');
  writeln;
 end;}
for i:=0 to maxw do
 begin
  if dd[a[v].cnt,i]>a[v].c then
   begin
  d[v,i]:=dd[a[v].cnt,i];
  d[v,i+a[v].w]:=dd[a[v].cnt,i]+a[v].a;
   end;
 end;
p:=d[v,0];
for i:=1 to maxw do
 begin
  if d[v,i]>p then p:=d[v,i] else d[v,i]:=p;
 end;
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

 DFS(1);
{           writeln;
 for i:=1 to n do
  begin
   for j:=0 to maxw do write(d[i,j],' ');
   writeln;
  end;}
i:=0;
while (d[1,i]=0) do inc(i);
write(i);
Close(input);Close(output);
end.

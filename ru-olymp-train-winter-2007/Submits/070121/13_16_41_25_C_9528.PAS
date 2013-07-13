program sh;
const tn='tri';
var a:array[1..2,1..262144]of longint;
    off1,off2,nx,cnt1,cnt2,n,i:longint;
    t1,t2:array[1..262144]of longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 for i:=1 to n do read(a[1,i],a[2,i]);
 i:=1;
 while true do
 begin
  nx:=i+1; if nx>n then nx:=1;
  if a[1,nx]<a[1,i] then break;
  i:=nx;
 end;

 while true do
 begin
  nx:=i+1; if nx>n then nx:=1;
  if a[1,nx]>a[1,i] then break;
  i:=nx;
 end;
 while true do
 begin
  nx:=i+1; if nx>n then nx:=1;
  inc(cnt1);
  t1[cnt1]:=i;
  if a[1,nx]<a[1,i] then break;

  i:=nx;
 end;
 i:=t1[1];
 while true do
 begin
  inc(cnt2);
  t2[cnt2]:=i;
  nx:=i-1; if nx=0 then nx:=n;
  if a[1,nx]<a[1,i] then break;
  i:=nx;
 end;
 off1:=1;
 off2:=1;
 while (t1[off1+1]<>t2[off2+1]) do
 begin
  writeln(t1[off1],' ',t1[off1+1],' ',t2[off2+1]);
  if a[1,t1[off1+1]]>a[1,t2[off2+1]] then
  begin
   inc(off2);
   t1[off1]:=t2[off2];
  end else
  begin
   inc(off1);
   t2[off2]:=t1[off1];
  end;
 end;
 close(input);close(output);
end.

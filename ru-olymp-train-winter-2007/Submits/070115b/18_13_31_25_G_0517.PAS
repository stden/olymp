program sh;
const tn='minimal';
var a:array[1..4000,1..4000]of byte;
    cnt1,cnt2,n,m:longint;
    w1,w2:array[1..4000]of boolean;
    p:array[1..4000]of longint;
procedure dfs(const  v:longint);
var i:longint;
begin
 if v=0 then exit;
 w2[v]:=true;
 for i:=1 to m do
  if (a[i,v]<>0) then
   if w1[i]=false then
   begin
    w1[i]:=true;
    dfs(p[i]);
   end;
end;
var i,c,j,f:longint;
    u:array[1..4000]of byte;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(m,n);
 for i:=1 to m do
 begin
  read(c);
  for j:=1 to c do
  begin
   read(f);
   a[i,f]:=1;
  end;
 end;
 for i:=1 to m do read(p[i]);
 fillchar(u,sizeof(u),0);
 for i:=1 to m do u[p[i]]:=1;
 fillchar(w1,sizeof(w1)*2,false);
 for i:=1 to n do if u[i]=0 then dfs(i);

 cnt1:=0;
 for i:=1 to m do
  if w1[i] then inc(cnt1);
 cnt2:=0;
 for i:=1 to n do
  if not w2[i] then inc(cnt2);
 writeln(cnt1+cnt2);
  write(cnt1,' ');
 for i:=1 to m do
  if w1[i] then write(i,' ');
 writeln;
  write(cnt2,' ');
 for i:=1 to n do
  if not w2[i] then write(i,' ');
 close(input);close(output);
end.

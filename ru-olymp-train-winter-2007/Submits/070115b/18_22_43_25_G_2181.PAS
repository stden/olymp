program sh;
const tn='minimal';
var a:array[1..2,1..500000]of longint;
    cnt1,cnt2,n,m:longint;
    w1,w2:array[1..4000]of boolean;
    p,nav:array[1..4001]of longint;
procedure dfs(const  v:longint);
var i:longint;
begin
 if v=0 then exit;
 w2[v]:=true;
 for i:=nav[v] to nav[v+1]-1 do
   if w1[a[2,i]]=false then
   begin
    w1[a[2,i]]:=true;
    dfs(p[a[2,i]]);
   end;
end;
function More1(const i,j:longint):boolean;
begin
 more1:=(a[1,i]>a[1,j]);
end;
procedure swel1(const b,c:longint);
var d:longint;
    d2:extended;
begin
 d:=a[1,b];a[1,b]:=a[1,c];a[1,c]:=d;
 d:=a[2,b];a[2,b]:=a[2,c];a[2,c]:=d;
end;
procedure heup1(a:longint);
begin
 while true do
 begin
  if a=1 then exit;
  if not more1(a,a div 2) then exit;
  swel1(a,a div 2);
  a:=a div 2;
 end;
end;
procedure hedo1(e:longint);
begin
 while true do
 begin
  if e*2>cnt1 then exit else
  if e*2=cnt1 then
  begin
    if more1(e*2,e) then
    begin
     swel1(e*2,e);
     e:=e*2;
    end else exit;
  end else
  begin
   if More1(e*2,e*2+1) then
   begin
    if more1(e*2,e) then
    begin
     swel1(e*2,e);
     e:=e*2;
    end else exit;
   end else
   begin
    if more1(e*2+1,e) then
    begin
     swel1(e*2+1,e);
     e:=e*2+1;
    end else exit;
   end;
  end;
 end;
end;
procedure add1(const v1,v2:longint);
begin
 inc(cnt1);a[1,cnt1]:=v1;a[2,cnt1]:=v2;heup1(cnt1);
end;

var i,c,j,f,tt:longint;
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
   add1(f,i);
  end;
 end;
 tt:=cnt1;
 for i:=1 to tt do
 begin
  swel1(cnt1,1);
  dec(cnt1);
  hedo1(1);
 end;
 for i:=1 to tt do
  if nav[a[1,i]]=0 then nav[a[1,i]]:=i;
 nav[n+1]:=tt+1;
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

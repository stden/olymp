{$Q+,R+,S+}
program sh;
const tn='path';
var a:array[1..3,1..800002]of longint;
    cnt1,cnt2:longint;
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
 d:=a[3,b];a[3,b]:=a[3,c];a[3,c]:=d;
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
procedure add1(const v1,v2,v3:longint);
begin
 inc(cnt1);a[1,cnt1]:=v1;a[2,cnt1]:=v2;a[3,cnt1]:=v3;heup1(cnt1);
end;
var nv,e,ps,u,h:array[1..30001]of longint;
function More2(const i,j:longint):boolean;
begin
 more2:=(e[h[i]]<e[h[j]]);
end;
procedure swel2(const b,c:longint);
var d:longint;
    d2:extended;
begin
 d:=h[b];h[b]:=h[c];h[c]:=d;
 ps[h[b]]:=b;
 ps[h[c]]:=c;
end;
procedure heup2(a:longint);
begin
 while true do
 begin
  if a=1 then exit;
  if not more2(a,a div 2) then exit;
  swel2(a,a div 2);
  a:=a div 2;
 end;
end;
procedure hedo2(e:longint);
begin
 while true do
 begin
  if e*2>cnt2 then exit else
  if e*2=cnt2 then
  begin
    if more2(e*2,e) then
    begin
     swel2(e*2,e);
     e:=e*2;
    end else exit;
  end else
  begin
   if More2(e*2,e*2+1) then
   begin
    if more2(e*2,e) then
    begin
     swel2(e*2,e);
     e:=e*2;
    end else exit;
   end else
   begin
    if more2(e*2+1,e) then
    begin
     swel2(e*2+1,e);
     e:=e*2+1;
    end else exit;
   end;
  end;
 end;
end;
procedure add2(const t:longint);
begin
 inc(cnt2);h[cnt2]:=t;ps[t]:=cnt2;heup2(cnt2);
end;
function exmin2:longint;
begin
 exmin2:=h[1];
 swel2(1,cnt2);
 dec(cnt2);
 hedo2(1);
end;
var n,k,i,v,v1,v2,w:longint;

begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n,k);
 for i:=1 to k do
 begin
  read(v1,v2,w);
  add1(v1,v2,w);
  add1(v2,v1,w);
 end;
 k:=2*k;
 for i:=1 to k do
 begin
  swel1(1,cnt1);
  dec(cnt1);hedo1(1);
 end;
 for i:=1 to k do
  if nv[a[1,i]]=0 then nv[a[1,i]]:=i;
 nv[n+1]:=k+1;
 e[1]:=0;
 for i:=2 to n do e[i]:=maxlongint div 2;
 for i:=1 to n do
  add2(i);
 fillchar(u,sizeof(u),0);
 for k:=1 to n do
 begin
  v:=exmin2;
  u[v]:=1;
  for i:=nv[v] to nv[v+1]-1 do
   if u[a[2,i]]=0 then
   if e[a[2,i]]>e[v]+a[3,i] then
   begin
    e[a[2,i]]:=e[v]+a[3,i];
    heup2(ps[a[2,i]]);
   end;
 end;
 for i:=1 to n do write(e[i],' ');
 close(input);close(output);
end.

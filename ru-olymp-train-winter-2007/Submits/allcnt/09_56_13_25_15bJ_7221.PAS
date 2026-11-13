program sh;
const tn='path';
var a:array[1..3,1..800002]of longint;
    nac:array[1..30000]of longint;
    kon,ps,e,h,u:array[1..30000]of longint;
    cnt:longint;
var n,k,i,v,v1,v2,w:longint;
function More(const i,j:longint):boolean;
begin
 more:=(e[h[i]]<e[h[j]]);
end;
procedure swel(const b,c:longint);
var d:longint;
begin
 d:=h[b];h[b]:=h[c];h[c]:=d;
 ps[h[b]]:=b;
 ps[h[c]]:=c;
end;
procedure heup(a:longint);
begin
 while true do
 begin
  if a=1 then exit;
  if not more(a,a div 2) then exit;
  swel(a,a div 2);
  a:=a div 2;
 end;
end;
procedure hedo(e:longint);
begin
 while true do
 begin
  if e*2>cnt then exit else
  if e*2=cnt then
  begin
    if more(e*2,e) then
    begin
     swel(e*2,e);
     e:=e*2;
    end else exit;
  end else
  begin
   if More(e*2,e*2+1) then
   begin
    if more(e*2,e) then
    begin
     swel(e*2,e);
     e:=e*2;
    end else exit;
   end else
   begin
    if more(e*2+1,e) then
    begin
     swel(e*2+1,e);
     e:=e*2+1;
    end else exit;
   end;
  end;
 end;
end;
function  exmin:longint;
begin
 exmin:=h[1];
 swel(1,cnt);
 dec(cnt);
 hedo(1);
end;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n,k);
 for i:=1 to k do
 begin
  read(v1,a[1,i],a[2,i]);
  a[1,i+k]:=v1;
  a[2,i+k]:=a[2,i];
  if nac[v1]=0 then
  begin
   nac[v1]:=i;
   kon[v1]:=i;
  end else
  begin
   a[3,kon[v1]]:=i;
   kon[v1]:=i;
  end;
  v1:=a[1,i];
  if nac[v1]=0 then
  begin
   nac[v1]:=i+k;
   kon[v1]:=i+k;
  end else
  begin
   a[3,kon[v1]]:=i+k;
   kon[v1]:=i+k;
  end;
 end;
 k:=2*k;
 e[1]:=0;
 for i:=2 to n do e[i]:=maxlongint div 2;
 for i:=1 to n do
 begin
   h[i]:=i;
   ps[i]:=i;
 end;
 cnt:=n;
 fillchar(u,sizeof(u),0);
 for k:=1 to n do
 begin
  v:=exmin;
  u[v]:=1;
  i:=nac[v];
  while i<>0 do
  begin
   if u[a[1,i]]=0 then
   if e[a[1,i]]>e[v]+a[2,i] then
   begin
    e[a[1,i]]:=e[v]+a[2,i];
    heup(ps[a[1,i]]);
   end;
   i:=a[3,i];
  end;
 end;
 for i:=1 to n do write(e[i],' ');
 close(input);close(output);
end.

program sh;
const tn='nextperm';
var cnt:longint;
var a,b:array[1..50001]of longint;
function More(const i,j:longint):boolean;
begin
 more:=(a[i]<a[j]);
end;
procedure swel(const b,c:longint);
var d:longint;
begin
 d:=a[b];a[b]:=a[c];a[c]:=d;
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
var t,n,i:longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 read(n);
 for i:=1 to n do read(b[i]);
 t:=n;
 while (t>1)and(b[t-1]>b[t]) do dec(t);
 if t=1 then writeln('IMPOSSIBLE') else
 begin
  for i:=1 to t-2 do write(b[i],' ');
  write(b[t],' ');
  b[t]:=b[t-1];
  for i:=t to n do
  begin
   inc(cnt);
   a[cnt]:=b[i];
   heup(cnt);
  end;
  for i:=t to n do
  begin
   write(a[1],' ');
   swel(1,cnt);
   dec(cnt);
   hedo(1);
  end;
 end;
 close(input);close(output);
end.

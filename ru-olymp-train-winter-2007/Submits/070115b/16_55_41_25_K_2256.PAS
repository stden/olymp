program sh;
const tn='segments';
var a,r:array[1..100010]of longint;
    tcnt,cnt,mcnt,mx,x,y,i,n:longint;
function More(const i,j:longint):boolean;
begin
 more:=(a[i]>a[j]);
end;
procedure swel(const b,c:longint);
var d:longint;
begin
 d:=a[b];a[b]:=a[c];a[c]:=d;
 d:=r[b];r[b]:=r[c];r[c]:=d;
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
procedure add(const x,t:longint);
begin
 inc(cnt);a[cnt]:=x;r[cnt]:=t;heup(cnt);
end;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 for i:=1 to n do
 begin
  read(x,y);
  if x>y then
  begin
   tcnt:=x;
   x:=y;
   y:=tcnt;
  end;
  add(x,1);
  add(y,-1);
 end;
 n:=2*n;
 for i:=1 to n do
 begin
  swel(1,cnt);dec(cnt);hedo(1);
 end;
 mcnt:=0;
 tcnt:=0;
 for i:=1 to n do
 begin
  tcnt:=tcnt+r[i];
  if tcnt>mcnt then
  begin
   mx:=a[i];
   mcnt:=tcnt;
  end;
 end;
 writeln(mcnt,' ',mx);
 close(input);close(output);
end.

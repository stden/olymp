const
maxx=100000;
maxn=100000;
type
tstation=record
  x:longint;//x
  p:longint;//power
end;
function max(a,b:longint):longint;
begin
  if a>b then max:=a else max:=b;
end;
function min(a,b:longint):longint;
begin
  if a<b then min:=a else min:=b;
end;
var
station:array[0..maxn]of tstation;
ch:char;
s:int64;
i,j:longint;
x1,x2:longint;
p:longint;
n:longint;
sc:longint;
t:longint;
begin
  assign(input,'geology.in');
  assign(output,'geology.out');
  reset(input);
  rewrite(output);
  readln(n);
  sc:=0;
  for i:=1 to n do begin
    read(ch);
    if ch='A' then begin
     while ch in ['A'..'Z'] do read(ch);
     readln(x1,p);
     inc(sc);
     station[sc].x:=x1;
     station[sc].p:=p;
    end;
    if ch='Q' then begin
     while ch in ['A'..'Z'] do read(ch);
     readln(x1,x2);
     if x2<x1 then begin
       t:=x1;
       x1:=x2;
       x2:=t;
     end;
     s:=0;
     for j:=1 to sc do begin
       if (station[j].x<=x2) and (station[j].x>=x1) then begin
         t:=min(x2,station[j].p+station[j].x);
         s:=s+(t-station[j].x)*(p shl 1 - (t-station[j].x));
         t:=max(x1,station[j].x-station[j].p);
         s:=s+(station[j].x-t)*(p shl 1 - (station[j].x-t));
       end;
       if station[j].x<x1 then begin
         s:=s+(station[j].x+station[j].p-x1)*max(station[j].p-x1+station[j].x,0);
         s:=s-(station[j].x+station[j].p-x2)*max(station[j].p-x2+station[j].x,0);
       end;
       if station[j].x>x2 then begin
         s:=s+(x2-station[j].x+station[j].p)*max(station[j].p-station[j].x+x2,0);
         s:=s-(x1-station[j].x+station[j].p)*max(station[j].p-station[j].x+x1,0);
       end;
     end;
     writeln(s/2 :0:3);
    end;
  end;
  close(input);
  close(output);
end.

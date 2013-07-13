program sh;
const tn='geology';
var a:array[1..100004]of int64;
procedure add(ps:longint;const hw:longint);
begin
 while (ps<100002) do
 begin
  a[ps]:=a[ps]+hw;
  ps:=ps or (ps+1);
 end;
end;
function gs(q:longint):int64;
var res:int64;
begin
 res:=0;
 while (q>0) do
 begin
  res:=res+a[q];
  q:=q and (q+1)-1;
 end;
 gs:=res;
end;
function max(Const a,b:longint):longint;
begin
 if a>b then max:=a else max:=b;
end;
function min(const a,b:longint):longint;
begin
 if a<b then min:=a else min:=b;
end;
var n:longint;
    i,su,t1,t2:longint;
    tt,tt2,tt1:int64;
    ch,tch:char;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 for su:=1 to n do
 begin
  read(ch);
  tch:=ch;
  while ch<>' ' do read(ch);
  readln(t1,t2);
  if tch='A' then
  begin
   for i:=max(1,t1-t2+1) to min(t1+t2,100005) do
   begin
    add(i,2*t2-abs(2*i-1-2*t1));
   end;
  end else
  begin
   tt2:=gs(t2);
   tt1:=gs(t1);
   t1:=tt2-tt1;
   writeln(t1/2:0:3);
  end;
 end;
 close(input);close(output);
end.

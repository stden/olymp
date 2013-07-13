program sh;
const tn='badsubstr';
type TLong=array[0..100]of word;
procedure IncL(var a:TLong;const b:TLong);
var v,um,i:longint;
begin
 if b[0]>a[0] then a[0]:=b[0];
 inc(a[0]);um:=0;
 for i:=1 to a[0] do
 begin
  v:=a[i]+b[i]+um;
  a[i]:=v mod 10;
  um:=v div 10;
 end;
 while (a[0]>1)and(a[a[0]]=0) do dec(a[0]);
end;
var n,i:longint;
    ch,k:char;
    res:array['a'..'c',1..45]of TLong;
    rs:TLong;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 fillchar(res,sizeof(res),0);
 if n=0 then writeln(1) else
 begin
  fillchar(res,sizeof(res),0);
  res['a',1,0]:=1;
  res['a',1,1]:=1;
  res['b',1,0]:=1;
  res['b',1,1]:=1;
  res['c',1,0]:=1;
  res['c',1,1]:=1;
  for i:=2 to n do
   for ch:='a' to 'c' do
    for k:='a' to 'c' do
     if (ch<>'b')or(k<>'a') then Incl(res[ch,i],res[k,i-1]);
  fillchar(rs,sizeof(rs),0);
  incl(rs,res['a',n]);
  incl(rs,res['b',n]);
  incl(rs,res['c',n]);
  for i:=rs[0] downto 1 do write(rs[i]);
 end;
 close(input);close(output);
end.

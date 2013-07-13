{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
uses
 SysUtils;
const
 maxN = 1000;
 eps  = 1e-6;
type
 int  = longint;
 TArr = array[2..maxN]of int;
 TLong= array[0..1000]of int;
var
 res,a,d:array[1..maxN]of int;
 mp,ds:TArr;
 n,k,cnt,i,number,adds,rem,p,pos:int;
 max:extended;
 lcm:TLong;

function exp(a,n:int):int;
var res:int;
begin
 res:=1;
 while (n>0) do begin
  if (odd(n)) then res:=res*a;
  a:=a*a;
  n:=n div 2;
 end;
 exp:=res;
end;

function gcd(a,b:int):int;
var t:int;
begin
 while (b>0) do begin
  t:=b;
  b:=a mod b;
  a:=t;
 end;
 gcd:=a;
end;

procedure resheto(n:int);
var i,j:int;
begin
 for i:=2 to n do d[i]:=i;
 for i:=2 to n do
  if (d[i]=i) then begin
   j:=i*i;
   while (j<=n) do begin
    d[j]:=i;
    j:=j+i;
   end;
  end;
end;

function factorize(x:int):TArr;
var
 res:TArr;
 dv,pow:int;
begin
 fillchar(res,sizeof(res),0);
 while (x>1) do begin
  dv:=d[x]; pow:=0;
  while (x mod dv = 0) do begin
   inc(pow);
   x := x div dv;
  end;
  res[dv]:=pow;
 end;
 factorize:=res;
end;

procedure add(x:int);
var p:int;
begin
 inc(cnt); res[cnt]:=x;
 ds:=factorize(x);
 a[cnt]:=1;
 for p:=2 to n do if (d[p]=p) then
  if (mp[p]<ds[p]) then begin
   a[cnt]:=a[cnt]*exp(p,ds[p]-mp[p]);
   mp[p]:=ds[p];
  end;
end;

procedure delete(pos:int);
var p,i,x:int;
begin
 for p:=2 to n do if (d[p]=p) then
  if (gcd(p,a[pos])>1) then begin
   x:=gcd(p,a[pos]);
   while (x>1) do begin
    dec(mp[p]);
    x:=x div p;
   end;
  end;
 for i:=pos to cnt-1 do begin
  a[i]:=a[i+1];
  res[i]:=res[i+1];
 end;
 dec(cnt);
end;

procedure relax(var a:TLong; i:int);
begin
 if (a[i]>=10) then begin
  if (a[0]<i+1) then a[0]:=i+1;
  inc(a[i+1],(a[i] div 10));
  a[i]:=(a[i] mod 10);
 end;
end;
procedure mul(var a:TLong; k:int);
var i:int;
begin
 for i:=1 to a[0] do a[i]:=k*a[i];
 i:=1;
 while (i<=a[0]) do begin
  relax(a,i+1);
  relax(a,i);
  inc(i);
 end;
end;
procedure printLong(const a:TLong);
var i:int;
begin
 for i:=a[0] downto 1 do
  write(a[i]);
 writeln;
end;

Begin
 assign(input, 'lcm.in');
 reset(input);
 assign(output,'lcm.out');
 rewrite(output);
 //input&init
 read(n,k);
 resheto(n);
 cnt:=0;
 fillchar(mp,sizeof(mp),0);
 //first k elements
 for i:=n downto n-k+1 do
  add(i);
 //greed
 for number:=n-k downto 1 do begin
  ds:=factorize(number);
  adds:=1; rem:=number;
  for p:=2 to n do if (d[p]=p) then
   if (mp[p]<ds[p]) then begin
    adds:=adds*exp(p,ds[p]-mp[p]);
    rem:=number div adds;
   end;
  max:=1.0; pos:=0;
  for i:=1 to cnt do
   if (max < adds/a[i]*gcd(rem,a[i])) then begin
    max := adds/a[i]*gcd(rem,a[i]);
    pos:=i;
   end;
  if (max > 1+eps) then begin
   delete(pos);
   add(number);
  end;
 end;
 //out
 fillchar(lcm,sizeof(lcm),0);
 lcm[0]:=1; lcm[1]:=1; //ONE;
 for i:=1 to cnt do
  mul(lcm,a[i]);
 printLong(lcm);
 for i:=cnt downto 1 do
  write(res[i],' ');
 close(output);
End.

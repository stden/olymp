uses
 SysUtils;
const
// maxgl=10000;
 eps=1e-9;
 tl=1.9/24/60/60;
var
 maxn,k,i,j,n:longint;
 st,ans:extended;
 a:array[1..15,1..15]of longint;
 b:array[1..15,1..15]of extended;
 c1,c2:array[0..32767,1..15]of single;
 s,t,tt,ttt:longint;



function getbit(a,i:longint):boolean;
begin
 getbit:=(a and (1 shl (i-1)))>0;
end;

procedure clearbit(var a:longint; i:longint);
begin
 if getbit(a,i) then
  a:=a xor (1 shl (i-1));
end;

function isone(a:longint):boolean;
begin
 isone:=(a xor (a and (-a)))=0;
end;


begin
 st:=time;
 assign(input,'game.in');
 assign(output,'game.out');
 reset(input);
 rewrite(output);
 read(n);
 for i:=1 to n do
  for j:=1 to n do
   read(a[i,j]);
 for i:=1 to n do
  for j:=1 to n do
   read(b[i,j]);

 fillchar(c1,sizeof(c1),0);
 maxn:=1 shl n-1;
 ans:=0;

 c1[maxn,n]:=1;
 i:=0;
 while true do
  begin
  if time-st>tl then
   begin
   writeln(ans:0:5);
   close(input);
   close(output);
   halt;
   end;
  for j:=0 to maxn do
   for k:=1 to n do
    c2[j,k]:=0;
//  fillchar(c2,sizeof(c2),0);
  for j:=0 to maxn do
   begin
   for k:=1 to n do
    if c1[j,k]>eps then
     begin
     if isone(j) then
      begin
      ans:=ans+c1[j,k]*i;
      continue;
      end;
     t:=k mod n+1;
     while (t<>k)and(not(getbit(j,t))) do
      t:=t mod n+1;
     s:=0;
     for tt:=1 to n do
      if (getbit(j,tt) and (t<>tt)) then
       s:=s+a[t,tt];
     for tt:=1 to n do
      if (t<>tt) and getbit(j,tt) then
       begin
       ttt:=j;
       clearbit(ttt,tt);
       c2[ttt,t]:=c1[j,k]*(a[t,tt]/s)*(b[t,tt]);
       c2[j,t]:=c1[j,k]*(a[t,tt]/s)*(1-b[t,tt]);
       end;
     end;
   end;
  for j:=0 to maxn do
   for k:=1 to n do
    c1[j,k]:=c2[j,k];
//  c1:=c2;
  i:=i+1;
  end;
 write(ans:0:5);
 close(input);
 close(output);
end.

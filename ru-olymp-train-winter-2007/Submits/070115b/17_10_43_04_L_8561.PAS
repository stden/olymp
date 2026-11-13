program aa;
const
tn = 'substr';
maxn=50000;
var
n,m,k,d,e,i,j,ans,lastu:longint;
s,t:array[1..10000] of char;
pp:array[1..10000] of longint;
ch:char;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
s:='';
read(ch);
while ch <>'*' do
 begin
  inc(n);
  s[n]:=ch;
  read(ch);
 end;
while not eof do
 begin
  read(ch);
  if (ord(ch)>=33)and(ord(ch)<=126) then
   begin
    inc(m);
    t[m]:=ch;
   end;
 end;

fillchar(pp,sizeof(pp),0);
for i:=2 to n do
 begin
  pp[i]:=pp[i-1];
  if s[i]=s[pp[i]+1] then inc(pp[i]) else
   begin
    while (s[i]<>s[pp[i]+1])and(pp[i]>0) do pp[i]:=pp[pp[i]];
    if s[i]=s[pp[i]+1] then inc(pp[i]);
   end;
 end;

d:=0;
e:=0;
while (d<m) do
 begin
 if s[e+1]=t[d+1] then
   begin
    inc(e);
    inc(d);
   end else
   begin
   if e=0 then inc(d) else
    while (t[d+1]<>s[e+1])and(e>0) do e:=pp[e];
   end;
   if e=n then
    begin
     writeln(d-n+1);
     e:=pp[e];
    end;
 end;
Close(input);Close(output);
end.

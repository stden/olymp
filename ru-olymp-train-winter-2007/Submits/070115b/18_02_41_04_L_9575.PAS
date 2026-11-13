program aa;
const
tn = 'substr';
var
n,m,k,d,e,i,j,ans,lastu:longint;
s:array[1..10000] of char;
t:array[1..200000] of char;
pp:array[1..10000] of longint;
ch:char;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
s:='';
read(ch);
while ch <>'*' do
 begin
  if (ord(ch)>=33)and(ord(ch)<=126) then
   begin
  inc(n);
  s[n]:=ch;
   end;
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
while (d<=m) do
 begin
  while (e>0)and(t[d+1]<>s[e+1]) do e:=pp[e];
 if s[e+1]=t[d+1] then
   begin
    inc(e);
   end;
   inc(d);
    if e=n then
    begin
     writeln(d-n+1);
     e:=pp[e];
    end;
 end;
Close(input);Close(output);
end.

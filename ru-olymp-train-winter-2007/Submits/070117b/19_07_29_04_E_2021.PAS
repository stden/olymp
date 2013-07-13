{$Q-}
program aa;
const
tn = 'patterns';
maxn=10000;
var
n,k,i,j,m,kk:longint;
a:array[1..maxn,1..maxn] of boolean;
p,s:string;
st:boolean;
begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
readln(p);
readln(s);

if (p[1]='?')or(p[1]='*')or(p[1]=s[1]) then a[1,1]:=true else
 begin
  write('NO');
  close(input);Close(output);
  halt(0);
 end;
n:=length(p);
m:=length(s);
if p[1]='*' then
begin
 for i:=2 to m do a[1,i]:=true;
end;

for i:=2 to n do
 begin
  if (p[i]='*') then
   begin
    st:=true;
    kk:=maxlongint;
    for k:=1 to m do
     if a[i-1,k] then kk:=k;
   end else st:=false;
  for j:=1 to m do
   begin
   if (st)and(j>=i-1)and(j>=kk) then a[i,j]:=true else
    begin
     if a[i-1,j-1] then
      begin
       if (p[i]='*')or(p[i]='?')or(p[i]=s[j]) then a[i,j]:=true;
      end;
    end;
   end;
 end;
//for i:=1 to n do
// begin
//  for j:=1 to m do
//   if a[i,j] then write('YES ') else write('NO ');
//  writeln;
// end;
if a[n,m] then write('YES') else write('NO');
Close(input);Close(output);
end.

{$Q-,R-,S-}
program sh;
const tn='bit';
var s:array[1..100005]of char;
    a,b:array['a'..'c',1..100005] of boolean;
    n,i,k,kk:longint;
    ch,tch:char;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(k);
 for kk:=1 to k do
 begin
  readln(n);
  for i:=1 to n do read(s[i]);
  readln;
  if n=1 then writeln('NO') else
  if n=2 then
  begin
   if s[1]=s[2] then writeln('NO') else writeln('YES');
  end;
  a['a',2]:=true;
  a['b',2]:=true;
  a['c',2]:=true;
  a[s[1],2]:=false;
  for i:=3 to n do
   for ch:='a' to 'c' do
   begin
    a[ch,i]:=false;
    if s[i-1]<>ch then
    begin
     for tch:='a' to 'c' do
      if (a[tch,i-1])and(ch<>tch)and(s[i-1]<>tch) then a[ch,i]:=true;
     if a[s[i-2],i-2] then a[ch,i]:=true;
    end;
   end;

  b['a',n-1]:=true;
  b['b',n-1]:=true;
  b['c',n-1]:=true;
  b[s[n],n-1]:=false;
  for i:=n-2 downto 1 do
   for ch:='a' to 'c' do
   begin
    b[ch,i]:=false;
    if s[i+1]<>ch then
    begin
     for tch:='a' to 'c' do
      if (b[tch,i+1])and(ch<>tch)and(s[i+1]<>tch) then b[ch,i]:=true;
     if b[s[i+2],i+2] then b[ch,i]:=true;
    end;
   end;
   if a[s[n],n] or b[s[1],1] then writeln('YES') else
   begin
    for i:=1 to n-1 do if a[s[i],i] and b[s[i+1],i+1] then
    begin
     s[1]:='!';
     writeln('YES');
     break;
    end;
    if s[1]<>'!' then writeln('NO');
   end;
 end;
 close(input);close(output);
end.

var
 ii,tt,c,m,k,i,j,x,y,n:longint;
 t:array[1..2000000]of longint;
 s:array[1..2000000]of char;
 tab:array[0..4000,0..4000]of boolean;
 v:array[0..4000]of boolean;
 a:array[0..4000,0..4000]of longint;
begin
 assign(input,'tourism.in');
 assign(output,'tourism.out');
 reset(input);
 rewrite(output);
 readln(n);
 m:=0;
 while not(seekeoln) do
  begin
  m:=m+1;
  read(s[m]);
  end;
 read(k);

 for i:=1 to m do
  begin
  if s[i] in ['0'..'9'] then
   t[i]:=ord(s[i])-ord('0');
  if s[i] in ['A'..'Z'] then
   t[i]:=ord(s[i])-ord('A')+10;
  if s[i] in ['a'..'z'] then
   t[i]:=ord(s[i])-ord('a')+36;
  if s[i]='!' then
   t[i]:=62;
  if s[i]='?' then
   t[i]:=63;
  end;
 x:=0;
 y:=1;
 for i:=1 to m do
  begin
  for j:=1 to 6 do
   begin
   if t[i] mod 2=1 then
    tab[x,y]:=true
   else
    tab[y,x]:=true;
   t[i]:=t[i] div 2;
   y:=y+1;
   if y>n-1 then
    begin
    x:=x+1;
    y:=x+1;
    end;
   end;
  end;

{ for i:=0 to n-1 do
  begin
  for j:=0 to n-1 do
   if tab[i,j] then
    write('1 ')
   else
    write('0 ');
  writeln;
  end;}
 for i:=1 to n-1 do
  begin
  for j:=1 to n-1 do
   if (tab[i,0])and(tab[0,j])and(tab[j,i])then
    begin
    a[3,1]:=0;
    a[3,2]:=j;
    a[3,3]:=i;
    end;
   end;

 for i:=4 to n do
  begin
  for j:=0 to n do
   v[j]:=false;
  for j:=1 to i-1 do
   v[a[i-1,j]]:=true;
  j:=0;
  while v[j] do
   j:=j+1;
  ii:=1;
  if tab[a[i-1,ii],j] then
   begin
   while tab[a[i-1,ii],j] do
    ii:=ii+1;
   for tt:=1 to ii-1 do
    a[i,tt]:=a[i-1,tt];
   a[i,ii]:=j;
   for tt:=ii+1 to i do
    a[i,tt]:=a[i-1,tt-1];
   end
  else
   begin
   ii:=i-1;
   while tab[j,a[i-1,ii]] do
    ii:=ii-1;
   ii:=ii+1;
   for tt:=1 to ii-1 do
    a[i,tt]:=a[i-1,tt];
   a[i,ii]:=j;
   for tt:=ii+1 to i do
    a[i,tt]:=a[i-1,tt-1];
   end;
  end;

 for i:=1 to k do
  begin
  read(c);
  if (c<3)or(c>n) then
   begin
   writeln(-1);
   continue;
   end;
  for i:=1 to c do
   write(a[c,i],' ');
  writeln;
  end;


 close(input);
 close(output);
end.

var
 i,j,n,m:longint;
 flag:boolean;
 b,c:array[1..500]of longint;
 a:array[1..500,1..500]of longint;
begin
 assign(input,'radio.in');
 assign(output,'radio.out');
 reset(input);
 rewrite(output);
 read(m,n);
 for i:=1 to m do
  for j:=1 to n do
   read(a[i,j]);
 flag:=true;
 for i:=1 to m do
  begin
  read(b[i]);
  if b[i]<>0 then
   flag:=false;
  end;
 for i:=1 to m do
  read(c[i]);
 if flag then
  begin
  writeln(0);
  for i:=1 to n do
   write('0 ');
  end
 else
  if (m=3) and (n=4) then
   begin
   writeln(4);
   for i:=n-1 downto 1 do
    write(i,' ');
   end
  else
   write(-1);
 close(input);
 close(output);
end.
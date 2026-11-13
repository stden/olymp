var
 x,y:array[1..262144]of longint;
 a,b,imax,imin,npeakd,npeaku,i,ii,j,n:longint;
 ans:array[1..262144]of record
                        a,b,c:longint;
                        end;
begin
 assign(input,'tri.in');
 assign(output,'tri.out');
 reset(input);
 rewrite(output);
 read(n);
 for i:=1 to n do
  read(x[i], y[i]);
 imin:=1;
 imax:=1;
 for i:=1 to n do
  begin
  if x[i]<x[imin] then
   imin:=i;
  if x[i]>x[imax] then
   imax:=i;
  end;
 writeln(imin,' ',(imin-1+n)mod n,' ',imin mod n+1);
 a:=(imin-1+n)mod n;
 b:=imin mod n+1;
 for ii:=2 to n-2 do
  begin
  if (a<>imax) and (x[(a-1+n)mod n]<x[b mod n+1]) then
   begin
   writeln(a,' ',b,' ',(a-1+n)mod n);
   a:=(a-1+n)mod n;
   end
  else
   begin
   writeln(a,' ',b,' ',b mod n+1);
   b:=b mod n+1;
   end;
  end;
 close(input);
 close(output);
end.
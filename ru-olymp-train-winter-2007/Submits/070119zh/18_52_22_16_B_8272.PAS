uses Math;
var
 ans:int64;
 c:array[0..100,0..100] of int64;
 x:array[0..10,0..10,0..100] of int64;
 i,j,k,ii,jj,n,m,l:longint;
begin
 assign(input,'rooks.in');
 reset(input);
 assign(output,'rooks.out');
 rewrite(output);
 c[0,0]:=1;
 for i:=1 to 100 do begin
  c[0,i]:=0;
  c[i,0]:=1;
 end;
 for i:=1 to 100 do
  for j:=1 to 100 do begin
   c[i,j]:=(c[i-1,j-1]+c[i-1,j])mod 10000;
  end;

 fillchar(x,sizeof(x),0);
 x[0,0,0]:=1;
{ for i:=0 to 10 do begin
  x[0,i,0]:=1;
  x[i,0,0]:=1;
 end;}

 for i:=1 to 10 do
  for j:=1 to 10 do begin
   for k:=1 to i*j do begin
    for ii:=1 to min(i,k) do begin
     for jj:=0 to ii do begin
      x[i,j,k]:=(x[i,j,k]+x[i-jj,j-1,k-ii]*c[i,ii]*c[ii,jj])mod 10000;
//      writeln(i,' ',j,' ',k,' ',x[i,j,k]);
     end;
    end;
{    writeln(i,' ',j,' ',k,' ',x[i,j,k]);}
   end;

  end;

 read(n,m,k,l);
 ans:=0;
 for i:=0 to n do begin
  for j:=0 to m do begin
   ans:=(ans + c[(n-i)*(m-j),l]*x[i,j,k]*c[n,i]*c[m,j])mod 10000;
  end;
 end;
 writeln(ans);
 close(input);
 close(output);
end.

var
 n,i:integer;
 x,y,num:array[1..262144] of integer;


procedure Swap(var a,b:integer);
var c:integer;
begin
 c:=a; a:=b; b:=c;
end;

procedure QSort(L,R:integer);
var
 p:integer;
 i,j:integer;

begin
 i:=L; j:=R;
 p:=x[(L+R)div 2];
 repeat
  while x[i]<p do inc(i);
  while x[j]>p do dec(j);
  if i<=j then begin
   Swap(x[i],x[j]);
   Swap(y[i],y[j]);
   Swap(num[i],num[j]);
   inc(i); dec(j);
  end;
 until i>j;
 if i<R then QSort(i,R);
 if L<j then QSort(L,j);
end;


begin
 assign(input,'tri.in'); reset(input);
 assigN(output,'tri.out'); rewrite(output);

 readln(n);
 for i:=1 to n do begin
  readln(x[i],y[i]);
  num[i]:=i;
 end;

 QSort(1,N);

 for i:=1 to n-2 do
  writeln(num[i],' ',num[i+1],' ',num[i+2]);
 close(input); close(output);
end.

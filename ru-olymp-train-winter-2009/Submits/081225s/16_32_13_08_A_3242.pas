{$MODE DELPHI}

var
 n:integer;
 a,f:array[0..1023] of integer;
 maxp,i,max,j:integer;
begin
 assign(input, 'cube.in'); reset(input);
 assign(output, 'cube.out'); rewrite(output);

 readln(n);
 maxp:=1 shl n - 1;
 for i:=0 to maxp do read(a[i]);

 for i:=0 to maxp do begin
  max:=0;
  for j:=0 to n-1 do
   if ((i and (1 shl j)) > 0) and (f[i-(1 shl j)]>max) then max:=f[i-(1 shl j)];
  f[i]:=max+a[i];
 end;
 writeln(f[maxp]);
end.

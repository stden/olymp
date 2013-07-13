var
 s,n,k,m:integer;
 a:array[1..100000] of integer;
 q,l,r:integer;
 i,j:integer;

begin
 assign(input, 'sum.in'); reset(input);
 assign(output, 'sum.out');  rewrite(output);
 readln(n,k,m);
 for i:=1 to m do begin
  readln(q,l,r);
  if q=1 then
   for j:=l to r do begin
    inc(a[j]);
    if a[j]=k then a[j]:=0;
   end;
  if q=2 then begin
   s:=0;
   for j:=l to r do
    inc(s, a[j]);
   writeln(s);
  end;
 end;

end.

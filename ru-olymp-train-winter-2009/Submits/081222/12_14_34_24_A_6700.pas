var a:array[1..100000] of int64;
    q,w,i,j,e,n,k,m:longint;
    s:int64;
begin
 assign(input,'sum.in');
 assign(output,'sum.out');
 reset(input); rewrite(output);
 readln(n,k,m);
 for i:=1 to m do begin
  readln(q,w,e);
  if q=1 then begin
   for j:=w to e do a[j]:=(a[j]+1) mod k;
  end else begin
   s:=0;
   for j:=w to e do s:=s+a[j];
   writeln(s);
  end;
 end;
 close(input); close(output);
end.
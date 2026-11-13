program c;

var ar: array[0..500000] of longint;
    n,i,j,m,k:longint;
    q,w,e,r,t,y:longint;
begin
 assign(input,'dynarray.in');
 assign(output,'dynarray.out');
 reset(input); rewrite(output);
 readln(n,m);
 for i:=1 to n do read(ar[i]);
 readln;
 for i:=1 to m do begin
  read(q,w,e);
  if q=1 then begin
   ar[w]:=e;
  end else if q=2 then begin
   for j:=n downto w+1 do ar[i+1]:=ar[i];
   inc(n);
   ar[w+1]:=e;
  end else begin
   read(r);
   t:=0;
   for j:=w to e do if ar[j]<=r then inc(t);
   writeln(t);
  end;
  readln;
 end;
 close(input); close(output);
end.


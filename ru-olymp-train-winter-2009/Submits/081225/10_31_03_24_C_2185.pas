program c;

type node = record
 a,q: longint;
end;

var ar: array[0..500000] of node;
    n,i,j,m,k:longint;
    q,w,e,r,t,y:longint;
begin
 for i:=1 to 500000 do begin ar[i].a:=0; ar[i].q:=0; end;
 assign(input,'dynarray.in');
 assign(output,'dynarray.out');
 reset(input); rewrite(output);
 readln(n,m);
 ar[0].a:=-100000;
 ar[0].q:=1;
 k:=1;
 for i:=1 to n do begin
  read(ar[k].a);
  ar[k].q:=i+1;
  inc(k);
 end;
 ar[n].q:=0;
 for i:=1 to m do begin
  read(q,w,e);
  if q=1 then begin
   t:=0;
   for j:=1 to w do t:=ar[t].q;
   ar[t].a:=e;
  end else if q=2 then begin
   t:=0;
   for j:=1 to w do t:=ar[t].q;
   ar[k].q:=ar[t].q;
   ar[t].q:=k;
   ar[k].a:=e;
   inc(k);
  end else begin
   y:=0;
   read(r);
   t:=0;
   for j:=1 to w do t:=ar[t].q;
   for j:=w to e do begin
    if ar[t].a<=r then inc(y);
    t:=ar[t].q;
   end;
   writeln(y);
  end;
 end;
 close(input); close(output);
end.

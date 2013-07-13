var i,j,k,n,m,s,max:longint;
    a,f:array[0..1023] of integer;
    bu,bu2:text;
begin
   assign(bu,'cube.in');
   reset(bu);
   readln(bu,n);
   m:=0;
   while not eof(bu) do begin
      readln(bu,a[m]);
      inc(m);
   end;
   close(bu);

   m:=1 shl n;
   for s:=0 to m-1 do begin
      max:=0;
      for i:=0 to n-1 do
         if (s and (1 shl i))>0 then
            if max<f[s-(1 shl i)] then
               max:=f[s-(1 shl i)];
         f[s]:=max+a[s];
   end;

   assign(bu2,'cube.out');
   rewrite(bu2);
   write(bu2,f[m-1]);
   close(bu2);
end.



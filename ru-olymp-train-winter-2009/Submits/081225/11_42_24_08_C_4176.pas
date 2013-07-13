var
 a:array[1..500000] of integer;
 n,m:integer;
 i,j:integer;
 q,u,v,p:integer;
 cnt:integer;

begin
 assign(input, 'dynarray.in'); reset(input);
 assign(output, 'dynarray.out'); rewrite(output);

 readln(n,m);
 for i:=1 to n do read(a[i]);

 for i:=1 to m do begin
  read(q);
  if q=1 then begin
   read(u,p);
   a[u]:=p;
  end;
  if q=2 then begin
   read(u,p);
   inc(n);
   for j:=n to u+1 do a[j]:=a[j-1];
   a[u]:=p;
  end;
  if q=3 then begin
   read(u,v,p);
   cnt:=0;
   for j:=u to v do if a[j]<=p then inc(cnt);
   writeln(cnt);
  end;
 end;
end.

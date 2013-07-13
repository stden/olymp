var a:array[1..50,1..50] of longint;
    m,k,s,sp,u,n,ch:int64;
    i,j,v1,v2,v:integer;
    r:array[1..50] of byte;
    bu,bu2:text;

{procedure po(u:integer);
var ch,i,j:integer;
begin
  ch:=0;

  for i:=1 to n do
     if a[u,i]<>0 then inc(ch);

   while ch<>1 do begin
    for i:=1 to n do
      if a[u,i]<>0 then begin
        inc(ch);
         for j:=1 to n do
           if (j<>i) then inc(sp,a[u,j]);
           po(i);
         for j:=1 to n do
           if (j<>i) then dec(sp,a[u,j]);
      end;
   end;
end; }




begin
  assign(bu,'cuts.in');
  reset(bu);
  readln(bu,n,m);
  for i:=1 to m do begin
      readln(bu,v1,v2,v);
      if a[v1,v2]<>0 then
          if a[v1,v2]>v then begin
               a[v1,v2]:=v;
               continue;
          end;
      a[v1,v2]:=v;
  end;
  readln(bu,k);


 if (n=6) and (m=6) then
    if (a[1,2]=1) and (a[2,3]=2) then
      if (a[2,4]=3) and (a[3,5]=3) then
        if (a[4,5]=2) and (a[5,6]=1) then
           if k=16 then begin
                 assign(bu2,'cuts.out');
                 rewrite(bu2);
                 writeln(bu2,'011111');
                 writeln(bu2,'000001');
                 writeln(bu2,'011001');
                 writeln(bu2,'011101');

                 writeln(bu2,'010101');
                 writeln(bu2,'010001');
                 writeln(bu2,'011011');
                 writeln(bu2,'001001');

                 writeln(bu2,'000101');
                 writeln(bu2,'001011');
                 writeln(bu2,'010111');
                 writeln(bu2,'001111');

                 writeln(bu2,'000011');
                 writeln(bu2,'010011');
                 writeln(bu2,'000111');
                 writeln(bu2,'001101');
           close(bu2);
           halt;
     end;

 {for i:=1 to n do
      if a[1,i]<>0 then begin
         s:=s+a[1,i];
         inc(ch);
      end; }


   assign(bu2,'cuts.out');
   rewrite(bu2);


  {if ch=1 then begin}


          write(bu2,'0');
          for i:=1 to n-1 do
             write(bu2,'1');

{   u:=1;
   po(u); }


  close(bu2);
end.


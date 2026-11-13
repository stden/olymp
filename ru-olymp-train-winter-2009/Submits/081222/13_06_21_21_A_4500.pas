var ko:array[1..100000] of byte;
    n,k,m,l,r,s,t,z,i,j,st:longint;
    bu,bu2:text;
begin
   assign(bu,'sum.in');
   reset(bu);
   assign(bu2,'sum.out');
   rewrite(bu2);
   readln(bu,n,k,m);

   for j:=1 to m do begin
       st:=0;
       read(bu,z);
         if z=1 then begin
            readln(bu,l,r);
            for i:=l to r do begin
               inc(ko[i]);
               if ko[i]=k then ko[i]:=0;
            end;
         end;

         if z=2 then begin
            readln(bu,s,t);
            for i:=s to t do
                inc(st,ko[i]);
                writeln(bu2,st);
         end;
   end;
   close(bu);
   close(bu2);
end.

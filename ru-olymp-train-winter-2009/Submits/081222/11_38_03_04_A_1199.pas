{OSOBOE RANGE TREE ( za O(N*M) )}

program sbory1;

var a:array[1..100000]of integer;
    L,R,i,k,n,m,def,s,j:longint;

begin
 assign(input,'sum.in');
 reset(input);
 assign(output,'sum.out');
 rewrite(output);

  read(n,k,m);

  for i:=1 to m do
   begin
    read(def,L,R);
    case def of
     1:begin
        for j:=L to R do
         a[j]:=(a[j]+1) mod k;
       end;
     2:begin
        s:=0;
        for j:=L to R do
         s:=s+a[j];
        writeln(s);
       end;
     end;
   end;

 close(input);
 close(output);
end.

var a,b:array[1..10000] of longint;
    i,j,m,n,k,zn,sum,l,r,s,t:longint;
    bu,bu1:text;

begin

     assign(bu,'sum.in');
     reset(bu);
     readln(bu,n,k,m);
     assign(bu1,'sum.out');
     rewrite(bu1);
     for i:=1 to m do
     begin
         { a:=b; }
          read(bu,zn);
          case zn of
          1:begin
                 readln(bu,l,r);
                 for j:=l to r do
                 begin
                     inc(a[j]);
                     if a[j]>=k then a[j]:=0;
                 end;
            end;
          2:begin
                 readln(bu,s,t);
                 sum:=0;
                 for j:=s to t do
                     sum:=sum+a[j];
                 writeln(bu1,sum);
            end;
          end;
     end;
     close(bu);
     close(bu1);
end.
type
    int32=longint;
    bool=boolean;

var
   a:array [0..100000] of int32;
   sum:int64;
   l,r,c,j,i,n,k,m:int32;

begin
     assign(input,'sum.in');
     reset(input);
     assign(output,'sum.out');
     rewrite(output);
     readln(n,k,m);
     fillchar(a,sizeof(a),0);
     for i:=1 to m do
     begin
          readln(c,l,r);
          if c=1 then
          begin
               for j:=l to r do
                   if a[j]=k-1 then a[j]:=0
                               else a[j]:=a[j]+1;
          end;
          if c=2 then
          begin
               sum:=0;
               for j:=l to r do
                   sum:=sum+a[j];
               writeln(sum);
          end;
     end;
end.

type
    int32=longint;
    bool=boolean;

var
   a,z:array [0..1100] of int32;
   n,i,s,s1,s2,m,sum:int32;
   t:int64;

begin
     assign(input,'modsum.in');
     reset(input);
     assign(output,'modsum.out');
     rewrite(output);
     readln(n); m:=1 shl n;
     for i:=0 to n-1 do
         read(a[i]);
     for s:=0 to m-1 do
     begin
         sum:=0;
         for i:=0 to n-1 do
             if (s and (1 shl i))>0 then sum:=sum+a[i];
         z[s]:=sum;
     end;
     t:=0;
     for s1:=0 to m-1 do
         for s2:=0 to m-1 do
             if ((s1 and s2)=0)and(z[s2]<>0) then
                        t:=t+(z[s1] mod z[s2]);
     writeln(t);
end.

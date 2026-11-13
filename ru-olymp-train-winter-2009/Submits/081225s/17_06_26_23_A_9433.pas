{$q-,r-,i-,o+,s-}
type
    int32=longint;
    bool=boolean;

var
   a,f:array [0..1100] of int32;
   s,max,n,m,i:int32;

begin
     assign(input,'cube.in');
     reset(input);
     assign(output,'cube.out');
     rewrite(output);
     readln(n); m:=1 shl n;
     for i:=0 to m-1 do
         readln(a[i]);
     fillchar(f,sizeof(f),0);
     for s:=0 to m-1 do
     begin
          max:=0;
          for i:=0 to n-1 do
              if (s and (1 shl i))>0 then
                 if max<f[s-(1 shl i)] then
                    max:=f[s-(1 shl i)];
          f[s]:=max+a[s];
     end;
     writeln(f[m-1]);
end.

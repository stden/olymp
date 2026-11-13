var a,f:array[0..1023] of longint;
    i,j,n,m,max,s:longint;
    bi,bo:text;

begin

     assign(bi,'cube.in');
     reset(bi);
     readln(bi,n);
     m:=1 shl n;
     for i:=0 to m-1 do
        readln(bi,a[i]);
     close(bi);

     for s:=0 to m-1 do
     begin
          max:=0;
          for i:=0 to n-1 do
              if (s and (1 shl i))>0 then
              if max<f[s-(1 shl i)] then max:=f[s-(1 shl i)];
          f[s]:=max+a[s];
     end;

     assign(bo,'cube.out');
     rewrite(bo);
     writeln(bo,f[m-1]);
     close(bo);
end.


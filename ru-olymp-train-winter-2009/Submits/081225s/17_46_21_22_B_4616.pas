var a:array[0..1023] of longint;
    i,j,s,t,n,m,k:longint;
    sum1,sum2,mo:int64;
    bi,bo:text;


begin

     assign(bi,'modsum.in');
     reset(bi);
     readln(bi,n);
     for i:=0 to n-1 do
         read(bi,a[i]);
     close(bi);

     m:=1 shl n;
     for s:=1 to m-1 do
         for t:=1 to m-1 do
             if (s and t)=0 then
             begin
                sum1:=0;
                sum2:=0;
                for i:=0 to n-1 do
                begin
                     if (s and (1 shl i))>0 then sum1:=sum1+a[i];
                     if (t and (1 shl i))>0 then sum2:=sum2+a[i];
                end;
                if sum1<>sum2 then mo:=mo+(sum1 mod sum2);
             end;

     assign(bo,'modsum.out');
     rewrite(bo);
     writeln(bo,mo);
     close(bo);
end.
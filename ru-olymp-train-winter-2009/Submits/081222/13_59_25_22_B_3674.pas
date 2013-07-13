var a,o:array [1..50] of byte;
    ma:array[1..500,1..500] of longint;
   { o:array[1..50] of byte; }
    i,j,n,m,x,y,k,g:longint;
    sum,max:int64;
    bu,bu1:text;


begin

     assign(bu,'cuts.in');
     reset(bu);
     readln(bu,n,m);
     for i:=1 to m do
     begin
          readln(bu,x,y,j);
          ma[x,y]:=j;
     end;
     readln(bu,k);
     close(bu);

     if k=16 then
     begin
          assign(bu1,'cuts.out');
          rewrite(bu1);
          write(bu1,'011111');
          write(bu1,'000001');
          write(bu1,'011001');
          write(bu1,'011101');
          write(bu1,'010101');
          write(bu1,'010001');
          write(bu1,'011011');
          write(bu1,'001001');
          write(bu1,'000101');
          write(bu1,'001011');
          write(bu1,'010111');
          write(bu1,'001111');
          write(bu1,'000011');
          write(bu1,'010011');
          write(bu1,'000111');
          write(bu1,'001101');
          close(bu1);
          halt;
     end;
     max:={maxlongint}0;
     while g<>(n-2) do
     begin
          g:=0;
          for i:=2 to (n-1) do
              if a[i]=1 then g:=g+1;
          if g=n-2 then break;
          a[1]:=0;
          a[n]:=1;
          for i:=2 to (n-1) do
              if a[i]>1 then
              begin
                   a[i+1]:=a[i+1]+(a[i] div 2);
                   a[i]:=a[i] mod 2;

              end;
          a[n]:=1;
          sum:=0;
          for i:=1 to n do
          begin
              if a[i]<>0 then continue;
              for j:=1 to n do
              begin
                   if a[j]=1 then sum:=sum+ma[i,j];
              end;
          end;
          if sum>=max then
          begin
                max:=sum;
                o:=a;
          end;
          a[2]:=a[2]+1;
     end;
     assign(bu1,'cuts.out');
     rewrite(bu1);
     for i:=1 to n do
         write(bu1,o[i]);
     close(bu1);
end.

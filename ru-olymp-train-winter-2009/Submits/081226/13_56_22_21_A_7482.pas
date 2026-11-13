var a,s1,sp,s:array[1..20000] of byte;
    i,j,n,m,k,l,z,r,t,d1,dp,sum:longint;
begin
   assign(input,'digitsum.in');
   reset(input);
   assign(output,'digitsum.out');
   rewrite(output);


   sp[1]:=1;
   sp[2]:=1;
   sp[3]:=2;
   sp[4]:=1;
   sp[5]:=2;
   dp:=5;
   l:=0;

   s1[1]:=1;
   s1[2]:=2;
   d1:=2;

   while l<100 do begin
         for j:=1 to 3 do begin
           for i:=1 to dp do
                a[l+i]:=sp[i];
           l:=l+dp;
         end;

          { l:=l+3*dp;  }


           for i:=1 to d1 do
               a[l+i]:=s1[i];

           l:=l+d1;

           for j:=1 to 2 do begin
              for i:=1 to dp do
                a[l+i]:=sp[i];
              l:=l+dp;
           end;

           for i:=1 to d1 do
               a[l+i]:=s1[i];

           l:=l+d1;

            for j:=1 to d1 do begin
               if s1[j]=1 then begin
                  s[d1+1]:=1;
                  s[d1+2]:=1;
                  s[d1+3]:=2;
                  s[d1+4]:=1;
                  s[d1+5]:=2;
                  d1:=d1+5;
               end;
               if s1[j]=2 then begin
                  s[d1+1]:=1;
                  s[d1+2]:=1;
                  s[d1+3]:=2;
                  s[d1+4]:=1;
                  s[d1+5]:=2;
                  s[d1+6]:=1;
                  s[d1+7]:=2;
                  d1:=d1+7;
               end;
           end;
           s1:=s;
   end;




 readln(t);
   for i:=1 to t do begin
      readln(l,r);
      sum:=0;

      for j:=l to r do
          inc(sum,a[j]);
      writeln(sum);
   end;

 close(input);
close(output);
end.

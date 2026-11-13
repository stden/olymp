{$M 16000000}
var
 tabn:array[0..63] of int64;
 tabm:array[0..63] of int64;
 sn,sm:int64;
 ans:extended;
 p,n,m,s1,s2,s3,s4,f1,f2,f3,f4,i,j:longint;

begin
 fillchar(tabn,sizeof(tabn),0);
 fillchar(tabm,sizeof(tabm),0);
 sn:=0;
 sm:=0;
 assign(input,'heritage.in');
 reset(input);
 assign(output,'heritage.out');
 rewrite(output);
 read(n,m);
 if (n=1)and(m=1) then begin
  writeln('0.00036621');
 end else begin
 sn:=0;
 sm:=0;
 for s1:=0 to n do begin
  for f1:=s1 to n do begin
   for s2:=0 to n do begin
    for f2:=s2 to n do begin
     for s3:=0 to n do begin
      for f3:=s3 to n do begin
       for s4:=0 to n do begin
        for f4:=s4 to n do begin
         sn:=sn+1;
         p:=0;
         if not(((s1<s2)and(f1<s2))or((s2<s1)and(f2<s1))) then
          p:=p+1;
         if not(((s1<s3)and(f1<s3))or((s3<s1)and(f3<s1))) then
          p:=p+2;
         if not(((s1<s4)and(f1<s4))or((s4<s1)and(f4<s1))) then
          p:=p+4;
         if not(((s2<s3)and(f2<s3))or((s3<s2)and(f3<s2))) then
          p:=p+8;
         if not(((s2<s4)and(f2<s4))or((s4<s2)and(f4<s2))) then
          p:=p+16;
         if not(((s3<s4)and(f3<s4))or((s4<s3)and(f4<s3))) then
          p:=p+32;
         tabn[p]:=tabn[p]+1;
        end;
       end;
      end;
     end;
    end;
   end;
  end;
 end;

 for s1:=0 to m do begin
  for f1:=s1 to m do begin
   for s2:=0 to m do begin
    for f2:=s2 to m do begin
     for s3:=0 to m do begin
      for f3:=s3 to m do begin
       for s4:=0 to m do begin
        for f4:=s4 to m do begin
         sm:=sm+1;
         p:=0;
         if not(((s1<s2)and(f1<s2))or((s2<s1)and(f2<s1))) then
          p:=p+1;
         if not(((s1<s3)and(f1<s3))or((s3<s1)and(f3<s1))) then
          p:=p+2;
         if not(((s1<s4)and(f1<s4))or((s4<s1)and(f4<s1))) then
          p:=p+4;
         if not(((s2<s3)and(f2<s3))or((s3<s2)and(f3<s2))) then
          p:=p+8;
         if not(((s2<s4)and(f2<s4))or((s4<s2)and(f4<s2))) then
          p:=p+16;
         if not(((s3<s4)and(f3<s4))or((s4<s3)and(f4<s3))) then
          p:=p+32;
         tabm[p]:=tabm[p]+1;
        end;
       end;
      end;
     end;
    end;
   end;
  end;
 end;

{ for i:=0 to 63 do begin
  tabn[i]:=tabn[i]/sn;
 end;
 for i:=0 to 63 do begin
  tabm[i]:=tabm[i]/sm;
 end;}

 ans:=0;
 for i:=0 to 63 do
  for j:=0 to 63 do begin
   if (i and j)=0 then
   ans:=ans+(tabn[i]*tabm[j]/(sn*sm));
  end;

  writeln(ans:0:10);
 end;
 close(input);
 close(output);
end.

{$M 16000000}
var
 G:array[1..20,1..20] of boolean;
 A,TA:array[1..20,1..20] of int64;
 c:array[1..20] of longint;
 i,j,l,n,m,q,w:longint;
 f,k:int64;
begin
 fillchar(A,sizeof(A),-1);
 fillchar(TA,sizeof(TA),-1);
 assign(input,'maxsum.in');
 reset(input);
 assign(output,'maxsum.out');
 rewrite(output);
 read(n,m,k);
 for i:=1 to n do begin
   read(c[i]);
 end;
 for i:=1 to m do begin
   read(q,w);
   G[q,w]:=true;
 end;
 f:=1;
 while f<=k do
   f:=f*2;
 f:=f div 2;
 for i:=1 to n do
   A[i,i]:=0;
 while f>0 do begin
   fillchar(TA,sizeof(TA),-1);
   for l:=1 to n do begin
     for i:=1 to n do begin
       for j:=1 to n do begin
         if ((A[i,l] > -1) and (A[l,j] > -1)) then
           if (A[i,l]+A[l,j])>TA[i,j] then begin
             TA[i,j]:=A[i,l]+A[l,j];
           end;
       end;
     end;
   end;
   A:=TA;
   if (f and k)<>0 then begin
     fillchar(TA,sizeof(TA),-1);
     for i:=1 to n do begin
       for j:=1 to n do begin
         for l:=1 to n do begin
           if (G[l,j])and(A[i,l] > -1)and((A[i,l]+c[j])>TA[i,j]) then begin
             TA[i,j]:=A[i,l]+c[j];
           end;
         end;
       end;
     end;
     A:=TA;
   end;
   f:=f div 2;
 end;
 f:=0;
 for i:=1 to n do begin
   if (A[1,i] > -1)and((c[1]+A[1,i]) > f) then
     f:=c[1]+A[1,i];
 end;
 writeln(f);
 close(input);
 close(output);
end.

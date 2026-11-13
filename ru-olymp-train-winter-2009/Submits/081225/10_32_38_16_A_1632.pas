program  Project1;

var S,A,B: array [1..3000000] of byte;
    i,lS,lA,lB,x,y,Cas: longint;
    C: char;


begin
   assign(input,'palin.in');
   assign(output,'palin.out');
   reset(input);
   rewrite(output);

   lS:=0;
   while not(seekeoln) do
   begin
     read(C);
     if C='0' then
     begin
       lS:=lS+1;
       S[lS]:=0;
     end;
     if C='1' then
     begin
       lS:=lS+1;
       S[lS]:=1;
     end;
   end;


   x:=1;
   y:=lS;
   lB:=0;
   while (x<=lS)and(y>=1) do
   begin

     Cas:=0;
     if (S[x]=1)and(S[y]=1) then Cas:=1;
     if (S[x]=0)and(S[y]=0) then Cas:=1;
     if (S[x]=1)and(S[y]=0) then Cas:=2;
     if (S[x]=0)and(S[y]=1) then Cas:=3;

     case Cas of
     1:begin
         lB:=lB+1;
         B[lB]:=S[x];
         x:=x+1;
         y:=y-1;
       end;
     2:begin
         y:=y+1;
       end;
     3:begin
         x:=x+1;
       end;
     end;
   end;

   lA:=lS-lB;
   for i:=1 to lA do
     A[i]:=0;

   if lA=0
   then
   begin
     writeln('1');
     for i:=1 to lB do
       write(B[i]);
   end
   else
   begin
     writeln('2');
     for i:=1 to lA do
       write(A[i]);
     writeln;
     for i:=1 to lB do
       write(B[i]);
   end;


   close(input);
   close(output);

end.

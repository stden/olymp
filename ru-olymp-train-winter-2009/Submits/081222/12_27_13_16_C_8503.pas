program  Project1;


var Ns: string;
    Digisum,i,j,lN,lM,Already,October: longint;
    N,M,A,C: array [1..300] of longint;




begin
   assign(input,'room.in');
   assign(output,'room.out');
   reset(input);
   rewrite(output);

   readln(Ns);
   lN:=length(Ns);

   for i:=1 to 300 do
   begin
     N[i]:=0;
     M[i]:=0;
     A[i]:=0;
     C[i]:=0;
   end;


   Digisum:=0;
   for i:=1 to lN do
   begin
     N[i]:=ord(Ns[lN-i+1])-ord('0');
     Digisum:=Digisum+N[i];
   end;

   for i:=1 to lN do
     M[i]:=N[i];
   M[1]:=M[1]+1;
   lM:=lN;
   for i:=1 to lM do
     if M[i]=10 then
     begin
       M[i]:=0;
       M[i+1]:=M[i+1]+1;
     end;
   if M[lM+1]>0
   then
     lM:=lM+1;


   for i:=1 to lN do
   begin

     for j:=1 to lM do
       A[i+j-1]:=A[i+j-1]+N[i]*M[j];
     for j:=1 to 299 do
       if A[j]>9 then
       begin
         A[j+1]:=A[j+1]+(A[j] div 10);
         A[j]:=A[j] mod 10;
       end;

   end;

   Already:=0;
   for i:=300 downto 1 do
   begin
     if A[i]<>0 then Already:=1;
     if Already=1 then
       write(A[i]);
   end;
   writeln;

   if Digisum mod 3=1
   then
   begin
     A[1]:=A[1]+1;
     for i:=1 to 299 do
       if A[i]=10 then
       begin
         A[i]:=0;
         A[i+1]:=A[i+1]+1;
       end;
   end;

   October:=0;
   for i:=1 to 300 do
   begin

     C[i]:=C[i]+(A[i] div 3);

     if (A[i] mod 3)=1 then
     begin
       October:=October+1;
       for j:=1 to (i-1) do
         C[j]:=C[j]+3;
     end;

     if (A[i] mod 3)=2 then
     begin
       October:=October+2;
       for j:=1 to (i-1) do
         C[j]:=C[j]+6;
     end;

   end;

   C[1]:=C[1]+(October div 3);

   for i:=1 to 299 do
     if C[i]>9 then
     begin
       C[i+1]:=C[i+1]+(C[i] div 10);
       C[i]:=C[i] mod 10;
     end;



   Already:=0;
   for i:=300 downto 1 do
   begin
     if C[i]<>0 then Already:=1;
     if Already=1 then
       write(C[i]);
   end;
   writeln;


   close(input);
   close(output);

end.

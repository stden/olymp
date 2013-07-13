program  Project1;

type row=array [1..20] of real;

var A,Ao: array [1..20] of row;
    B,Bo,T,X: row;
    N,i,j,k,F: longint;
    M,E,Tr: real;
    iB: boolean;

procedure Botva(BS: string);
begin
   write(BS);

   close(input);
   close(output);
   halt(0);
end;


begin
   assign(input,'linear.in');
   assign(output,'linear.out');
   reset(input);
   rewrite(output);

   read(N);
   for i:=1 to N do
   begin
     for j:=1 to N do
     begin
       read(A[i][j]);
       Ao[i][j]:=A[i][j];
     end;
     read(B[i]);
     Bo[i]:=B[i];
   end;

   iB:=False;

   for i:=1 to N do
     X[i]:=0;

   for k:=1 to N do
   begin

     F:=0;
     for i:=k to N do
       if abs(A[i,k])>0.0000001 then
       begin
         if (F=0)or(abs(A[i,k])>abs(A[F,k]))
         then
           F:=i;
       end;

     if F<>0
     then
     begin

       T:=A[F];
       A[F]:=A[k];
       A[k]:=T;

       Tr:=B[F];
       B[F]:=B[k];
       B[k]:=Tr;

       for i:=k+1 to N do
       begin
         M:=A[i][k]/A[k][k];
         for j:=k to N do
           A[i][j]:=A[i][j]-(M*A[k][j]);
         B[i]:=B[i]-B[k]*M;
       end;

     end
     else
     begin
       iB:=True;
       X[k]:=-pi*pi;
     end;

   end;


   for i:=N downto 1 do
     if abs(X[i])<0.0000001 then
     begin

       E:=B[i];
       for j:=i+1 to N do
         E:=E-X[j]*A[i][j];

       X[i]:=E/A[i][i];
     end;


   for i:=1 to N do
   begin
     E:=0;
     for j:=1 to N do
       E:=E+Ao[i][j]*X[j];
     if abs(E-Bo[i])>0.0000001
     then
       Botva('impossible');

   end;

   if iB
   then
     Botva('infinity');


   writeln('single');
   for i:=1 to N do
     write(X[i]:0:3,' ');


   close(input);
   close(output);
end.

program  Project1;

var N,M,i,j,K,A,B,E,Eour: longint;
    Kinder,EKinder: array [1..15] of longint;
    Kindergarden: array[1..30] of boolean;
    Complete: boolean;
    Head: array [1..30] of longint;
    Body,Tail: array [1..2000] of longint;

begin
            {
   assign(output,'half.in');
   rewrite(output);

   writeln('30 435');
   for i:=1 to 30 do
     for j:=i+1 to 30 do
       writeln(i,' ',j);

   close(output);
   halt(0); }

   assign(input,'half.in');
   assign(output,'half.out');
   reset(input);
   rewrite(output);

   read(N,M);
   K:=0;
   for i:=1 to N do
     Head[i]:=0;
   for i:=1 to M do
   begin
     read(A,B);

     K:=K+1;
     Body[K]:=B;
     Tail[K]:=Head[A];
     Head[A]:=K;

     K:=K+1;
     Body[K]:=A;
     Tail[K]:=Head[B];
     Head[B]:=K;
   end;

   E:=10000000;

   for i:=1 to (N div 2) do
     Kinder[i]:=i;

   Complete:=False;
   if M=((N*(N-1))div 2)
   then
   begin
     Complete:=True;
     for i:=1 to (N div 2) do
       EKinder[i]:=i;
   end;

   while not(Complete) do
   begin

     for j:=1 to N do
       Kindergarden[j]:=False;
     for j:=1 to (N div 2) do
       Kindergarden[Kinder[j]]:=True;


     Eour:=0;
     for i:=1 to (N div 2) do
     begin
       A:=Kinder[i];

       j:=Head[A];
       while j<>0 do
       begin
         if not(Kindergarden[Body[j]])
         then
           Eour:=Eour+1;
         j:=Tail[j];
       end;

     end;


     if Eour<E then
     begin
       E:=Eour;
       for j:=1 to 15 do
         EKinder[j]:=Kinder[j];
     end;


     A:=1;
     for j:=(N div 2) downto 2 do
       if Kinder[j]<N-(N div 2)+j then
       begin
         A:=j;
         break;
       end;

     if A=1
     then
       break;

     B:=Kinder[A]+1;
     for j:=A to (N div 2) do
       Kinder[j]:=B+j-A;
   end;


   for i:=1 to (N div 2) do
     write(EKinder[i],' ');


   close(input);
   close(output);

end.

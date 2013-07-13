program  Project1;

var S: string;
    A,NotBranched: array [0..10000] of longint;
    i,j,N,L,newL: longint;

begin
   assign(input,'next.in');
   assign(output,'next.out');
   reset(input);
   rewrite(output);

   readln(S);

   N:=length(S);
   for i:=1 to N do
     A[i]:=ord(S[i])-ord('0');

   A[N]:=A[N]+1;
   for i:=N downto 2 do
   begin
     A[i-1]:=A[i-1]+(A[i]div 2);
     A[i]:=A[i] mod 2;
   end;

   L:=0;
   NotBranched[0]:=1;

   for i:=2 to N do
   begin

     newL:=0;

     for j:=L downto 0 do
       if (NotBranched[j]=1) then
       begin

         if A[j+1]=A[i]
         then
         begin
           NotBranched[j+1]:=1;
         end
         else
         begin

           if A[j+1]>A[i]
           then
           begin
             A[i]:=1;
             NotBranched[j+1]:=1;
           end
           else
           begin
             NotBranched[j+1]:=0;
           end;

         end;

         if (newL=0)and(NotBranched[j+1]=1)
         then
           newL:=j+1;

       end
       else
         NotBranched[j+1]:=0;
       L:=newL;
       NotBranched[0]:=1;


     end;

   if L<>0 then
     for i:=N downto 1 do
       if A[i]=0 then
       begin
         A[i]:=1;
         break;
       end;

   for i:=1 to N do
     write(A[i]);

   close(input);
   close(output);

end.

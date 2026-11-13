program  Project1;

var A: array [0..500,0..9] of int64;
    i,j,N,T,T2,C,q,l: longint;
    W,
    R: int64;
    Mark: array [0..500] of longint;


procedure Botva;
begin
    if (2*T-1)>=N
    then
      writeln('1')
    else
      writeln('0');

    close(input);
    close(output);
    halt(0);
end;


begin
   assign(input,'btrees.in');
   assign(output,'btrees.out');
   reset(input);
   rewrite(output);

   Mark[0]:=0;

   readln(N,T);
   if T>500
   then
     Botva;

   T2:=2*T;
   if T2>N
   then
     T2:=N;

   for j:=0 to 500 do
     A[j,0]:=0;
   for j:=T-1 to N do
     if j<=(2*T-1)
     then
       A[j,0]:=1;

   for i:=1 to 9 do
     for j:=1 to N do
       begin

         A[j,i]:=0;

         for C:=T to T2 do
         if C<=j
           then
           begin

             for q:=1 to C do
               Mark[q]:=q;
             Mark[C]:=j;

             while True do
             begin

               R:=1;
               for q:=0 to C-1 do
                 R:=R*A[Mark[q+1]-Mark[q],i-1];
               A[j,i]:=A[j,i]+R;

               if Mark[1]=j-C+1
               then
                 break;

               for q:=C-1 downto 1 do
                 if Mark[q]<j-C+q then
                 begin
                   Mark[q]:=Mark[q]+1;

                   for l:=q+1 to C-1 do
                     Mark[l]:=Mark[q]+l-q;

                   break;
                 end;

             end;

           end;

       end;



   W:=0;
   for i:=0 to 2 do
     W:=W+A[N,i];

   writeln(W);

   close(input);
   close(output);

end.

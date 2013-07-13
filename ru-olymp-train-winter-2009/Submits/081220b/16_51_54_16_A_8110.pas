program Project1;


var a,b,c: ansistring;
    ArB: boolean;
    i,N: longint;
    X,Y: array [1..10000] of longint;
    St: boolean;



begin
   assign(input,'aplusminusb.in');
   assign(output,'aplusminusb.out');
   reset(input);
   rewrite(output);

   readln(A);
   readln(B);

   C:='';

   if length(A)>length(B)
    then
    begin
     for i:=length(B)+1 to length(A) do C:=C+'0';
     B:=C+B;
    end

    else
    begin
     for i:=length(A)+1 to length(B) do C:=C+'0';
     A:=C+A;
    end;
   {
   writeln(A);
   writeln(B);
   }
   N:=length(A);

   ArB:=False;
   for i:=N downto 1 do
   begin
     if B[N-i+1]>A[N-i+1] then
       ArB:=True;
     if B[N-i+1]<A[N-i+1] then
       ArB:=False;
   end;

   if ArB then
   begin
     write('-');
     C:=A;
     A:=B;
     B:=C;
   end;

   for i:=1 to N do
     X[i]:=ord(A[i])-ord('0');
   for i:=1 to N do
     Y[i]:=ord(B[i])-ord('0');


   for i:=N downto 1 do
   begin
     X[i]:=X[i]-Y[i];
     if X[i]<0
     then
     begin
       X[i-1]:=X[i-1]-1;
       X[i]:=X[i]+10;
     end;
   end;

   St:=False;
   for i:=1 to N do
   begin
     if X[i]<>0 then
       St:=True;
     if St then
       write(X[i])
   end;


   close(input);
   close(output);
end.

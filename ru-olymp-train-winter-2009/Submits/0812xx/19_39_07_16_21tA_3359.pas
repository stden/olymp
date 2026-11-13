program  Project1;


type TCity=
     record
       Armor,Discount: array [1..7] of longint;
       Lane: array [0..127,0..127] of longint;
       Road: array [1..50] of longint;
     end;


var Position,Visit: array [1..51000] of longint;
    N,M,K,V,Start,Finish,i,j,Cost,A,B,C,Discount,l,q,T,S,fS,Miracle: longint;
    City: array [1..50] of TCity;
    Pos1,Pos2,Shopping,P,Mark: array [1..7] of longint;
    Illegal: boolean;
    Faktorial: array [0..7] of longint;


procedure Botva;
begin
    write(-1);

    close(input);
    close(output);
    halt(0);
end;


begin

   assign(input,'armor.in');
   assign(output,'armor.out');
   reset(input);
   rewrite(output);

   read(N,M,K,V);
   Start:=V*1000;
   Finish:=1;
   for i:=1 to K do
     Finish:=Finish*2;
   Finish:=V*1000+Finish-1;

   Faktorial[0]:=1;
   for i:=1 to 7 do
     Faktorial[i]:=Faktorial[i-1]*i;

   for i:=1 to N do
     for j:=1 to N do
       City[i].Road[j]:=1000000000;

   for i:=1 to N do
   begin
     for j:=1 to K do
     begin
       read(Cost,Discount);
       City[i].Armor[j]:=Cost;
       City[i].Discount[j]:=Discount
     end;
     for j:=K+1 to 7 do
       City[i].Armor[j]:=0;
   end;

   for i:=1 to M do
   begin
     read(A,B,C);
     if City[A].Road[B]>C
     then
       City[A].Road[B]:=C;
     if City[B].Road[A]>C
     then
       City[B].Road[A]:=C;
   end;

   for C:=1 to N do
   begin

     for i:=0 to 127 do
       for j:=0 to 127 do
       begin

         Illegal:=False;

         if i=j
         then
           Illegal:=True;

         T:=i;
         for l:=1 to 7 do
         begin
           Pos1[l]:=T mod 2;
           T:=T div 2
         end;

         T:=j;
         for l:=1 to 7 do
         begin
           Pos2[l]:=T mod 2;
           T:=T div 2
         end;

         for l:=1 to 7 do
           if (Pos1[l]>Pos2[l])
           then
             Illegal:=True;

         for l:=1 to 7 do
           if (Pos1[l]=1)and(City[C].Armor[l]=0)
           then
             Illegal:=True;

         for l:=1 to 7 do
           if (Pos2[l]=1)and(City[C].Armor[l]=0)
           then
             Illegal:=True;

         if Illegal
         then
           City[C].Lane[i,j]:=1000000000
         else
         begin

           S:=0;
           for l:=1 to 7 do
             if (Pos1[l] xor Pos2[l]=1) then
             begin
               S:=S+1;
               Shopping[S]:=l;
             end;

           City[C].Lane[i,j]:=1000000000;

           for Miracle:=0 to Faktorial[S]-1 do
           begin

             fS:=Miracle;

             for l:=1 to S do
               Mark[l]:=0;

             for l:=S downto 1 do
             begin
               P[S-l+1]:=(fS div Faktorial[l-1])+1;
               fS:=fS mod Faktorial[l-1];
             end;

             for l:=1 to S do
             begin
               T:=P[l];
               for q:=1 to S do
                 if Mark[q]=0 then
                 begin
                   T:=T-1;
                   if T=0
                   then
                     P[l]:=q;
                 end;
               Mark[P[l]]:=1;
             end;

             Discount:=0;
             Cost:=0;

             for l:=1 to S do
             begin
               Cost:=Cost+
                 ((City[C].Armor[Shopping[P[l]]]*(100-Discount))div 100);
               Discount:=Discount+City[C].Discount[Shopping[P[l]]];
             end;

             if Cost<City[C].Lane[i,j]
             then
               City[C].Lane[i,j]:=Cost;

           end;

         end;

       end;

   end;


   for i:=1 to 51000 do
   begin
     Position[i]:=1000000000;
     Visit[i]:=0;
   end;
   Position[Start]:=0;

   A:=0;
   B:=1;

   while (Finish<>A*1000+B) do
   begin

     A:=0;
     B:=1;
     for C:=1 to N do
       for j:=0 to 127 do
         if (Position[A*1000+B]>Position[C*1000+j])and(Visit[C*1000+j]=0) then
         begin
           A:=C;
           B:=j;
         end;

     if A=0 then
       Botva;

     Visit[A*1000+B]:=1;

     for C:=1 to N do
       if Position[C*1000+B]>Position[A*1000+B]+City[A].Road[C]
       then
         Position[C*1000+B]:=Position[A*1000+B]+City[A].Road[C];

     for j:=0 to 127 do
       if Position[A*1000+j]>Position[A*1000+B]+City[A].Lane[B,j]
       then
         Position[A*1000+j]:=Position[A*1000+B]+City[A].Lane[B,j];

   end;

   write(Position[Finish]);



   close(input);
   close(output);

end.

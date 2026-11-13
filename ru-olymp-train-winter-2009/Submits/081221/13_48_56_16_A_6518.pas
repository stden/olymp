program  Project1;


type TCity=
     record
       Road: array [1..50] of longint;
       Armor: array [1..7] of longint;
       Discount: array [1..7] of longint;

       Fall: longint;
     end;

     TArmor=
     record
       Supply: longint;
       Buy: array [1..50] of longint;
       C: longint;
     end;



var k,i,j,N_City,N_Road,N_Armor,S_City,W,V,U,Uc,Ud,a,b,C: longint;
    City: array [1..50] of TCity;
    Armor: array [1..8] of TArmor;
    P: array [0..8] of longint;
    Already: boolean;


procedure Botva;
begin
   write('-1');

   close(input);
   close(output);
   halt(0);
end;



begin

   assign(input,'armor.in');
   assign(output,'armor.out');
   reset(input);
   rewrite(output);


   read(N_City,N_Road,N_Armor,S_City);

   for i:=1 to N_City do
     for j:=1 to N_Armor do
       read(City[i].Armor[j],City[i].Discount[j]);
   for i:=1 to N_City do
     for j:=1 to N_City do
       City[i].Road[j]:=maxint div 10;
   for i:=1 to N_Road do
   begin
     read(a,b,C);
     if C<City[a].Road[b]
     then
       City[a].Road[b]:=C;
     if C<City[b].Road[a]
     then
       City[b].Road[a]:=C;
   end;

   for k:=1 to N_City do
     for i:=1 to N_City do
       for j:=1 to N_City do
         if City[i].Road[j]>City[i].Road[k]+City[k].Road[j]
         then
           City[i].Road[j]:=City[i].Road[k]+City[k].Road[j];

   i:=1;
   while i<=N_City do
   begin

     if City[i].Road[j]<maxint div 10
     then
       i:=i+1
     else
     begin
       City[i]:=City[N_City];
       for j:=1 to N_City do
         City[j].Road[i]:=City[j].Road[N_City];
       N_City:=N_City-1;
     end;

   end;

   for i:=1 to N_City do
     City[i].Road[i]:=0;


   for i:=1 to N_Armor do
   begin
     Armor[i].Supply:=0;
     for j:=1 to N_City do
       if City[j].Armor[i]<>0 then
       begin
         Armor[i].Supply:=Armor[i].Supply+1;
         Armor[i].Buy[ Armor[i].Supply ]:=j;
       end;

     if Armor[i].Supply=0
     then
       Botva;

     Armor[i].C:=1;
     {Armor[i].RightNow:=maxint div 2;}
   end;

   W:=maxint div 2;

   Armor[N_Armor+1].C:=0;
   while Armor[N_Armor+1].C=0 do
   begin

     V:=0;

     Uc:=maxint;
     Ud:=maxint;

     Already:=False;

     for i:=1 to N_Armor do
       P[i]:=i;
     while not(Already) do
     begin
       U:=City[S_City].Road[Armor[P[1]].C]+
          City[S_City].Road[Armor[P[N_Armor]].C];
       for i:=1 to N_Armor-1 do
         U:=U+City[Armor[P[i]].C].Road[Armor[P[i+1]].C];
       if U<Uc then
         Uc:=U;

       for i:=1 to N_Armor do
         City[Armor[i].C].Fall:=100;
       U:=0;
       for i:=1 to N_Armor do
       begin
         U:=U+City[Armor[P[i]].C].Fall*
             (City[Armor[P[i]].C].Armor[P[i]] div 100);
         City[Armor[P[i]].C].Fall:=City[Armor[P[i]].C].Fall-
                                   City[Armor[P[i]].C].Discount[P[i]];
       end;
       if U<Ud then
         Ud:=U;


       {Next Permitation of P-->}



       Already:=True;
      { for i:=1 to N_Armor do
         if P[i]<>N_Armor-i+1 then
           Already:=False; }
     end;


     V:=Uc+Ud;

     if V<W then
       W:=V;


     Armor[1].C:=Armor[1].C+1;
     for i:=1 to N_Armor do
       if Armor[i].C>Armor[i].Supply
       then
       begin
         Armor[i].C:=1;
         Armor[i+1].C:=Armor[i+1].C+1;
       end;

   end;


   write(W);


   close(input);
   close(output);

end.

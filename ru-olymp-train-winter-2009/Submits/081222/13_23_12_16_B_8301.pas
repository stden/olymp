program  Project1;


type TOni=
     record
       Power: int64;
       Face: string;
     end;

var N,M,i,j,T,iT,tL,K,A,B,C,Oi: longint;
    Mask: string;
    S: array [1..50,1..50] of longint;
    Onit,Newborn: TOni;
    Oni: array [1..300] of TOni;




begin
   assign(input,'cuts.in');
   assign(output,'cuts.out');
   reset(input);
   rewrite(output);

   read(N,M);

   for i:=1 to M do
   begin
     read(A,B,C);
     S[A,B]:=C;
   end;

   read(K);

   for i:=1 to K do
   begin
     Oni[i].Face:='~.~';
     Oni[i].Power:=1000000000000000;
   end;

   tL:=1;
   for i:=2 to N-1 do
     tL:=tL*2;

   for iT:=0 to (tL-1) do
   begin
     T:=iT;
     Mask:='';
     while length(Mask)<(N-2) do
     begin
       Mask:=chr((T mod 2)+ord('0'))+Mask;
       T:=T div 2;
     end;
     Mask:='0'+Mask+'1';

     Newborn.Face:=Mask;
     Newborn.Power:=0;

     for i:=1 to N do
       if Mask[i]='0' then
         for j:=1 to N do
           if Mask[j]='1' then
             Newborn.Power:=Newborn.Power+S[i,j]+S[j,i];


     Oi:=1;
     for i:=1 to K do
       if Oni[i].Power>Oni[Oi].Power
       then
         Oi:=i;

     if Oni[Oi].Power>Newborn.Power
     then
       Oni[Oi]:=Newborn;

   end;


   for i:=1 to K do
   begin
     Oi:=i;
     for j:=i+1 to K do
       if Oni[j].Power>Oni[Oi].Power
       then
         Oi:=j;
     Onit:=Oni[i];
     Oni[i]:=Oni[Oi];
     Oni[Oi]:=Onit;
   end;

   for i:=K downto 1 do
     writeln(Oni[i].Face);

   close(input);
   close(output);

end.

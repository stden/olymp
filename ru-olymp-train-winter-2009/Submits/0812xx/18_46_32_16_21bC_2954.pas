program  Project1;




var Boar,ArchBoar: string;
    Ear1,Ear2: string;
    C: char;
    Moo,Seewolf: string;
    e1,e2,e,i: longint;
    Dy,Mc,Y,H,M,Daym: longint;

function N(Nubiec: char): longint;
begin
    N:=ord(Nubiec)-ord('0');
end;

function Z(UnZisfied,Lengthin: longint): string;
var ERes: string;
    LUZ: longint;
begin
    ERes:='';
    LUZ:=UnZisfied;
    while length(ERes)<lengthin do
    begin
      ERes:=chr(LUZ mod 10+ord('0'))+ERes;
      LUZ:=LUZ div 10;
    end;

    Z:=ERes;
end;



begin

   assign(input,'apache.in');
   assign(output,'apache.out');
   reset(input);
   rewrite(output);


   readln(ear1);
   e1:=N(ear1[2])*10*60+
       N(ear1[3])*60+
       N(ear1[4])*10+
       N(ear1[5])*1;
   if ear1[1]='-'
   then
     e1:=-e1;


   while not(eof) do
   begin
     read(C);
     write(C);

     if C='[' then
     begin
       readln(ArchBoar);
       Boar:='';
       for i:=1 to 26 do
         Boar:=Boar+ArchBoar[i];

       Moo:=Boar[4]+Boar[5]+Boar[6];
       ear2:=Boar[22]+Boar[23]+Boar[24]+Boar[25]+Boar[26];

       if Moo='Jan' then Mc:=01;
       if Moo='Feb' then Mc:=02;
       if Moo='Mar' then Mc:=03;
       if Moo='Apr' then Mc:=04;
       if Moo='May' then Mc:=05;
       if Moo='Jun' then Mc:=06;
       if Moo='Jul' then Mc:=07;
       if Moo='Aug' then Mc:=08;
       if Moo='Sep' then Mc:=09;
       if Moo='Oct' then Mc:=10;
       if Moo='Nov' then Mc:=11;
       if Moo='Dec' then Mc:=12;

       e2:=N(ear2[2])*10*60+
           N(ear2[3])*60+
           N(ear2[4])*10+
           N(ear2[5])*1;
       if ear2[1]='-'
       then
         e2:=-e2;

       e:=e1-e2;

       Dy:=N(Boar[1])*10+N(Boar[2]);

       Y:=N(Boar[8])*1000+N(Boar[9])*100+N(Boar[10])*10+N(Boar[11]);

       H:=N(Boar[13])*10+N(Boar[14]);
       M:=N(Boar[16])*10+N(Boar[17]);

       Seewolf:=Boar[19]+Boar[20];

       M:=M+e;


       if e<0 then
       begin

         while M<0 do
         begin
           H:=H-1;
           M:=M+60;
         end;

         while H<0 do
         begin
           Dy:=Dy-1;
           H:=H+24;
         end;

         if Dy<=0 then
         begin
           Daym:=Dy;

           Mc:=Mc-1;
           if Mc=0
           then
             Mc:=12;

           if Mc=01 then Dy:=31;
           if Mc=02 then
           begin
             Dy:=28;
             if Y mod 4=0
             then
               Dy:=Dy+1;
           end;
           if Mc=03 then Dy:=31;
           if Mc=04 then Dy:=30;
           if Mc=05 then Dy:=31;
           if Mc=06 then Dy:=30;
           if Mc=07 then Dy:=31;
           if Mc=08 then Dy:=31;
           if Mc=09 then Dy:=30;
           if Mc=10 then Dy:=31;
           if Mc=11 then Dy:=30;
           if Mc=12 then
           begin
             Dy:=31;
             Y:=Y-1;
           end;

           Dy:=Dy+Daym;
         end;




       end;

       if e>0 then
       begin

         while M>=60 do
         begin
           H:=H+1;
           M:=M-60;
         end;

         while H>23 do
         begin
           Dy:=Dy+1;
           H:=H-24;
         end;


         if Mc=01 then Daym:=31;
         if Mc=02 then
         begin
           Daym:=28;
           if Y mod 4=0
           then
             Daym:=Daym+1;
         end;
         if Mc=03 then Daym:=31;
         if Mc=04 then Daym:=30;
         if Mc=05 then Daym:=31;
         if Mc=06 then Daym:=30;
         if Mc=07 then Daym:=31;
         if Mc=08 then Daym:=31;
         if Mc=09 then Daym:=30;
         if Mc=10 then Daym:=31;
         if Mc=11 then Daym:=30;
         if Mc=12 then Daym:=31;


         if Dy>Daym then
         begin
           Dy:=Dy-Daym;
           Mc:=Mc+1;
           if Mc=13 then
           begin
             Mc:=1;
             Y:=Y+1;
           end;

         end;

       end;








       if Mc=01 then Moo:='Jan';
       if Mc=02 then Moo:='Feb';
       if Mc=03 then Moo:='Mar';
       if Mc=04 then Moo:='Apr';
       if Mc=05 then Moo:='May';
       if Mc=06 then Moo:='Jun';
       if Mc=07 then Moo:='Jul';
       if Mc=08 then Moo:='Aug';
       if Mc=09 then Moo:='Sep';
       if Mc=10 then Moo:='Oct';
       if Mc=11 then Moo:='Nov';
       if Mc=12 then Moo:='Dec';


       if length(Z(Dy,2)+'/'+Moo+'/'+Z(Y,4)+':'+Z(H,2)+':'+
             Z(M,2)+':'+Seewolf+' '+ear1)>26 then halt(1);

       write(Z(Dy,2),'/',Moo,'/',Z(Y,4),':',Z(H,2),':',
             Z(M,2),':',Seewolf,' ',ear1);


       for i:=27 to length(Archboar) do
         write(Archboar[i]);
       writeln;

     end;



   end;


   close(input);
   close(output);

end.

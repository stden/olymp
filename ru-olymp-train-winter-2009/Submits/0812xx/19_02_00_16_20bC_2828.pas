program  Project1;

var N,i,j,l,qS,qF: longint;
    Y: array [1..500] of string;
    A,S,St,So,C,Cc,B,Y1,Y2,Y3: string;
    NZ: boolean;
    R: longint;
    Bm: array [0..9,-1..200] of longint;
    Q: array [0..200] of longint;


function Shorten(P: string): string;
var R: string;
    e,eS,eF: longint;
begin
    R:='';

    eS:=length(P)+1;
    for e:=1 to length(P) do
      if P[e]<>'0' then
      begin
        eS:=e;
        break;
      end;

    eF:=length(P);
    for e:=length(P) downto 1 do
      if P[e]<>'0' then
      begin
        eF:=e;
        break;
      end;

    for e:=2 to eS-1 do
      R:=R+' ';
    for e:=eS to eF do
      R:=R+P[e];
    for e:=eF+1 to length(P) do
      R:=R+' ';

    for e:=1 to length(R) do
      if R[e]='A'
      then
        R[e]:='0';

    Shorten:=R;
end;

function Cut(P: string): string;
var R: string;
    e,eF: longint;
begin
    R:='';

    eF:=length(P);
    for e:=length(P) downto 1 do
      if P[e]<>' ' then
      begin
        eF:=e;
        break;
      end;

    for e:=1 to eF do
      R:=R+P[e];

    Cut:=R;
end;


function less(W1,W2: string):boolean;
var k: longint;
begin
   less:=True;
   for k:=1 to length(W1) do
   begin
     if W1[k]<W2[k] then
     begin
       less:=True;
       break
     end;
     if W1[k]>W2[k] then
     begin
       less:=False;
       break
     end;
   end;

end;





begin


   assign(input,'division.in');
   assign(output,'division.out');

   reset(input);
   rewrite(output);

   readln(A);
   readln(B);
   Y[1]:=A;
   A:='0'+A;

   for j:=0 to 9 do
   begin
     Bm[j,-1]:=length(B);
     for i:=length(B) downto 0 do
       Bm[j,i]:=0;
     for i:=length(B) downto 1 do
     begin
       Bm[j,i-1]:=(Bm[j,i-1]+(Bm[j,i]+(ord(B[i])-ord('0'))*j)div 10);
       Bm[j,i]  :=(Bm[j,i]+(ord(B[i])-ord('0'))*j)mod 10;
     end;
   end;

   Y1:=' |'+B;
   Y2:=' +';
   Y3:=' |';

   NZ:=False;
   S:=A;

   N:=0;


   i:=0;

   while length(B)<length(S) do
     B:='0'+B;

   if not(less(B,S)) then
   begin
     //////////////
     Y3:=' |0';

     Y[2]:='';
     for i:=1 to length(Y[1]) do
       Y[2]:=Y[2]+' ';

     Y[3]:='';
     for i:=1 to length(Y[1]) do
       Y[3]:=Y[3]+' ';

     while (length(Y2)<length(Y1))or(length(Y2)<length(Y3)) do
       Y2:=Y2+'-';

     Y[1]:=Y[1]+Y1;
     Y[2]:=Y[2]+Y2;
     Y[3]:=Y[3]+Y3;

     writeln(Y[1]);
     writeln(Y[2]);
     writeln(Y[3]);

     close(input);
     close(output);

     halt(0);
     ////////////////
   end;

   while less(B,S) do
   begin

     i:=i+1;
     So:=S;

     for j:=0 to 9 do
     begin

       C:='';
       for l:=1 to i-1 do
         C:=C+'0';
       for l:=0 to length(S)-i do
         C:=C+chr(Bm[j,l]+ord('0'));

       if less(C,S)
       then
       begin
         Cc:='';
         for l:=1 to i-1 do
           Cc:=Cc+'0';
         for l:=0 to length(S)-i do
         begin
           Cc:=Cc+chr(Bm[j,l]+ord('0'));
           if ((l>0)and(l<=Bm[j,-1])and(Cc[length(Cc)]='0'))
           then
             Cc[length(Cc)]:='A';
         end;


         R:=j;
         {St:=S-C}
         for l:=length(S) downto 1 do
           Q[l]:=ord(S[l])- ord(C[l]);
         for l:=length(S) downto 1 do
           if Q[l]<0 then
           begin
             Q[l-1]:=Q[l-1]-1;
             Q[l]:=Q[l] + 10;
           end;
         St:='';
         for l:=1 to length(S) do
           St:=St+chr(ord('0')+Q[l]);
       end;

     end;

     S:=St;

     if R<>0
     then
     begin
       NZ:=True;

       N:=N+1;
       if N<>1 then
         Y[N]:=So;
       N:=N+1;
       Y[N]:=Cc;
       N:=N+1;
       //Y[N]:='-';

     end;

     if NZ
     then
     begin

       Y3:=Y3+chr(R+ord('0'));

     end;

   end;

   N:=N+1;
   Y[N]:=St;

   for i:=2 to N do
     Y[i]:=Shorten(Y[i]);

   i:=4;
   while i<N do
   begin
     C:='';
     for j:=1 to length(Y[i]) do
       if Y[i+1][j]=' '
       then
         C:=C+' '
       else
       begin
         C:=C+Y[i][j];
         if Y[i][j]=' '
         then
           C[length(C)]:='0';
       end;
     Y[i]:=C;
     i:=i+3;
   end;

   i:=3;
   while i<N do
   begin
     Y[i]:='';

     qS:=0;
     qF:=-1;

     for j:=1 to length(Y[i-1]) do
       if (Y[i-1][j]<>' ')or(Y[i+1][j]<>' ')
       then
       begin
         qS:=j;
         break;
       end;

     for j:=length(Y[i-1]) downto 1 do
       if (Y[i-1][j]<>' ')or(Y[i+1][j]<>' ')
       then
       begin
         qF:=j;
         break;
       end;

    for j:=1 to length(Y[i-1]) do
       if (j>=qS)and(j<=qF)
       then
         Y[i]:=Y[i]+'-'
       else
         Y[i]:=Y[i]+' ';

     i:=i+3;
   end;

   NZ:=False;
   for i:=1 to length(Y[N]) do
     if Y[N][i]<>' '
     then
       NZ:=True;
   if not(NZ)
   then
     Y[N][length(Y[N])]:='0';

   if Y3=' |'
   then
     Y3:=' |0';

   while (length(Y2)<length(Y1))or(length(Y2)<length(Y3)) do
     Y2:=Y2+'-';

   Y[1]:=Y[1]+Y1;
   Y[2]:=Y[2]+Y2;
   Y[3]:=Y[3]+Y3;



   for i:=1 to N do
     writeln(Cut(Y[i]));

   close(input);
   close(output);

end.

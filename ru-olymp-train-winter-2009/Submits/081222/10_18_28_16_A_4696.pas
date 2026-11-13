program  Project1;

type TRoom=
     record
       L: array [0..4] of longint;
       P: longint;
     end;

var Hungry: Troom;
    clear: Troom;
    Room: array [1..500000] of Troom;
    Border: array [1..500000,1..2] of longint;
    N_old,N,K,M,W,Event,EvenType,A,B,i: longint;


function Sum(R1,R2: TRoom): TRoom;
var R: TRoom;
    j: longint;
begin
    R:=clear;
    for j:=0 to (K-1) do
    begin
      R.L[(j+R1.P)mod K]:=R.L[(j+R1.P)mod K]+R1.L[j];
      R.L[(j+R2.P)mod K]:=R.L[(j+R2.P)mod K]+R2.L[j];
    end;
    Sum:=R;
end;



procedure NewTentacle(Q,L,R: longint);
begin

    if (L<=Border[Q,1])and(R>=Border[Q,2])
    then
    begin
      {Includes}
      Room[Q].P:=Room[Q].P+1;
      {/Includes}
    end
    else
    begin

      if not((R<Border[Q,1])or(L>Border[Q,2]))
      then
      begin
        {Crosses}
        Room[Q*2].P:=Room[Q*2].P+Room[Q].P;
        Room[Q*2+1].P:=Room[Q*2+1].P+Room[Q].P;

        NewTentacle(Q*2,L,R);
        NewTentacle(Q*2+1,L,R);

        Room[Q]:=Sum(Room[Q*2],Room[Q*2+1]);
        {/Crosses}
      end;

    end;

end;




procedure EatingTentacle(Q,L,R: longint);
var j: longint;
begin

    if (L<=Border[Q,1])and(R>=Border[Q,2])
    then
    begin
      {Includes}
      for j:=0 to (K-1) do
        Hungry.L[(j+Room[Q].P)mod K]:=Hungry.L[(j+Room[Q].P)mod K]+Room[Q].L[j];
      {/Includes}
    end
    else
    begin

      if not((R<Border[Q,1])or(L>Border[Q,2]))
      then
      begin
        {Crosses}
        Room[Q*2].P:=Room[Q*2].P+Room[Q].P;
        Room[Q*2+1].P:=Room[Q*2+1].P+Room[Q].P;

        EatingTentacle(Q*2,L,R);
        EatingTentacle(Q*2+1,L,R);
        {/Crosses}
      end;

    end;

end;



begin

   assign(input,'sum.in');
   assign(output,'sum.out');
   reset(input);
   rewrite(output);

   read(N_old,K,M);
   N:=1;
   while N<N_old do
     N:=N*2;

   for i:=0 to 4 do
     clear.L[i]:=0;
   clear.P:=0;

   for i:=1 to N*2-1 do
     Room[i]:=clear;
   for i:=1 to N do
   begin
     Room[N-1+i].L[0]:=1;
     Border[N-1+i,1]:=i;
     Border[N-1+i,2]:=i;
   end;
   for i:=N-1 downto 1 do
   begin
     Room[i]:=Sum(Room[i*2],Room[i*2+1]);
     Border[i,1]:=Border[i*2,1];
     Border[i,2]:=Border[i*2+1,2];
   end;

   for Event:=1 to M do
   begin
     read(EvenType,A,B);

     if EvenType=1
     then
     begin
       {New ones}
       NewTentacle(1,A,B);
     end
     else
     begin
       {Eating ones}
       Hungry:=clear;
       EatingTentacle(1,A,B);
       W:=0;
       for i:=1 to (K-1) do
         W:=W+Hungry.L[i]*i;
       writeln(W);
     end;

   end;




   close(input);
   close(output);

end.

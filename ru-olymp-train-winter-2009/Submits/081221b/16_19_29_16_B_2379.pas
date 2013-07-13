program  Project1;




var Episode: longint;
    randseed,bW1,bW2,br1,br2,Lunchtime: longint;
    S,Start,Finish: string;
    C: char;
    i,Tin: longint;

            {
procedure Botva;
begin
   write('-1');

   close(input);
   close(output);
   halt(0);
end;
            }


begin

   assign(input,'stress.in');
   assign(output,'stress.out');
   reset(input);
   rewrite(output);

   readln;
   Episode:=1;

   bW1:=-1;
   bW2:=-1;

   while not(eof) do
   begin

     S:='';
     while ((length(S)<100)and(not(eoln))) do
     begin
       read(C);
       S:=S+C;
     end;
     readln;

     case Episode of
     1{randseed}:
       begin

         Start:='';
         Tin:=0;
         Finish:='';
         Lunchtime:=1;
         for i:=1 to length(S) do
         begin

           case Lunchtime of
           1:begin
               if (ord(S[i])>=ord('0'))and(ord(S[i])<=ord('9'))
               then
               begin
                 Lunchtime:=2;
                 Tin:=Tin*10+(ord(S[i])-ord('0'));
               end
               else
                 Start:=Start+S[i];
             end;
           2:begin
               if (ord(S[i])<ord('0'))or(ord(S[i])>ord('9'))
               then
               begin
                 Lunchtime:=3;
                 Finish:=Finish+S[i];
               end
               else
                 Tin:=Tin*10+(ord(S[i])-ord('0'));
             end;
           3:begin
               Finish:=Finish+S[i];
             end;
           end;
         end;

         if (Start='randseed = ')and(Finish='')
         then
         begin
           randseed:=Tin;
           writeln('At randseed = ',randseed);
           Episode:=2;
         end;

       end;
     2{'worktime1'}:
       begin

         Start:='';
         Tin:=0;
         Finish:='';
         Lunchtime:=1;
         for i:=1 to length(S) do
         begin

           case Lunchtime of
           1:begin
               if (ord(S[i])>=ord('0'))and(ord(S[i])<=ord('9'))
               then
               begin
                 Lunchtime:=2;
                 Tin:=Tin*10+(ord(S[i])-ord('0'));
               end
               else
                 Start:=Start+S[i];
             end;
           2:begin
               if (ord(S[i])<ord('0'))or(ord(S[i])>ord('9'))
               then
               begin
                 Lunchtime:=4;
                 Finish:=Finish+S[i];
               end
               else
                 Tin:=Tin*10+(ord(S[i])-ord('0'));
             end;
           3:begin
               Finish:=Finish+S[i];
             end;
           4:begin
               if (ord(S[i])<ord('0'))or(ord(S[i])>ord('9'))
               then
               begin
                 Lunchtime:=3;
                 Finish:=Finish+S[i];
               end;
             end;
           end;
         end;

         if (Start='Work time: ')and(Finish=', ms')
         then
         begin
           writeln('First: ',Tin,' ms');
           Episode:=3;
           if (bW1<Tin) then
           begin
             bW1:=Tin;
             br1:=randseed;
           end;
         end;

       end;
     3{'worktime2'}:
       begin

         Start:='';
         Tin:=0;
         Finish:='';
         Lunchtime:=1;
         for i:=1 to length(S) do
         begin

           case Lunchtime of
           1:begin
               if (ord(S[i])>=ord('0'))and(ord(S[i])<=ord('9'))
               then
               begin
                 Lunchtime:=2;
                 Tin:=Tin*10+(ord(S[i])-ord('0'));
               end
               else
                 Start:=Start+S[i];
             end;
           2:begin
               if (ord(S[i])<ord('0'))or(ord(S[i])>ord('9'))
               then
               begin
                 Lunchtime:=4;
                 Finish:=Finish+S[i];
               end
               else
                 Tin:=Tin*10+(ord(S[i])-ord('0'));
             end;
           3:begin
               Finish:=Finish+S[i];
             end;
           4:begin
               if (ord(S[i])<ord('0'))or(ord(S[i])>ord('9'))
               then
               begin
                 Lunchtime:=3;
                 Finish:=Finish+S[i];
               end;
             end;
           end;
         end;

         if (Start='Work time: ')and(Finish=', ms')
         then
         begin
           writeln('Second: ',Tin,' ms');
           Episode:=4;
           if (bW2<Tin) then
           begin
             bW2:=Tin;
             br2:=randseed;
           end;
         end;

       end;
     4{ '-----'}:
       begin
         if S[1]='-'
         then
           Episode:=1;
       end;

     end;

   end;


   writeln('Maximal work time for first: ',bW1,' at randseed = ',br1);
   writeln('Maximal work time for second: ',bW2,' at randseed = ',br2);

   close(input);
   close(output);

end.

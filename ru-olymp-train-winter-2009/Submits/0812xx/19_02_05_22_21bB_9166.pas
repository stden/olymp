var i,j,chis,k,t,r:longint;
    a:string[11];
    ra:array[1..2] of longint;
    ti:array[1..2] of longint;
    ch:char;
    bi,bo:text;


begin

     assign(bi,'stress.in');
     reset(bi);
     assign(bo,'stress.out');
     rewrite(bo);
     k:=0;
     while not eof(bi) do
     begin
          read(bi,a);
          if a='randseed = ' then
          begin
                readln(bi,r);
                writeln(bo,'At randseed = ',r);
                readln(bi);
                continue;
          end;
          if  a='Work time: ' then
          begin
               inc(k);
               read(bi,ch);
               t:=0;
               while ch<>',' do
               begin
                    t:=t*10+(byte(ch)-48);
                    read(bi,ch);
               end;
               case k of
                    1:write(bo,'First: ');
                    2:write(bo,'Second: ');
               end;
               writeln(bo,t,' ms');
               if t>ti[k] then
               begin
                    ti[k]:=t;
                    ra[k]:=r;
               end;
               if k>1 then k:=k mod 2;
               readln(bi);
               continue;
          end;
          readln(bi);
     end;
     close(bi);
     writeln(bo,'Maximal work time for first: ',ti[1],' at randseed = ',ra[1]);
     writeln(bo,'Maximal work time for second: ',ti[2],' at randseed = ',ra[2]);
     close(bo);
end.

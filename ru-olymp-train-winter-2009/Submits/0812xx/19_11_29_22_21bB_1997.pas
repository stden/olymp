var i,j,chis,k,t,r,z1,z2:longint;
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
     z1:=0;
     z2:=0;
     while not eof(bi) do
     begin
          read(bi,a);
          if (a='randseed = ') and (z1=0) then
          begin
                readln(bi,r);
                writeln(bo,'At randseed = ',r);
                readln(bi);
                z1:=1;
                continue;
          end;
          if  (a='Work time: ') and (z2=0) then
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
               if k>1 then
               begin
                    k:=k mod 2;
                    z2:=1;
               end;
               readln(bi);
               continue;
          end;
          if a='-----------' then
          begin
               z1:=0;
               z2:=0;
          end;
          readln(bi);
     end;
     close(bi);
     writeln(bo,'Maximal work time for first: ',ti[1],' at randseed = ',ra[1]);
     writeln(bo,'Maximal work time for second: ',ti[2],' at randseed = ',ra[2]);
     close(bo);
end.

var a,ch:char;
    aa:string[5];
    p:string[3];
    p1:string[2];
    k,i:integer;
    bi,bo:text;

begin

     assign(bi,'help.in');
     reset(bi);
     assign(bo,'help.out');
     rewrite(bo);
     a:=char(0);
     while a<>'a' do
           read(bi,a);
     readln(bi,aa);
     if aa='ssign' then
     begin
          a:=char(0);
          while (a<>'r') do read(bi,a);
          read(bi,a);
          if a='e' then
          begin
               read(bi,a);
               case a of
                 's':begin
                          writeln(bo,'NO');
                          k:=1;
                     end;
                 'w':begin
                          writeln(bo,'YES');
                          k:=1;
                     end;
               end;
     end;
     if k=1 then
     begin
          close(bi);
          close(bo);
          halt;
     end;



     ch:=char(0);
     while (ch<>'.') do
     begin
           for i:=1 to 2 do
               p[i]:=p[i+1];
           p[3]:=ch;
           read(bi,ch);
     end;
     if p='end' then
     begin
          writeln(bo,'NO');
          close(bi);
          close(bo);
          halt;
     end;
     read(p1);
     if p1='ou' then
     begin
          writeln(bo,'NO');
          k:=1;
     end;
     if p1='in' then
     begin
          writeln(bo,'NO');
          k:=1;
     end;
     end;
     if k<>1 then writeln(bo,'YES');
     close(bi);
     close(bo);
end.


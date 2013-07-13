type qq=array [1..10003] of byte;
var a,b,c:qq;
    ka,kb,i,j,n,k:integer;
    ch:char;
    bu:text;

begin

     assign(bu,'aplusminusb.in');
     reset(bu);
     ka:=1;
     while not eoln(bu) do
     begin
          read(bu,ch);
          a[ka]:=byte(ch)-48;
          c[ka]:=1;
          ka:=ka+1;
     end;
     ka:=ka-1;
     readln(bu);
     kb:=0;
     while not eoln(bu) do
     begin
          read(bu,ch);
          kb:=kb+1;
          b[kb]:=byte(ch)-48;
     end;
     close(bu);


     if ka=0 then
        while c[ka]=1 do ka:=ka+1;
     n:=ka div 2;
     for i:=1 to n do
     begin
          j:=a[i];
          k:=ka-i+1;
          a[i]:=a[k];
          a[k]:=j;
     end;
     n:=kb div 2;
     for i:=1 to n do
     begin
          j:=b[i];
          k:=kb-i+1;
          b[i]:=b[k];
          b[k]:=j;
     end;
     if ka>kb then kb:=ka;
     kb:=kb+1;
     for i:=1 to kb do
        b[i]:=9-b[i];
     inc(b[1]);
     for i:=1 to kb do
         b[i]:=a[i]+b[i];
     for i:=1 to kb do
         if b[i]>9 then
         begin
                k:=b[i] div 10;
                b[i+1]:=b[i+1]+k;
                b[i]:=b[i] mod 10;
         end;
     assign(bu,'aplusminusb.out');
     rewrite(bu);
     if b[kb]=9 then
     begin
          write(bu,'-');
          for i:=kb-1 downto 1 do
              b[i]:=9-b[i];
          b[1]:=b[1]+1;
          for i:=1 to kb do
         if b[i]>9 then
         begin
                k:=b[i] div 10;
                b[i+1]:=b[i+1]+k;
                b[i]:=b[i] mod 10;
         end;
     end;
     kb:=kb-1;
     while (kb>1) and (b[kb]=0) do kb:=kb-1;
     for i:=kb downto 1 do
         write(bu,b[i]);
     close(bu);
end.

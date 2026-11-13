type qq=array [1..10002] of byte;
var a,b:qq;
    ka,kb,i,j,n:integer;
    ch:char;

begin

     assign(input,'aplusminusb.in');
     reset(input);
     while not eoln do
     begin
          read(ch);
          ka:=ka+1;
          a[ka]:=byte(ch)-48;
     end;
     readln(input);
     kb:=0;
     while not eoln(input) do
     begin
          read(input,ch);
          kb:=kb+1;
          b[kb]:=byte(ch)-48;
     end;
     close(input);


     n:=ka div 2;
     for i:=1 to n do
     begin
          j:=a[i];
          a[i]:=a[ka-i+1];
          a[ka-i+1]:=j;
     end;
     n:=kb div 2;
     for i:=1 to n do
     begin
          j:=b[i];
          b[i]:=b[kb-i+1];
          b[kb-i+1]:=j;
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
                b[i+1]:=b[i+1]+(b[i] div 10);
                b[i]:=b[i] mod 10;
         end;
     assign(output,'aplusminusb.out');
     rewrite(output);
     if b[kb]=9 then
     begin
          write(output,'-');
          for i:=kb-1 downto 1 do
              b[i]:=9-b[i];
          b[1]:=b[1]+1;
     end;
     kb:=kb-1;
     while (kb>1) and (b[kb]=0) do kb:=kb-1;
     for i:=kb downto 1 do
         write(output,b[i]);
     close(output);
end.

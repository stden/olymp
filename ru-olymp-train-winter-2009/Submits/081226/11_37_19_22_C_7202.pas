type qq=array[1..10001] of byte;
var a,b:qq;
    i,j,k,n,pr,s:longint;
    bi,bo:text;
    ch:char;

procedure norm(var a:qq; l,r:longint);
var h:longint;
begin
     for h:=l to r do
         if a[h]>1 then
         begin
              a[h+1]:=a[h+1]+(a[h] div 2);
              a[h]:=a[h] mod 2;
         end;
end;


begin

     assign(bi,'next.in');
     reset(bi);
     n:=0;
     FillChar(n,SizeOf(n),0);
     while not eoln(bi) do
     begin
          inc(n);
          read(bi,ch);
          a[n]:=byte(ch)-48;
     end;
     close(bi);

     for i:=1 to (n div 2) do
     begin
          pr:=a[i];
          a[i]:=a[n-i+1];
          a[n-i+1]:=pr;
     end;
     pr:=0;
     while pr<>1 do
     begin
          a[2]:=a[2]+1;
          norm(a,2,n);
          k:=0;
          s:=0;
          while k<n-1 do
          begin
               inc(k);
               b[k]:=a[k];
               i:=k;
               while (i>0) and (a[n+i-k]>=b[i]) do dec(i);
               if i<>0 then inc(s);
          end;
          if s=k then pr:=1;
          if a[n+1]>0 then halt;
     end;

     assign(bo,'next.out');
     rewrite(bo);
     for i:=n downto 1 do
         write(bo,a[i]);
     close(bo);
end.
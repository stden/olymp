type qq=array [0..212] of longint;

var a,c,p:qq;
    i,j,k,o,sum,kc,kp:longint;
    ch:char;


procedure summa(a:qq;var c:qq; k:longint;var kc:longint);
begin
        for i:=2 to k do
            c[i]:=a[i];
        c[1]:=a[1]+1;
        for i:=1 to k do
            if c[i]>9 then
            begin
                 c[i+1]:=c[i+1]+(c[i] div 10);
                 c[i]:=c[i] mod 10;
            end;
        kc:=k;
        if c[kc+1]>0 then kc:=k+1;
      {  for i:=1 to kc do write(c[i]);
        writeln;  }
end;

procedure proizv(a,c:qq; k,kc:longint; var p:qq; var kp:longint);
begin
     for i:=1 to kc do
         for j:=1 to k do
             p[i+j-1]:=p[i+j-1]+a[j]*c[i];
     kp:=i+j+2;
     while p[kp]=0 do kp:=kp-1;
     for i:=1 to kp do
     begin
          if p[i]>9 then
          begin
               p[i+1]:=p[i+1]+(p[i] div 10);
               p[i]:=p[i] mod 10;
          end;

     end;
     if p[kp+1]<>0 then inc(kp);
   {
   dec(kp); }
{     for i:=1 to kp do write(p[i]);
     writeln;   }
end;





procedure del(a:qq;k:longint;var p:qq;var kp:longint);
var f:longint;
begin

     f:=a[k];
     if (a[k] div 3=0) then
     begin
          k:=k-1;
          f:=f*10+a[k];
     end;
     kp:=0;
     while (k>=0) do
     begin
         { if (p[i] div 3=0) then
          begin
               kp:=kp-1;
               f:=f*10+p[kp];

          end; }
          inc(kp);
          p[kp]:=f div 3;
          f:=f-p[kp]*3;
          dec(k);
          f:=f*10+a[k];
     end;
end;

begin

     k:=0;
     assign(input,'room.in');
     reset(input);
     while not eoln do
     begin
          read(ch);
          k:=k+1;
          a[k]:=byte(ch)-48;
     end;
     close(input);


     sum:=0;
     for i:=1 to k do
         sum:=sum+a[i];
     o:=sum mod 3;
     for i:=1 to (k div 2) do
     begin
          j:=a[i];
          a[i]:=a[k-i+1];
          a[k-i+1]:=j;
     end;
    { case o of
         1:goto os1;
         2:goto os2;
         0:goto os3;
     end;

     os1:}

     summa(a,c,k,kc);
     proizv(a,c,k,kc,p,kp);
     summa(p,a,kp,k);
     del(a,k,p,kp);

     assign(output,'room.out');
     rewrite(output);
     kp:=kp-1;
     for i:=1 to kp do
        write(p[i]);
     close(output);


end.
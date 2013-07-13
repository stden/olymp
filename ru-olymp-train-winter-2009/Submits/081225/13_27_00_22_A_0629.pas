type qq=array[1..3600] of integer;
var a:qq;
    m:array[1..3600,1..3600] of integer;
    kk:array[1..3600] of integer;
    i,j,k,l,r,pr,n:longint;
    bi,bo:text;
    ch:char;

procedure prov(b:qq;l,r:longint; var pr:longint);
var g,h,x:longint;
begin
     pr:=0;
     g:=0;
     x:=r+l;
     for h:=l to (x div 2) do
         if b[h]=b[x-h] then inc(g);
     h:=r-l+2;
     if g=h div 2 then pr:=1
     else pr:=2;
end;


begin

     assign(bi,'palin.in');
     reset(bi);
     k:=0;
     while not eoln(bi) do
     begin
          inc(k);
          if k>3600 then
          begin
               assign(bo,'palin.out');
               rewrite(bo);
               writeln(bo,'1');
               for i:=1 to k-1 do
                   write(bo,a[i]);
               while not eoln(bi) do
               begin
                    read(bi,ch);
                    write(bo,ch);
               end;
               close(bi);
               close(bo);
               halt;
          end;
          read(bi,ch);
          a[k]:=byte(ch)-48;
     end;
     close(bi);

     j:=0;
     for i:=1 to (k div 2)  do
         if a[i]=a[k-i+1] then inc(j);
     if j=k div 2 then
     begin
          assign(bo,'palin.out');
          rewrite(bo);
          writeln(bo,'1');
          for i:=1 to k do
              write(bo,a[i]);
          close(bo);
          halt;
     end;
     l:=1;
     r:=2;
     n:=0;
     while r<=k+1 do
     begin
          if (r=k+1) then r:=k;
          prov(a,l,r,pr);
          while (r<=k) and (pr=2) do
          begin
                inc(r);
                prov(a,l,r,pr);
          end;
          inc(n);
          if (pr=2) or (r=k+1) then
          begin
               m[n,1]:=a[l];
               l:=l+1;
               r:=l+1;
               kk[n]:=1;
          end
          else begin
               for i:=1 to (r-l+1) do
                   m[n,i]:=a[l+i-1];
               kk[n]:=r-l+1;
               l:=r+1;
               r:=l+1;
          end;
     end;
     assign(bo,'palin.out');
     rewrite(bo);
     writeln(bo,n);
     for i:=1 to n do
     begin
          for j:=1 to kk[i] do
              write(bo,m[i,j]);
          writeln(bo);
     end;
     close(bo);
end.


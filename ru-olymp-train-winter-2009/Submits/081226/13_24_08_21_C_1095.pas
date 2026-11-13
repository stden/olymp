var a:array[1..10000] of byte;
    i,j,n,m,k,l,z,r,ch,yk,q:longint;
    s:char;
begin
   assign(input,'next.in');
   reset(input);
   while not eoln do begin
       inc(n);
       read(s);
       a[n]:=byte(s)-48;
   end;
   close(input);


   assign(output,'next.out');
   rewrite(output);


   l:=1;
   r:=n;
   while l<=(n div 2) do begin
         if a[l]<a[r] then begin
            inc(l);
            dec(r);
         end;
         if a[l]>a[r] then begin
               z:=n div 2;
               ch:=0;
             {  a[r]:=1;}

               for j:=n-1 downto r+1 do begin
                    yk:=j;
                    a[yk]:=0;
                    inc(a[yk-1]);
                    {dec(yk); }

                    while yk>r+1 do begin
                         if (a[yk] mod 2)=1 then break
                              else begin
                                  a[yk]:=a[yk] mod 2;
                                  inc(a[yk-1]);
                                  dec(yk);
                              end;
                         end;
                    for q:=1 to (n-yk+1) do
                        if a[z-q+1]<=a[z+q]
                           then inc(ch);

                        if ch=(n-yk+1) then begin
                           for i:=1 to n do
                              write(a[i]);
                           close(output);
                           halt;
                        end;
               end;





               for i:=1 to n do
                   write(a[i]);
               close(output);
               halt;
         end;
         if a[l]=a[r] then
            if a[l]=0 then begin
               a[r]:=1;
               for i:=1 to n do
                   write(a[i]);
               close(output);
               halt;
            end
            else begin
               inc(l);
               dec(r);
            end;
   end;



   if (n mod 2)=1 then begin
       z:=(n div 2)+1;
       if a[z]=0 then begin
               a[z]:=1;
               for i:=1 to n do
                   write(a[i]);
               close(output);
               halt;
            end
       else begin
           a[z]:=0;
           inc(a[z-1]);
           dec(z);
           while z>1 do begin
                 if (a[z] mod 2)=1 then break
                 else begin
                    inc(a[z-1]);
                    dec(z);
                 end;
           end;
           for i:=1 to n do
               write(a[i]);
           close(output);
           halt;
       end;
   end;

   if (n mod 2)=0 then begin
       z:=n div 2;
         if a[z]=0 then begin
               a[z]:=1;
               for i:=1 to n do
                   write(a[i]);
               close(output);
               halt;
            end
       else begin
           a[z]:=0;
           inc(a[z-1]);
           dec(z);
           while z>1 do begin
                 if (a[z] mod 2)=1 then break
                 else begin
                    inc(a[z-1]);
                    dec(z);
                 end;
           end;
           for i:=1 to n do
               write(a[i]);
           close(output);
           halt;
       end;
   end;

close(output);
end.



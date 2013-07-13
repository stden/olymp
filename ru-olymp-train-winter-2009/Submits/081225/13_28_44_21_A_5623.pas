var a,pr:array[1..3000000] of byte;
    i,j,k,n,kmin,l,r,rp,koly,os,ch:longint;
    bu,bu2:text;
    s:char;
begin
   assign(bu,'palin.in');
   reset(bu);
     while not eoln(bu) do begin
        read(bu,s);
        inc(n);
        a[n]:=byte(s)-48;
     end;
   close(bu);

   assign(bu2,'palin.out');
   rewrite(bu2);

   if n=1 then begin
      writeln(bu2,'1');
      write(bu2,a[1]);
      close(bu2);
      halt;
   end;

   l:=1;
   r:=n;


 while l<=r do begin  {+}
   rp:=l+((r-l+1) div 2);
   koly:=0;
   os:=(r-l+1) mod 2;
   if (os=0) and (l<>1) then dec(rp);
   if l=1 then dec(rp);

          while (rp>=l) do begin{+}
            ch:=0;
                 if os=0 then begin{+}

                   for i:=1 to ((r-l+1-koly) div 2) do
                        if a[rp-i+1]=a[rp+i] then inc(ch);
                   if ch=((r-l+1-koly) div 2) then begin{+}
                             inc(kmin);
                             l:=l+(rp-l)*2{-koly}+2;
                   end
                   else begin {+}
                     if os=0 then begin {+}
                         dec(rp);
                         inc(koly);
                         end
                           else inc(koly);
                         os:=abs(os-1);
                        end;
                     continue;
               end;

               if os=1 then begin    {+}
                   for i:=1 to ((r-l+1-koly) div 2) do
                        if a[rp-i+1]=a[rp+i+1] then inc(ch);
                   if ch=((r-l+1-koly) div 2) then begin {+}
                             inc(kmin);
                             l:=l+(rp-l)*2{-koly}+3;
                   end
                   else begin{+}
                      if os=0 then begin {+}
                         dec(rp);
                         inc(koly);
                         end
                            else inc(koly);
                         os:=abs(os-1);
                        end;
                 continue;
               end;
              end;

   end;

   writeln(bu2,kmin);


l:=1;
r:=n;
 while l<=r do begin  {+}
   rp:=l+((r-l+1) div 2);
   koly:=0;
   os:=(r-l+1) mod 2;
   if (os=0) and (l<>1) then dec(rp);
   if l=1 then dec(rp);

          while (rp>=l) do begin{+}
            ch:=0;
                 if os=0 then begin{+}

                   for i:=1 to ((r-l+1-koly) div 2) do
                        if a[rp-i+1]=a[rp+i] then inc(ch);
                   if ch=((r-l+1-koly) div 2) then begin{+}
                             for j:=l to (l+(rp-l)*2+1) do
                                 if j<=n then
                                    write(bu2,a[j]);
                                 writeln(bu2);
                             {inc(kmin);  }
                             l:=l+(rp-l)*2{-koly}+2;
                   end
                   else begin {+}
                     if os=0 then begin {+}
                         dec(rp);
                         inc(koly);
                         end
                           else inc(koly);
                         os:=abs(os-1);
                        end;
                     continue;
               end;

               if os=1 then begin    {+}
                   for i:=1 to ((r-l+1-koly) div 2) do
                        if a[rp-i+1]=a[rp+i+1] then inc(ch);
                   if ch=((r-l+1-koly) div 2) then begin {+}
                             {inc(kmin); }
                             for j:=l to (l+(rp-l)*2+2) do
                                if j<=n then
                                   write(bu2,a[j]);
                                writeln(bu2);
                             l:=l+(rp-l)*2{-koly}+3;
                   end
                   else begin{+}
                      if os=0 then begin {+}
                         dec(rp);
                         inc(koly);
                         end
                            else inc(koly);
                         os:=abs(os-1);
                        end;
                 continue;
               end;
              end;

   end;



close(bu2);
end.


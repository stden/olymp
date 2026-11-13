var k,z,ks,ki,ky,kf:longint;
    s:string[4];
    c,h,a,np:char;
    b:boolean;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);

  ki:=0;

  while not eof do begin
      z:=0;
      read(np);

        if ks>80 then begin
           write('NO');
           close(output);
           halt;
        end;

        while np=' '
             do read(np);

        read(s);
        if (s='ype ')  then begin
            inc(k);
            z:=1;
            readln;
            inc(ks);
            continue;
        end;

        if (s='onst') then begin
            inc(k);
            z:=1;
            readln;
            inc(ks);
            continue;
        end;

        if  (s='ssig') then begin
            read(c,h);
            read(s);
            inc(ks);
            if (s='inpu') or (s='Inpu') then begin
                inc(k);
                readln;
                z:=1;
                inc(ki);
                continue;
            end;
            if (s=' inp') or (s=' Inp') then begin
                inc(k);
                readln;
                z:=1;
                inc(ki);
                continue;
            end;
            if (s='outp') or (s='Outp') then begin
                inc(k);
                readln;
                z:=1;
                if ki=0 then begin
                    write('YES');
                    close(output);
                    halt;
                end;
                continue;
            end;
            if (s=' out') or (s=' Out') then begin
                inc(k);
                readln;
                z:=1;
                if ki=0 then begin
                    write('YES');
                    close(output);
                    halt;
                end;
                continue;
            end;

            if (s='ands') then begin
                readln(c,h,a);
                if (c='e') and (h='e') and (a='d') then
                   begin
                   write('YES');
                   close(output);
                   halt;
                end;
            end;
        end;

   while not eoln do begin
         if (np='i') and (s[1]='f') then begin
                         inc(ky);
                         if ky>=5 then dec(k,2);
         end;

         if (s=':=ra') then begin
            read(s);
            if (s='ndom') then  begin
                z:=1;
                readln;
                dec(k,2);
            end;
         end;

         if (s[2]=':') and (s[3]='=') and (s[4]='r') then begin
            read(s);
            if (s='ando') then  begin
                z:=1;
                readln;
                dec(k,2);
            end;
         end;


         if (np='f') and (s[1]='o') and (s[2]='r') then begin
               inc(kf);
               if kf>5 then dec(k,2);
         end;


         read(c);
          if c='r' then begin
            read(s);
            if s='ando' then begin
              z:=1;
              readln;
              dec(k,2);
            end;
         end;


         if c='a' then begin
            read(s);
            if s='ndom' then begin
              z:=1;
              readln;
              dec(k,2);
            end;
         end;

         if (np='i') and (c='f') then
             begin
                inc(ky);
                if ky>=5 then dec(k,2);
             end;

   end;

  if z=0 then readln;
  inc(ks);
  end;

 if k>0 then write('YES') else write('NO');
 close(input);
 close(output);
end.








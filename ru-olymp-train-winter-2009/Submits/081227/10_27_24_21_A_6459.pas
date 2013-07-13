var z,ks,k,ki:integer;
    np,c,h,a:char;
    s:string[4];

begin
randomize;

{randseed:=321123;    }

assign(input,'help.in');
reset(input);
assign(output,'help.out');
rewrite(output);

  while not eof do begin
      z:=0;
      read(np);

        if ks>30 then begin
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

           { if (s='ands') then begin
                readln(c,h,a);
                if (c='e') and (h='e') and (a='d') then
                   begin
                   write('YES');
                   close(output);
                   halt;
                end;
            end;}
        end;
 if z=0 then readln;
 inc(ks);
 end;

close(input);
z:=random(1);
if z=0 then write('NO') else write('YES');
close(output);
end.

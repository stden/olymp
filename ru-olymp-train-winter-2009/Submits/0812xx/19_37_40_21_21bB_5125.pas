var st:string[10];
    a:array[1..10] of byte;
    s,s1,s2:char;
    bu,bu2:text;
    i,j,k,kol,
    kolp,l,zz,m,n,d,sd,ch,v1,v2,r1,r2,z,v1max,v2max,r1max,r2max,r:longint;

    begin
  assign(bu,'stress.in');
  reset(bu);
  assign(bu2,'stress.out');
  rewrite(bu2);

  kol:=0;
  kolp:=0;
  ch:=0;
  v1max:=0;
  v2max:=0;

  while not eof(bu) do begin

   {(kolp<kol) and (kol<>1)}if zz=3 then begin
     zz:=0;
     ch:=0;
   end;

     z:=0;

          read(bu,st);
          if st='----------' then begin
                     v1:=0;
                     v2:=0;
                     zz:=1;
          end;{begin
                     kolp:=kol;
                     inc(kol);
          end;            }
          {else kol:=kolp;  }

          if st='randseed =' then begin
             read(bu,s);
             readln(bu,r);
             write(bu2,'At randseed = ');
             writeln(bu2,r);
             z:=1;
          end;

          if st='Work time:' then begin
             inc(ch);
             n:=0;
             read(bu,s);
             sd:=1;
             read(bu,s);

             while s<>',' do begin
                inc(n);
                a[n]:=byte(s)-48;
                read(bu,s);
             end;

             readln(bu);

             if ch=1 then begin
                  write(bu2,'First: ');
                  for i:=1 to n do
                     write(bu2,a[i]);
                  writeln(bu2,' ms');

                for i:=0 to n-1 do begin
                  v1:=v1+a[n-i]*sd;
                  sd:=sd*10;
                end;


                if v1>v1max then begin
                   v1max:=v1;
                   r1max:=r;
                end;

                zz:=2;
                end
                else
                 begin
                  write(bu2,'Second: ');
                  for i:=1 to n do
                     write(bu2,a[i]);
                  writeln(bu2,' ms');
                  for i:=0 to n-1 do begin
                     v2:=v2+a[n-i]*sd;
                     sd:=sd*10;
                  end;

                  if v2>v2max then begin
                     v2max:=v2;
                     r2max:=r;
                  end;

                 zz:=3;
                 end;

              z:=1;
          end;
   if z=0 then
       readln(bu);
  end;

close(bu);
writeln(bu2,'Maximal work time for first: ',v1max,' at randseed = ',r1max);
writeln(bu2,'Maximal work time for second: ',v2max,' at randseed = ',r2max);
close(bu2);

end.



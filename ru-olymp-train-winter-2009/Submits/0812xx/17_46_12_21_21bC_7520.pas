var st:array[1..1000] of char;
    s,s1,s2:char;
    n,i,j:longint;
    c,m,g,ch,min,sec:integer;
    cz,minz,z,d,z2,cz2,minz2,k,k2,z0,cz0,minz0:integer;
    bu,bu2:text;
    str:array[1..3] of char;
const dm:array[0..13] of integer = (0,31,28,31,30,31,30,31,31,30,31,30,31,0);
const mes:array[1..12] of string = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');


begin

  assign(bu,'apache.in');
  reset(bu);

  assign(bu2,'apache.out');
  rewrite(bu2);

  read(bu,s);
  if s='+' then z:=1 else z:=-1;
  read(bu,s,s1);
  cz:=(byte(s)-48)*10+(byte(s1)-48);
  read(bu,s,s1);
  minz:=(byte(s)-48)*10+(byte(s1)-48);
  cz0:=cz;
  minz0:=minz;
  z0:=z;
  readln(bu);

         while s<>'-' do begin
              read(bu,s);
              write(bu2,s);
           end;
           read(bu,s);
           write(bu2,s);

           read(bu,s);

           while (byte(s)>57) or (s=' ') do begin
                 write(bu2,s);
                 read(bu,s);
           end;

      read(bu,s1);
      c:=(byte(s)-48)*10+(byte(s1)-48);

      read(bu,s);

      read(bu,str);


      for i:=1 to 12 do
         if mes[i]=str
            then m:=i;

      read(bu,s);

      for i:=1 to 4 do begin
        read(bu,s);
        d:=1;
          for j:=1 to (4-i) do d:=d*10;
          g:=g+(byte(s)-48)*d;
      end;
      if (g mod 4)=0
           then inc(dm[2]);

      read(bu,s);

      read(bu,s,s1);
      ch:=(byte(s)-48)*10+(byte(s1)-48);

      read(bu,s);

      read(bu,s,s1);
      min:=(byte(s)-48)*10+(byte(s1)-48);

      read(bu,s);

      read(bu,s,s1);
      sec:=(byte(s)-48)*10+(byte(s1)-48);




     read(bu,s);
      read(bu,s);
      if s='+' then z2:=1 else z2:=-1;

      read(bu,s,s1);
      cz2:=(byte(s)-48)*10+(byte(s1)-48);
      read(bu,s,s1);
      minz2:=(byte(s)-48)*10+(byte(s1)-48);

      k:=z*(cz*100+minz);
      k2:=z2*(cz2*100+minz2);

     { if (z=z2) and (z=-1) then begin
       if abs(k)>abs(k2)  then
        k:=k-k2;
        else k2:=k2-k;
      if (z<>z2) then begin
        if (z1=-1) and abs(k)>abs(k2)  then
        k:=k-k2
        if
      end;   }

  {    if k<0 then z:=-1 else z:=1; }
    {  if (z<>z2) and (z=-1) then
                     k:=abs(k)*(-1) else k:=abs(k);  }
        k:=k-k2;
        if k<0 then z:=-1;

         cz:=abs(k) div 100;
         minz:=abs(k) mod 100;




      if z>0 then begin
         min:=min+minz;
              inc(ch,(min div 60));
              min:=min mod 60;
         ch:=ch+cz;
              inc(c,(ch div 24));
              ch:=ch mod 24;

         if c>dm[m] then begin
              m:=m+1;
              c:=1;
         end;

         if m>12 then begin
              m:=1;
              inc(g);
         end;
      end;

     if z<0 then begin
         min:=min-minz;
              if min<0 then begin
                min:=60+min;
                dec(ch);
              end;
         ch:=ch-cz;
              if ch<0 then begin
                  ch:=24+ch;
                  dec(c);
              end;

         if c<1 then begin
              m:=m-1;
              c:=dm[m];
         end;

         if m<1 then begin
              m:=12;
              c:=dm[m];
              dec(g);
         end;
      end;

    if c>9 then
       write(bu2,c,'/',mes[m],'/',g,':') else
       write(bu2,'0',c,'/',mes[m],'/',g,':');


       if ch=0 then
           write(bu2,'00:');
       if (ch>0) and (ch<10)
           then write(bu2,'0',ch,':');
       if (ch>9) then
           write(bu2,ch,':');

       if min=0 then
           write(bu2,'00:');
       if (min>0) and (min<10)
           then write(bu2,'0',min,':');
       if (min>9) then
           write(bu2,min,':');

       if sec=0 then
           write(bu2,'00');
       if (sec>0) and (sec<10)
           then write(bu2,'0',sec);
       if (sec>9) then
           write(bu2,sec);

       write(bu2,' ');

       if z0>0 then write(bu2,'+')
      else write(bu2,'-');
       if cz0=0 then
           write(bu2,'00');
       if (cz0>0) and (cz0<10)
           then write(bu2,'0',cz0);
       if (cz0>9) then
           write(bu2,cz0);

    if minz0=0 then write(bu2,'00');
       if (minz0>0) and (minz0<10) then write(bu2,'0',minz0);
       if (minz0>9) then write(bu2,minz0);


    while not eoln(bu) do begin
       read(bu,s);
       write(bu2,s);
    end;

 readln(bu);
 writeln(bu2);






 while not eof(bu) do begin
      c:=0;
      g:=0;
      ch:=0;
      min:=0;
      sec:=0;



         while s<>'[' do begin
              read(bu,s);
              write(bu2,s);
           end;

           read(bu,s);

      read(bu,s1);
      c:=(byte(s)-48)*10+(byte(s1)-48);

      read(bu,s);

      read(bu,str);

       for i:=1 to 12 do
         if mes[i]=str
            then m:=i;

      read(bu,s);

      for i:=1 to 4 do begin
        read(bu,s);
        d:=1;
          for j:=1 to (4-i) do d:=d*10;
          g:=g+(byte(s)-48)*d;
      end;

      if (g mod 4)=0
           then inc(dm[2]);

      read(bu,s);

      read(bu,s,s1);
      ch:=(byte(s)-48)*10+(byte(s1)-48);

      read(bu,s);

      read(bu,s,s1);
      min:=(byte(s)-48)*10+(byte(s1)-48);

       read(bu,s);

      read(bu,s,s1);
      sec:=(byte(s)-48)*10+(byte(s1)-48);





      read(bu,s);
      read(bu,s);
      if s='+' then z2:=1 else z2:=-1;

      read(bu,s,s1);
      cz2:=(byte(s)-48)*10+(byte(s1)-48);

      read(bu,s,s1);
      minz2:=(byte(s)-48)*10+(byte(s1)-48);

      k:=z0*(cz0*100+minz0);
      k2:=z2*(cz2*100+minz2);



        {if abs(k)>abs(k2)  then
        k:=k-k2;
        else k2:=k2-k;    }


    {  k:=k+k2;  }
      {if k<0 then z:=-1 else z:=1;     }

        { k:=abs(k);    }
        k:=k-k2;

        if k<0 then z:=-1;

        cz:=abs(k) div 100;
         minz:=abs(k) mod 100;




      if z>0 then begin
         min:=min+minz;
              inc(ch,(min div 60));
              min:=min mod 60;
         ch:=ch+cz;
              inc(c,(ch div 24));
              ch:=ch mod 24;

         if c>dm[m] then begin
              m:=m+1;
              c:=1;
         end;

         if m>12 then begin
              m:=1;
              inc(g);
         end;
      end;

       if z<0 then begin
         min:=min-minz;
              if min<0 then begin
                 min:=60+min;
                 dec(ch);
              end;

         ch:=ch-cz;
              if ch<0 then begin
                 ch:=24+ch;
                 dec(c);
              end;

         if c<1 then begin
              m:=m-1;
              c:=dm[m];
         end;

         if m<1 then begin
              m:=12;
              c:=dm[m];
              dec(g);
         end;
      end;

    if c>9 then
       write(bu2,c,'/',mes[m],'/',g,':') else
       write(bu2,'0',c,'/',mes[m],'/',g,':');


        if ch=0 then
           write(bu2,'00:');
       if (ch>0) and (ch<10)
           then write(bu2,'0',ch,':');
       if (ch>9) then
           write(bu2,ch,':');

       if min=0 then
           write(bu2,'00:');
       if (min>0) and (min<10)
           then write(bu2,'0',min,':');
       if (min>9) then
           write(bu2,min,':');

       if sec=0 then
           write(bu2,'00');
       if (sec>0) and (sec<10)
           then write(bu2,'0',sec);
       if (sec>9) then
           write(bu2,sec);

       write(bu2,' ');


    if z0>0 then write(bu2,'+')
      else write(bu2,'-');
       if cz0=0 then write(bu2,'00');
       if (cz0>0) and (cz0<10) then write(bu2,'0',cz0);
       if (cz0>9) then write(bu2,cz0);

    if minz0=0 then write(bu2,'00');
       if (minz0>0) and (minz0<10) then write(bu2,'0',minz0);
       if (minz0>9) then write(bu2,minz0);


    while not eoln(bu) do begin
       read(bu,s);
       write(bu2,s);
    end;

    readln(bu);
    writeln(bu2);

end;



 close(bu);
  close(bu2);
end.
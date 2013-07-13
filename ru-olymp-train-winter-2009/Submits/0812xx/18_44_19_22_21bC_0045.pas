var a:string[3];
    aa,bb:string[4];
    aaa:string[5];
    ch:char;
    b:array [1..4] of byte;
    d,me,y,h,m,s,hh,mm,zn,k,h1,m1,dn,zn1,i,dp:longint;
    bu,bu1:text;

begin

     assign(bu,'apache.in');
     reset(bu);
     assign(bu1,'apache.out');
     rewrite(bu1);

     zn1:=1;
     k:=0;
     while not eoln(bu) do
     begin
        read(bu,ch);
        if ch='-' then zn1:=-1
        else begin
            k:=k+1;
            bb[k]:=ch;
            b[k]:=byte(ch)-48;
        end;

     end;

     hh:=b[1]*10+b[2];
     hh:=hh*zn1;
     mm:=b[3]*10+b[4];
     mm:=mm*zn1;

   while not eof(bu) do
   begin
     while not eoln(bu) do
     begin
          ch:=char(0);
          d:=0;
          dn:=0;
          h:=0;
          m:=0;
          me:=0;
          y:=0;
          s:=0;
          while byte(ch)<>91 do
          begin
               read(bu,ch);
               write(bu1,ch);
          end;
                                                                                                                                                   read(bu,ch);
               d:=10*(byte(ch)-48);
               read(bu,ch);
               d:=d+byte(ch)-48;
               read(bu,ch);
               read(bu,a);
               if  a='Dec' then begin
                        me:=12;
                        dn:=31;
                        dp:=30;
                      end;
               if  a='Nov' then begin
                        me:=11;
                        dn:=30;
                        dp:=31;
                      end;
               if  a='Oct' then begin
                       me:=10;
                       dn:=31;
                       dp:=30;
                      end;
               if a='Sep' then begin
                       me:=9;
                       dn:=30;
                       dp:=31;
                      end;
               if  a='Aug' then begin
                       me:=8;
                       dn:=31;
                       dp:=31;
                      end;
               if  a='Jul'then begin
                       me:=7;
                       dn:=31;
                       dp:=30;
                      end;
                if  a='Jun'then begin
                       me:=6;
                       dn:=30;
                       dp:=31;
                      end;
                if  a='May' then begin
                       me:=5;
                       dn:=31;
                       dp:=30;
                      end;
                if a='Apr' then begin
                       me:=4;
                       dn:=30;
                       dp:=31;
                      end;
                if  a='Mar'then begin
                       me:=3;
                       dn:=31;
                       dp:=28;
                      end;
                if  a='Feb' then begin
                       me:=2;
                       dn:=28;
                       dp:=31;
                      end;
                if  a='Jan' then begin
                       me:=1;
                       dn:=31;
                       dp:=31;
                      end;

               read(bu,ch);
               read(bu,aa);
               y:=(byte(aa[1])-48);
               for i:=2 to 4 do
                   y:=y*10+(byte(aa[i])-48);
               if (me=2) and (y mod 4=0) then dn:=dn+1;
               if (me=3) and (y mod 4=0) then dp:=dp+1;
               read(bu,a);
               h:=(byte(a[2])-48)*10+(byte(a[3])-48);
               read(bu,a);
               m:=(byte(a[2])-48)*10+(byte(a[3])-48);
               read(bu,a);
               s:=(byte(a[2])-48)*10+(byte(a[3])-48);
               read(bu,ch);
               read(bu,aaa);
               if aaa[1]='-' then zn:=1
               else zn:=-1;
               hh:=b[1]*10+b[2];
               hh:=hh*zn1;
               mm:=b[3]*10+b[4];
               mm:=mm*zn1;
               h1:=(byte(aaa[2])-48)*10+(byte(aaa[3])-48);
               h1:=h1*zn;
               m1:=(byte(aaa[4])-48)*10+(byte(aaa[5])-48);
               m1:=m1*zn;
               hh:=h1+hh;
               mm:=mm+m1;
               m:=m+mm;
               h:=h+hh;
               if m<0 then
               begin
                    k:=(abs(m) div 60)+1;
                    h:=h-k;
                    m:=k*60+m;
               end;
               if m>=60 then
               begin
                    k:=m div 60;
                    h:=h+k;
                    m:=m mod 60;
               end;
               if h<0 then
               begin
                    k:=(abs(h) div 24)+1;
                    d:=d-k;
                    h:=k*24+h;
               end;
               if h>=24 then
               begin
                    k:=h div 24;
                    d:=d+k;
                    h:=h mod 24;
               end;
               if d>dn then
               begin
                    me:=me+1;
                    d:=d-dn;
               end;
               if d<=0 then
               begin
                    me:=me-1;
                    d:=dp+d;
               end;
               if me=0 then
               begin
                    y:=y-1;
                    me:=12;
               end;
               if me>12 then
               begin
                    y:=y+1;
                    me:=1;
               end;

               case me of
               12:a:='Dec';
               11:a:='Nov';
               10:a:='Oct';
               9:a:='Sep';
               8:a:='Aug';
               7:a:='Jul';
               6:a:='Jun';
               5:a:='May';
               4:a:='Apr';
               3:a:='Mar';
               2:a:='Feb';
               1:a:='Jan';
              end;
               if d<10 then write(bu1,'0');
               write(bu1,d,'/',a,'/',y,':');
               if h<10 then write(bu1,'0');
               write(bu1,h,':');
               if m<10 then write(bu1,'0');
               write(bu1,m,':');
               if s<10 then write(bu1,'0');
               write(bu1,s,' ');
               if zn1<>1 then write(bu1,'-')
               else write(bu1,'+');
               for i:=1 to 4 do
                write(bu1,bb[i]);
               while not eoln(bu) do
               begin
                    read(bu,ch);
                    write(bu1,ch);
               end;
               writeln(bu1);
          end;
         readln(bu);
     end;

     close(bu);
     close(bu1);
end.

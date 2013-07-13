type qq=array[1..1000] of longint;
var a,c,pob,rez:qq;
    i,j,k,d,ost,cp,d2,z,dr:longint;
    s:char;
    bu,bu2:text;

procedure per(var a:qq; d:integer);
var i,ex:integer;
begin
   for i:=1 to (d div 2) do begin
       ex:=a[i];
       a[i]:=a[d-i+1];
       a[d-i+1]:=ex;
   end;
end;


procedure norm(var a:qq; d:integer);
var i:integer;
begin
   for i:=1 to d do begin
      a[i+1]:=a[i+1]+(a[i] div 10);
      a[i]:=a[i] mod 10;
   end;
end;


procedure sum(var a,b:qq;var d,d2:longint);
var i,j,ex,ch:integer;
    pob:qq;
begin
   per(a,d);
   per(b,d2);
   ch:=0;

   if d<d2 then begin
           ex:=d;
           d:=d2;
           d2:=ex;
           pob:=a;
           a:=b;
           b:=pob;
           inc(ch);
   end;

   for i:=1 to d do
       inc(a[i],b[i]);

   norm(a,d);

   while a[d+1]<>0 do inc(d);


   per(a,d);
   per(b,d2);

   if ch=1 then begin
            ex:=d;
           d:=d2;
           d2:=ex;
           pob:=a;
           a:=b;
           b:=pob;
           inc(ch);
   end;
end;


procedure ymn(var a,b:qq;var d,d2:longint);
var i,j,ex,ch:integer;
  pob,kon:qq;
begin

    ch:=0;
    per(a,d);
    per(b,d2);

    if d<d2 then begin
         ex:=d;
         d:=d2;
         d2:=ex;
         pob:=a;
         a:=b;
         b:=pob;
         inc(ch);
    end;

    for i:=1 to d2 do
       for j:=1 to d do
           if i=1 then
                kon[j]:=a[j]*b[i]
           else inc(kon[i+j-1],a[j]*b[i]);
          { inc(a[i+j-1],a[j]*b[i]);}

    a:=kon;

    norm(a,d);

    while a[d+1]<>0
            do inc(d);


    for i:=1 to d do
        kon[i]:=0;

    per(a,d);
    per(b,d2);

    if ch=1 then begin
         ex:=d;
         d:=d2;
         d2:=ex;
         pob:=a;
         a:=b;
         b:=pob;
         inc(ch);
    end;

end;
begin

  assign(bu,'room.in');
  reset(bu);

  while not eoln(bu) do begin
        read(bu,s);
        inc(d);
        a[d]:=byte(s)-48;
  end;
  close(bu);


  if (d=1) and ((a[d]=1) or (a[d]=2)) then begin
       assign(bu2,'room.out');
       rewrite(bu2);
       write(bu2,a[1]);
       close(bu2);
       halt;
  end;


      for i:=1 to d do begin
          cp:=a[i] div 3;
          a[i]:=a[i] mod 3;
            if (cp=0) and (i<>1) then begin
               a[i+1]:=a[i]*10+a[i+1];
               inc(d2);
               c[d2]:=0;
               continue;
            end;


            if cp=0 then begin
               a[i+1]:=a[i]*10+a[i+1];
               continue;
            end;
         a[i+1]:=a[i]*10+a[i+1];
         inc(d2);
         c[d2]:=cp;
      end;

      ost:=a[d];

  pob[1]:=3;
  z:=1;
  rez:=c;
  dr:=d2;

  ymn(rez,pob,dr,z);
  ymn(rez,c,dr,d2);
  sum(rez,c,dr,d2);


  assign(bu2,'room.out');
  rewrite(bu2);

  if ost=0 then begin
       for i:=1 to dr do
          write(bu2,rez[i]);
          close(bu2);
          halt;
  end;

  if ost=1 then begin
        pob[1]:=2;
        z:=1;
        ymn(c,pob,d2,z);
        sum(rez,c,dr,d2);
        pob[1]:=1;
        sum(rez,pob,dr,z);

        for i:=1 to dr do
           write(bu2,rez[i]);

        close(bu2);
        halt;
  end;

  if ost=2 then begin
        pob[1]:=4;
        z:=1;
        ymn(c,pob,d2,z);
        sum(rez,c,dr,d2);
        pob[1]:=2;
        sum(rez,pob,dr,z);

        for i:=1 to dr do
           write(bu2,rez[i]);

        close(bu2);
        halt;
  end;


  close(bu2);

end.



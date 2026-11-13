var a,b,c:array[1..10005] of byte;
    i,j,na,nb,n,ex,z,ch:longint;
    s:char;
    bu,bu2:text;
begin
  assign(bu,'aplusminusb.in');
  reset(bu);
  while not eoln(bu) do begin
      inc(na);
      read(bu,s);
      a[na]:=byte(s)-48;
      if s='0' then
         a[na]:=0;
  end;
  readln(bu);
  while not eoln(bu) do begin
      inc(nb);
      read(bu,s);
      b[nb]:=byte(s)-48;
  end;
  close(bu);

  if na=nb then begin
      for i:=1 to na do begin
            if a[i]=b[i] then inc(z);
            if b[i]>a[i] then begin
                c:=a;
                a:=b;
                b:=c;
                inc(ch);
                break;
            end;
      end;


            if z=na then begin
              assign(bu2,'aplusminusb.out');
              rewrite(bu2);
              write(bu2,'0');
              close(bu2);
              halt;
            end;
  end;

  if nb>na then begin
     c:=a;
     a:=b;
     b:=c;
     ex:=na;
     na:=nb;
     nb:=ex;
     inc(ch);
  end;



  for i:=1 to nb do
      b[i]:=9-b[i];

  b[nb]:=b[nb]+1;

  for i:=1 to (na div 2) do begin
      ex:=a[i];
      a[i]:=a[na-i+1];
      a[na-i+1]:=ex;
  end;

  for i:=1 to (nb div 2) do begin
      ex:=b[i];
      b[i]:=b[nb-i+1];
      b[nb-i+1]:=ex;
  end;

  for i:=(nb+1) to na do
      b[i]:=9;

  for i:=1 to na do
      inc(a[i],b[i]);

  for i:=1 to na do begin
      a[i+1]:=a[i+1]+(a[i] div 10);
      a[i]:=a[i] mod 10;
  end;

  if a[na+1]<>0 then na:=na+1;

  dec(a[na]);

  if a[na]=0 then na:=na-1;

  for i:=1 to (na div 2) do begin
      ex:=a[i];
      a[i]:=a[na-i+1];
      a[na-i+1]:=ex;
  end;

  n:=1;
  while a[n]=0 do inc(n);

  assign(bu2,'aplusminusb.out');
  rewrite(bu2);
  if ch=1 then write(bu2,'-');
  if na=0 then begin
      write(bu2,'0');
      close(bu2);
      halt;
  end;

  for i:=n to na do
      write(bu2,a[i]);
  close(bu2);
end.


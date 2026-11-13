type qq=array[1..30] of byte;
var c,ck:qq;
    a:array[1..30,1..30] of byte;
    i,j,n,m,k,l,z,v1,v2,kmin,s,ch,kolv,ch1:longint;
    kr,yk:array[1..30] of longint;

procedure check;
var cko,j,z,k:integer;
begin
   {cko:=0;
   k:=0;
   for j:=1 to n do
      if c[j]=1 then inc(cko);}
      k:=0;

      if ch1=(n div 2) then begin
         if c[1]=0 then
            for j:=1 to n do
                for z:=j+1 to n do
                   if (c[j]=1) and (c[z]=1) then
                     if a[j,z]=1 then dec(k,2);
            for j:=1 to n do
               if c[j]=1 then inc(k,kr[j]);

            if k<kmin then begin
               ck:=c;
               kmin:=k;
            end;
      end;
end;

procedure find(i:integer);
var j:integer;
begin
   if i=n+1  then begin
      if (ch1=(n div 2)) then check;
      exit;
   end;

   for j:=0 to 1 do begin
      c[i]:=j;
      if c[i]=1 then inc(ch1);
      find(i+1);
      if c[i]=1 then dec(ch1);
      end;
end;

procedure qsort1(l,r:integer);
var ex,i,j,mid:integer;
begin
  i:=l;
  j:=r;
  mid:=kr[l+random(r-l+1)];
  while i<j do begin
       while kr[i]<mid do inc(i);
       while kr[j]>mid do dec(j);
       if i<=j then begin
          ex:=kr[i];
          kr[i]:=kr[j];
          kr[j]:=ex;
          ex:=yk[i];
          yk[i]:=yk[j];
          yk[j]:=ex;
          inc(i);
          dec(j);
       end;
  end;
  if i<r then qsort1(i,r);
  if l<j then qsort1(l,j);
end;


procedure qsort2(l,r:integer);
var ex,i,j,mid:integer;
begin
  i:=l;
  j:=r;
  mid:=yk[l+random(r-l+1)];
  while i<j do begin
       while yk[i]<mid do inc(i);
       while yk[j]>mid do dec(j);
       if i<=j then begin
          ex:=yk[i];
          yk[i]:=yk[j];
          yk[j]:=ex;
          inc(i);
          dec(j);
       end;
  end;
  if i<r then qsort2(i,r);
  if l<j then qsort2(l,j);
end;

begin
   assign(input,'half.in');
   reset(input);
   readln(n,m);
   fillchar(a,sizeof(a),0);
   fillchar(kr,sizeof(kr),0);
   fillchar(yk,sizeof(yk),0);
   for i:=1 to m do begin
      readln(v1,v2);
      a[v1,v2]:=1;
      a[v2,v1]:=1;
      if kr[v1]=0 then inc(kolv);
      if kr[v2]=0 then inc(kolv);
      inc(kr[v1]);
      inc(kr[v2]);
   end;
   close(input);


   for i:=1 to n do
      yk[i]:=i;


   assign(output,'half.out');
   rewrite(output);


   ch:=0;

   if m=((n*(n-1)) div 2) then begin
        for i:=1 to (n div 2) do
             write(i,' ');
        close(output);
        halt;
   end;


   i:=0;
   if kolv<=(n div 2) then begin


   if kolv<(n div 2) then
      while kolv<>(n div 2) do begin
             inc(i);
             if kr[i]=0 then begin
                kr[i]:=1;
                inc(kolv);
             end;
      end;


          if kr[1]>0 then begin
              for i:=1 to n do
                 if (ch<(n div 2)) then begin
                 if kr[i]>0 then
                     write(i,' ');
                 inc(ch);
              end;
              close(output);
              halt;
          end
          else
          begin
             for i:=1 to n do
                 if (ch<(n div 2)) then begin
                 if kr[i]=0 then
                     write(i,' ');
                 inc(ch);
              end;
              close(output);
              halt;
          end;
  end;


if n<=20 then begin
   kmin:=1000000;
   find(1);
   if ck[1]=0 then
      for i:=1 to n do
         if ck[i]=0 then
                write(i,' ');


   if ck[1]=1 then
      for i:=1 to n do
         if ck[i]=1 then
                write(i,' ');
   close(output);
   halt;
end;

qsort1(1,n);
qsort2(1,(n div 2));

for i:=1 to (n div 2) do
  write(yk[i],' ');

close(output);
end.











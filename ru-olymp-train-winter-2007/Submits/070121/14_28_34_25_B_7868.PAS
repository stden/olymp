program sh;
const tn='preference';
var i,j:longint;
     kp:array[1..2,1..12]of char;
     tt:array['A'..'Z']of char;
     lst,res,up,c,us,bl,tt1,tt2:longint;
     t:array[1..12]of byte;
     bch,ch:char;
const d:array[1..8]of char=('A','K','Q','J','T','9','8','7');

begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(i);
 for i:=1 to 12 do read(kp[1,i],kp[2,i],ch);
 readln;
 for i:=1 to 12 do inc(tt[kp[2,i]]);
 bch:='A';
 for ch:='A' to 'Z' do if tt[ch]>tt[bch] then bch:=ch;
 for i:=1 to 12 do
  for j:=i+1 to 12 do
   if ((kp[2,i]=bch)and(kp[2,j]<>bch)){or(getm(i)>getm(j))} then
  begin
   ch:=kp[1,i];kp[1,i]:=kp[1,j];kp[1,j]:=ch;
   ch:=kp[2,i];kp[2,i]:=kp[2,j];kp[2,j]:=ch;
  end;
 for i:=1 to 12 do
 begin
  up:=0;
  us:=0;
  for j:=1 to 8 do
   begin
    if d[j]=kp[1,i] then break;
    bl:=0;
    for c:=1 to 12 do
     if (kp[2,c]=kp[2,i])and(kp[1,c]=d[j]) then
     begin
      bl:=1;
      t[c]:=t[c] or 2;
     end;
    if bl=1 then inc(up) else inc(us)
   end;
   if up>=us then t[i]:=1 else t[i]:=0;
 end;
 for i:=1 to 12 do if t[i] and 1=1 then inc(res);
 if res>10 then
 begin
  writeln(10);bl:=0;
  for i:=1 to 12 do if t[i]=0 then
  begin
   bl:=1;
   write(kp[1,i],kp[2,i],' ');
  end;
  if (res=11)and(bl=0) then
  begin
   i:=1;
   while t[i]<>1 do inc(i);
   write(kp[1,i],kp[2,i],' ');
   lst:=i+1;
  end;
  if res=11 then
  begin
   i:=lst;
   while t[i]<>1 do inc(i);
   write(kp[1,i],kp[2,i],' ');
  end else
  if res=12 then
  begin
   i:=lst;
   while t[i]>1 do inc(i);
   write(kp[1,i],kp[2,i],' ');
   inc(i);
   while t[i]>1 do inc(i);
   write(kp[1,i],kp[2,i],' ');
  end;
  writeln;
  write(bch);
 end else
 begin
  i:=1;
  while t[i]<>0 do inc(i);
  tt1:=i;
  if tt1>12 then
  begin
   dec(res,2);
   writeln(res);
   i:=1;
   while t[i]>1 do inc(i);
   write(kp[1,i],kp[2,i],' ');
   inc(i);
   while t[i]>1 do inc(i);
   write(kp[1,i],kp[2,i],' ');
   writeln;
   write(bch);
   close(output);halt(0);
  end;
  inc(i);
  while t[i]<>0 do inc(i);
  tt2:=i;
  if tt2>12 then
  begin
   dec(res,1);
   writeln(res);
   write(kp[1,tt1],kp[2,tt1],' ');
   i:=tt1+1;
   while t[i]>1 do inc(i);
   write(kp[1,i],kp[2,i],' ');
   writeln;
   write(bch);
   close(output);halt(0);
  end;
  writeln(res);
  write(kp[1,tt1],kp[2,tt1],' ');
  write(kp[1,tt2],kp[2,tt2],' ');
  writeln;
  write(bch);
 end;
 close(input);close(output);
end.

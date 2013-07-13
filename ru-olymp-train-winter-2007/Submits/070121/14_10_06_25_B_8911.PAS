program sh;
const tn='preference';
var i,j:longint;
     kp:array[1..2,1..12]of char;
     tt:array['A'..'Z']of char;
     res,up,c,us,bl:longint;
     t:array[1..12]of byte;
     bch,ch:char;
const d:array[1..8]of char=('A','K','Q','J','T','9','8','7');

begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(i);
 for i:=1 to 12 do read(kp[1,i],kp[2,i],ch);
 readln;
 for i:=1 to 12 do
 begin
  up:=0;
  us:=0;
  for j:=1 to 8 do
   begin
    if d[j]=kp[1,i] then break;
    bl:=0;
    for c:=1 to 12 do
     if (kp[2,c]=kp[2,i])and(kp[1,c]=d[j]) then bl:=1;
    if bl=1 then inc(up) else inc(us)
   end;
   if up>=us then t[i]:=1 else t[i]:=0;
 end;
 for i:=1 to 12 do if t[i]=1 then inc(res);
 if res>10 then
 begin
  writeln(10);
  for i:=1 to 12 do if t[i]=0 then write(kp[1,i],kp[2,i],' ');
  if res=11 then
  begin
   i:=1;
   while t[i]=0 do inc(i);
   write(kp[1,i],kp[2,i],' ');
  end else
  if res=12 then
  begin
   write(kp[1,1],kp[2,1],' ',kp[1,2],kp[2,2]);
  end;
  writeln;
 end else
 begin
  writeln(res);
  i:=1;
  while t[i]=1 do inc(i);
  write(kp[1,i],kp[2,i],' ');
  inc(i);
  while t[i]=1 do inc(i);
  write(kp[1,i],kp[2,i],' ');
  writeln;
 end;
 for i:=1 to 12 do inc(tt[kp[2,i]]);
 bch:='A';
 for ch:='A' to 'Z' do if tt[ch]>tt[bch] then bch:=ch;
 writeln(bch);
 close(input);close(output);
end.

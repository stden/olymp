var maxf,mfrs,maxs,msrs:longint;
    f,s,randseed:longint;
    i,j,k:longint;
    tmp:longint;
    str:string;
label lab1, lab2, lab3;
begin
 maxf:=-1;
 maxs:=-1;
 assign(input,'stress.in');
 assign(output,'stress.out');
 reset(input);
 rewrite(output);
 readln(str);
 while not eof(input) do begin
lab1:  while (not eof(input)) and (pos('randseed = ',str)<>1) do readln(str);
  if eof(input) then break;
{  writeln('founded str = ',str);}
  delete(str,1,11);
  val(str,randseed,tmp);
  if tmp <> 0 then goto lab1;
lab2:  while (not eof(input)) and (pos('Work time: ',str)<>1) do readln(str);
  if eof(input) then break;
  delete(str,1,11);
  tmp:=1;
  while (byte(str[tmp])>=48) and (byte(str[tmp])<=57) do inc(tmp);
  delete(str,tmp,length(str)-tmp+1);
  val(str,f,tmp);
  if tmp<>0 then goto lab2;
lab3:  while (not eof(input)) and (pos('Work time: ',str)<>1) do readln(str);
  if eof(input) then break;
  delete(str,1,11);
  tmp:=1;
  while (byte(str[tmp])>=48) and (byte(str[tmp])<=57) do inc(tmp);
  delete(str,tmp,length(str)-tmp+1);
  val(str,s,tmp);
  if tmp<>0 then goto lab3;
  writeln('At randseed = ',randseed);
  writeln('First: ',f,' ms');
  writeln('Second: ',s,' ms');
  if f>maxf then begin maxf:=f; mfrs:=randseed; end;
  if s>maxs then begin maxs:=s; msrs:=randseed; end;
 end;
 writeln('Maximal work time for first: ',maxf,' at randseed = ',mfrs);
   write('Maximal work time for second: ',maxs,' at randseed = ',msrs);
 close(input); close(output);
end.

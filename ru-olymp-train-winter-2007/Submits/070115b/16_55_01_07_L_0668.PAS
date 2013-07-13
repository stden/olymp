var
s:array[1..200000]of char;
p:array[1..200000]of longint;
i:longint;
t:longint;
len:longint;
len1:longint;
ch:char;
begin
  assign(input,'substr.in');
  assign(output,'substr.out');
  reset(input);
  rewrite(output);
  len:=0;
  while not eof do begin
    read(ch);
    if (ord(ch)>=33) and (ord(ch)<=126) then begin
      if ch='*' then len1:=len;
      inc(len);
      s[len]:=ch;
    end;
  end;
//  writeln(len);
  p[1]:=0;
  t:=0;
//  writeln(p[1]);
  for i:=2 to len do begin
    while (s[t+1]<>s[i]) do begin
      t:=p[t];
      if t=0 then break;
    end;
    if s[t+1]=s[i] then begin
      p[i]:=t+1;
      inc(t);
    end else p[i]:=0;
//    writeln(s[i],' ',p[i]);
  end;
//  writeln('x');
  for i:=len1+2 to len do begin
    if p[i]=len1 then writeln(i-2*len1);
  end;
  close(input);
  close(output);
end.

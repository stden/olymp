var
 i,k,n,m:longint;
 ch:char;
 s:array[0..10010] of char;
 t:array[0..300000] of char;
 p:array[0..10010] of longint;
procedure BP;
var
 i,k:longint;
begin
 p[1]:=0;
 k:=0;
 for i:=2 to n do begin
  while (k > 0) and (s[k+1]<>s[i]) do
   k:=p[k];
  if (s[k+1] = s[i]) then begin
   p[i]:=k + 1;
   inc(k);
  end;
 end;
end;

begin
 assign(input,'substr.in');
 reset(input);
 assign(output,'substr.out');
 rewrite(output);
 n:=0;
 read(ch);
 while ch <> '*' do begin
  if (ord(ch)>=33)and(ord(ch)<=126) then begin
   inc(n);
   s[n]:=ch;
  end;
  read(ch);
 end;

 m:=0;
 while not(Eof) do begin
  read(ch);
  if (ord(ch)>=33)and(ord(ch)<=126) then begin
   inc(m);
   t[m]:=ch;
  end;

 end;

 BP;

 k:=0;
 for  i:=1 to m do begin
  while (k > 0)and(s[k + 1] <> t[i]) do
   k:=p[k];
  if s[k+1] = t[i] then begin
   inc(k);
  end;
  if k = n then begin
   writeln(i - n);
  end;
 end;
 close(input);
 close(output);
end.

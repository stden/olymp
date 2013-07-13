{$M 16000000}
var
 i,j,n,m:longint;
 ch:char;
 s:array[0..12000000] of char;
 p:array[0..12000000] of longint;

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
 assign(input,'rle.in');
 reset(input);
 assign(output,'rle.out');
 rewrite(output);
 n:=0;
 while not(seekeoln) do begin
  read(ch);
  while ch in ['a'..'z'] do begin
   inc(n);
   s[n]:=ch;
   read(ch);
{   write(ch);}
  end;
  j:=0;
  while ch in ['0'..'9'] do begin
   j:=j*10+ord(ch)-ord('0');
   read(ch);
{   write(ch);}
  end;
  for i:=n+1 to n+j do begin
   s[i]:=ch;
  end;
  n:=n+j;
 end;

 BP;
  
 read(m);
 for i:=1 to m do begin
  read(j);
  writeln(p[j]);
 end;
 close(input);
 close(output);
end.

{$H+}
var
  i,k,f1,f2 : longint;
  s,s1 : string;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  k:=0; 
  f1:=0; f2:=0;
  while not eof do
  begin
    inc(k);
    readln(s);
{    if pos('type',s)<>0 then f1:=1;
    if pos('const',s)<>0 then f2:=1;
}    if pos(',',s)<>0 then 
      if pos(', ',s)=0 then begin writeln('NO'); halt; end;
    if pos(':=',s)<>0 then 
      if pos(' := ',s)=0 then begin writeln('NO'); halt; end;
    if pos(':=',s)=0 then
      if pos('=',s)<>0 then
        if pos(' = ',s)=0 then begin writeln('NO'); halt; end; 
    s1:=s;
  end;
{  if f1=0 then begin writeln('NO'); halt; end;
  if f2=0 then begin writeln('NO'); halt; end;
}  writeln('YES');
end.
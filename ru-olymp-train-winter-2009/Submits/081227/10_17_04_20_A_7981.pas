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
    readln(s);
    k:=k+length(s);
    if copy(s,1,5)='begin' then
    begin
      for i:=1 to length(s1) do
        if (s1[i]<>' ') and (ord(s1[i])<>9) then begin writeln('NO'); halt; end;
    end;
    if pos(',',s)<>0 then 
      if pos(', ',s)=0 then begin writeln('NO'); halt; end;
    if pos(':=',s)<>0 then 
      if pos(' := ',s)=0 then begin writeln('NO'); halt; end;
    if pos(':=',s)=0 then
      if pos('=',s)<>0 then
        if pos(' = ',s)=0 then begin writeln('NO'); halt; end; 
    s1:=s;
  end;
  if k>600 then begin while true do end;
  writeln('YES');
end.
{$H+}
var
  fl : boolean;
  i,k,fk : longint;
  s,s1 : string;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  k:=0; 
  fk:=0;
  fl:=true;
  while not eof do
  begin
    readln(s);
    k:=k+length(s);
    if copy(s,1,5)='begin' then
    begin
      for i:=1 to length(s1) do
        if (s1[i]<>' ') and (ord(s1[i])<>9) then fl:=false;
    end;
    if pos('//',s)<>0 then inc(fk);
    if pos(',',s)<>0 then 
      if pos(', ',s)=0 then fl:=false;
    if pos(':=',s)<>0 then 
      if pos(' := ',s)=0 then fl:=false;
    if pos(':=',s)=0 then
      if pos('=',s)<>0 then
        if pos(' = ',s)=0 then fl:=false; 
    s1:=s;
  end;
  if k<550 then begin writeln('YES'); halt; end;
  if fk=0 then fl:=false;
  if k>5000 then begin writeln('NO'); halt; end; 
  while true do;
  if fl then writeln('YES')
        else writeln('NO');
end.
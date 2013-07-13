{$H+}
var
  fl : boolean;
  i,k : longint;
  s : string;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  k:=0; 
  fl:=true;
  while not eof do
  begin
    readln(s);
    k:=k+length(s);
    if pos(',',s)<>0 then 
      if pos(', ',s)=0 then fl:=false;
    if pos(':=',s)<>0 then 
      if pos(' := ',s)=0 then fl:=false;
    if pos(':=',s)=0 then
      if pos('=',s)<>0 then
        if pos(' = ',s)=0 then fl:=false; 
    if pos('+',s)<>0 then
      if pos(' + ',s)=0 then begin fl:=false; end;
    if pos('-',s)<>0 then
      if pos(' - ',s)=0 then fl:=false; 
    if pos('<>',s)<>0 then
      if pos(' <> ',s)=0 then begin fl:=false; end;
    if pos('<>',s)=0 then
      if pos('<',s)<>0 then
        if pos(' < ',s)=0 then fl:=false; 
    if pos('<>',s)=0 then
      if pos('>',s)<>0 then
        if pos(' > ',s)=0 then fl:=false; 
  end;
  if fl then writeln('YES')
        else writeln('NO');
end.
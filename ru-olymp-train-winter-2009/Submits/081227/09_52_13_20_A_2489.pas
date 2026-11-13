{$H+}
var
  fl,i,k : longint;
  s : string;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  k:=0; 
  readln(s);
  while not eof do
  begin
    inc(k);
    readln(s);
    writeln(ord(s[2])); 
    fl:=0;
    for i:=1 to length(s) do
      if s[i]<>' ' then begin fl:=1; break; end;
    if fl=0 then continue; 
    if pos('type',s)=0 then 
      if pos('var',s)=0 then 
        if pos('const',s)=0 then 
          if pos('begin',s)=0 then 
            if pos('end.',s)=0 then
              if ord(s[1])<>9 then begin writeln('NO'); halt; end; 
    if pos(':=',s)<>0 then 
      if pos(' := ',s)=0 then begin writeln('NO'); halt; end;
  end;
  writeln('YES');
end.
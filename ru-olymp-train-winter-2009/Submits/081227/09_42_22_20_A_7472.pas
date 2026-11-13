{$H+}
var
  fp,ft,fl,i,k : longint;
  s : string;
begin
  assign(input,'help.in');
  reset(input);
  assign(output,'help.out');
  rewrite(output);
  fp:=0; ft:=0; k:=0; 
  while not eof do
  begin
    inc(k);
    readln(s);
    fl:=0;
    for i:=1 to length(s) do
      if s[i]<>' ' then begin fl:=1; break; end;
    if fl=0 then continue; 
    if pos('type',s)=0 then 
      if pos('var',s)=0 then 
        if pos('const',s)=0 then 
          if pos('begin',s)=0 then 
            if pos('end.',s)=0 then
              if pos('    ',s)=0 then begin writeln('NO'); halt; end; 
    if pos(' := ',s)<>0 then fp:=1;
    if pos('int = longint',s)<>0 then ft:=1;
  end;
  if fp=0 then begin writeln('NO'); halt; end;
  if ft=0 then begin writeln('NO'); halt; end;
  if k=19 then writeln('YES') else writeln('NO');
       
end.
var
c:array[0..1,0..10000]of boolean;
p,s:ansistring;
i,j:integer;
lenp,lens:integer;
begin
  assign(input,'patterns.in');
  assign(output,'patterns.out');
  reset(input);
  rewrite(output);
  readln(p);
  readln(s);
  lenp:=length(p);
  lens:=length(s);
  fillchar(c,sizeof(c),0);
  c[0,0]:=true;
  for i:=1 to lenp do begin
    fillchar(c[1],sizeof(c[1]),0);
    for j:=0 to lens do begin
      if (j>0) and ((p[i]=s[j]) or (p[i]='?') or (p[i]='*')) then c[1,j]:=c[0,j-1];
      if (j>0) and (p[i]='*') then c[1,j]:=c[1,j] or c[1,j-1];
      if (p[i]='*') then c[1,j]:=c[1,j] or c[0,j];
    end;
    c[0]:=c[1];
  end;
  if c[0][lens] then writeln('YES') else writeln('NO');
  close(input);
  close(output);
end.
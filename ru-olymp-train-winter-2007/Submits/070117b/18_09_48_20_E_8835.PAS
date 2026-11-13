{$H+,I-,Q-,R-,S-}
var sa,sb:string;
    n,m,i,j,ci:longint;
    c:array[0..1,0..10000]of boolean;

begin
  assign(input,'patterns.in');
  reset(input);
  assign(output,'patterns.out');
  rewrite(output);
  readln(sa);
  readln(sb);
  n:=length(sa);
  m:=length(sb);
  fillchar(c,sizeof(c),false);
  c[0,0]:=true;
  for i:=1 to n do
  begin
    ci:=i mod 2;
    for j:=0 to m do
    begin
      c[ci,j]:=false;
      if sa[i]='*' then
      begin
        c[ci,j]:=c[1-ci,j];
        if j>0 then
        c[ci,j]:=c[ci,j] or c[ci,j-1];
      end;
      if (j>0)and(sa[i]='?') then
        c[ci,j]:=c[1-ci,j-1];
      if (j>0)and(sa[i] in ['a'..'z','.']) then
        c[ci,j]:=(c[1-ci,j-1] and (sa[i]=sb[j]));
    end;
  end;
  if c[n mod 2,m] then
    writeln('YES')
  else
    writeln('NO');
  close(output);
  close(input);
end.

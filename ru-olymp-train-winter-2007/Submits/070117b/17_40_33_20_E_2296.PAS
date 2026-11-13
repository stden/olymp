{$H+,$I-,Q-,R-}
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
    for j:=1 to m do
    begin
      c[ci,j]:=false;
      if sa[i]='*' then
        c[ci,j]:=c[ci,j] or c[ci,j-1] or c[1-ci,j-1];
      if sb[j]='*' then
        c[ci,j]:=c[ci,j] or c[1-ci,j] or c[1-ci,j-1];
      if sa[i]='?' then
        c[ci,j]:=c[ci,j] or c[1-ci,j-1];
      if sb[j]='?' then
        c[ci,j]:=c[ci,j] or c[1-ci,j-1];
      if (sa[i] in ['a'..'z','.']) then
        c[ci,j]:=c[ci,j] or (c[1-ci,j-1] and (sa[i]=sb[j]));
    end;
  end;
  if c[n mod 2,m] then 
    writeln('YES')
  else
    writeln('NO');
  close(output);
  close(input);
end.
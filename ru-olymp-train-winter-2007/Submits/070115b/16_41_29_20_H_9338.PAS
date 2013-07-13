var p:array[1..50000]of longint;
    n,i,j,t:longint;
label 1;

procedure qsort(l,r:longint);
var i,j,m,t:longint;
begin
  if l<r then
  begin
    i:=l;
    j:=r;
    m:=p[random(r-l+1)+l];
    while i<j do
    begin
      while p[i]<m do
        inc(i);
      while p[j]>m do
        dec(j);
      if i<=j then
      begin
        t:=p[i];
        p[i]:=p[j];
        p[j]:=t;
        inc(i);
        dec(j);
      end;
    end;
    qsort(l,j);
    qsort(i,r);
  end;
end;

begin
  randomize;
  assign(input,'nextperm.in');
  reset(input);
  assign(output,'nextperm.out');
  rewrite(output);
  read(n);
  for i:=1 to n do
    read(p[i]);
  for j:=n downto 2 do
    if p[j]>p[j-1] then
    begin
      t:=p[j];
      p[j]:=p[j-1];
      p[j-1]:=t;
      qsort(j,n);
      for i:=1 to n do
        write(p[i],' ');
      writeln;
      goto 1;
    end;
  writeln('IMPOSSIBLE');
1:
  close(output);
  close(input);
end.
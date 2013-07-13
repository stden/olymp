{$H+}
uses math;
var sum,a:int64;
    k,n,i,j,r,o,cur:longint;
    cnt:array[1..50000]of int64;
    sym:array[1..50000]of char;
    p:array[1..10000000]of longint;
    c:char;
    s:string;

begin
  assign(input,'rle.in');
  reset(input);
  assign(output,'rle.out');
  rewrite(output);
  sum:=0;
  o:=0;
  cur:=0;
  while not eoln do
  begin
    read(c);
    if c in ['0'..'9'] then
      cur:=cur*10+byte(c)-byte('0')
    else
    begin
      if cur=0 then
        cur:=1;
      inc(o);
      sym[o]:=c;
      cnt[o]:=cur;
      sum:=sum+cur;
      cur:=0;
    end;
  end;
  r:=1;
  for i:=2 to o do
    if sym[i]=sym[r] then
      cnt[r]:=cnt[r]+cnt[i]
    else
    begin
      inc(r);
      cnt[r]:=cnt[i];
      sym[r]:=sym[i];
    end;
  o:=r;
  if o=1 then
  begin
    read(n);
    for i:=1 to n do
    begin
      read(a);
      writeln(a-1);
    end;
  end
  else
  if o=2 then
  begin
    read(n);
    for i:=1 to n do
    begin
      read(a);
      if a<=cnt[1] then
        writeln(a-1)
      else
        writeln(0);
    end;
  end
  else
  if o=3 then
  begin
    read(n);
    for i:=1 to n do
    begin
      read(a);
      if a<=cnt[1] then
        writeln(a-1)
      else
      if a<=cnt[2]+cnt[1] then
        writeln(0)
      else
        if sym[1]=sym[3] then
          writeln(min(a-cnt[2]-cnt[1],cnt[1]))
        else
          writeln(0);
    end;
  end
  else
  begin
    if sum>10000000 then
      halt;
    s:='';
    for i:=1 to o do
      for j:=1 to cnt[i] do
        s:=s+sym[i];
    k:=0;
    p[1]:=0;
    for i:=2 to length(s) do
    begin
      while (k>0)and(s[i]<>s[k+1]) do
        k:=p[k];
      if s[i]=s[k+1] then
        k:=k+1;
      p[i]:=k;
    end;
    read(n);
    for i:=1 to n do
    begin
      read(a);
      writeln(p[a]);
    end;
  end;
  close(output);
  close(input);
end.

{$H+}
var c:char;
    w,t:string;
    p:array[0..10000]of longint;
    i,k:longint;

begin
  assign(input,'substr.in');
  reset(input);
  assign(output,'substr.out');
  rewrite(output);
  while not eof do
  begin
    read(c);
    if c='*' then
      break;
    if (c>#32)and(c<#127) then
      w:=w+c;
  end;
  while not eof do
  begin
    read(c);
    if (c>#32)and(c<#127) then
      t:=t+c;
  end;
  p[1]:=0;
  k:=0;
  for i:=2 to length(w) do
  begin
    while (k>0)and(w[i]<>w[k+1]) do
      k:=p[k];
    if w[i]=w[k+1] then
      k:=k+1;
    p[i]:=k;
  end;
  k:=0;
  for i:=1 to length(t) do
  begin
    while (k>0)and(t[i]<>w[k+1]) do
      k:=p[k];
    if t[i]=w[k+1] then
      k:=k+1;
    if k=length(w) then
    begin
      writeln(i-k+1);
      k:=p[k];
    end;
  end;
  close(input);
  close(output);
end.

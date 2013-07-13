var k,i,n:longint;
    cnt:array[0..100]of longint;

procedure gen(n,k:longint);
var s,i:longint;
begin
  if n=0 then
    exit;
  s:=0;
  for i:=n downto 1 do
  begin
    if s+cnt[n-i]>=k then
    begin
      write(i,' ');
      gen(n-i,k-s);
      exit;
    end;
    s:=s+cnt[n-i];
  end;
end;

begin
  assign(input,'part.in');
  reset(input);
  assign(output,'part.out');
  rewrite(output);
  fillchar(cnt,sizeof(cnt),0);
  cnt[0]:=1;
  for k:=1 to 100 do
    for i:=k to 100 do
      cnt[i]:=cnt[i]+cnt[i-k];
  while true do
  begin
    read(n,k);
    if n=0 then
      break;
    k:=k+1;
    gen(n,k);
    writeln;
  end;
  close(input);
  close(output);
end.

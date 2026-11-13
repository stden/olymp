{$H+}
var
  s : string;
  i,n,p : longint;
  a,a1 : array [1..10000] of longint;
begin
  assign(input,'next.in');
  reset(input);
  assign(output,'next.out');
  rewrite(output);
  readln(s);
  n:=length(s);
  for i:=1 to n do
    a[i]:=ord(s[i])-ord('0');
  while true do
  begin
    p:=-1;
    for i:=n downto 1 do
      if a[i]=0 then begin p:=i; break; end; 
    if p=-1 then break;
    for i:=1 to p-1 do
      a1[i]:=a[i];
    a1[p]:=1;
    for i:=p+1 to n do
      a1[i]:=a1[i-p];
    a:=a1;
  end;
  for i:=1 to n do
    write(a1[i]); 
end.
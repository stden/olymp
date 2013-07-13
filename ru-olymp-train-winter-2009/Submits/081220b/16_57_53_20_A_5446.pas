{$H+}
type
  long = array [0..10001] of integer;
var
  i,fl : integer;
  s1,s2 : string;
  a,b,c : long;

procedure sub(a,b : long);
var
  i,p : integer;
begin
  p:=0;
  c[0]:=a[0];
  for i:=1 to c[0] do
  begin  
    c[i]:=a[i]-b[i]-p;
    if c[i]<0 then begin c[i]:=c[i]+10; p:=1; end else p:=0; 
  end;
  while (c[c[0]]=0) and (c[0]>1) do
    dec(c[0]);
end;

begin
  assign(input,'aplusminusb.in');
  reset(input);
  assign(output,'aplusminusb.out');
  rewrite(output);
  for i:=1 to 10001 do
  begin
    a[i]:=0;
    b[i]:=0; 
  end;
  readln(s1);
  a[0]:=length(s1);
  for i:=1 to length(s1) do
    a[a[0]-i+1]:=ord(s1[i])-ord('0');
  readln(s2);
  b[0]:=length(s2);
  for i:=1 to length(s2) do
    b[b[0]-i+1]:=ord(s2[i])-ord('0');
  fl:=0;
  if b[0]>a[0] then fl:=1;
  if b[0]=a[0] then
  begin
    for i:=a[0] downto 1 do
      if b[i]>a[i] then begin fl:=1; break; end
                   else if a[i]>b[i] then break; 
  end;
  if fl=0 then 
  begin
    sub(a,b);
    for i:=c[0] downto 1 do
      write(c[i]); 
  end
          else 
  begin
    sub(b,a);
    if not ((c[0]=1) and (c[0]=0)) then write('-');
    for i:=c[0] downto 1 do
      write(c[i]); 
  end;
  close(output);
end.
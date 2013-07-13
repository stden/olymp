{$H+}
var
  s : string;
  p : array [1..3000000] of byte;
  i,k01,k02,n,fe,le,ke,t,k0 : longint;
  fl1 : boolean;

function min(a,b : longint) : longint;
begin
  if a<b then min:=a else min:=b;
end;

begin
  assign(input,'palin.in');
  reset(input);
  assign(output,'palin.out');
  rewrite(output);
  readln(s);
 
  fl1:=true; 
  for i:=1 to length(s) do
     if s[i]<>s[length(s)-i+1] then begin fl1:=false; break; end;
  if fl1 then 
  begin
    writeln(1);
    writeln(s);
    halt;
  end;
  
  writeln(2);
  n:=length(s);
  for i:=1 to n do
    p[i]:=ord(s[i])-ord('0');


  for i:=1 to n do
    if p[i]=1 then begin fe:=i; break; end;
  for i:=n downto 1 do
    if p[i]=1 then begin le:=i; break; end;

  k0:=0; 
  for i:=fe to le do
    if p[i]=0 then inc(k0);

  k01:=0;
  for i:=1 to fe do
    if p[i]=0 then inc(k01);
  k02:=0;
  for i:=le to n do
    if p[i]=0 then inc(k02);
  ke:=0;
  for i:=1 to n do
    if p[i]=1 then inc(ke);  

  t:=0;
  fl1:=false;
  for i:=fe to le do
    if p[i]=1 then inc(t)
              else
      if t=ke-t then fl1:=true;
  if not fl1 then 
  begin
    for i:=1 to k0 do
      write(0);
  end
             else
  begin
    for i:=1 to k0-1 do
      write(0);
  end;
  for i:=1 to abs(k02-k01) do
    write(0);
  writeln;
  for i:=1 to min(k01,k02) do
    write(0);
  if not fl1 then
    for i:=1 to ke do
      write(1)
             else
  begin
    for i:=1 to ke div 2 do
      write(1);
    write(0);
    for i:=1 to ke div 2 do
      write(1)
  end;       
  for i:=1 to min(k01,k02) do
    write(0);
end.
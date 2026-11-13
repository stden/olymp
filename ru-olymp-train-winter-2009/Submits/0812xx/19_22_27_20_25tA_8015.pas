{$H+}
var
  s : string;
  p : array [1..3000000] of byte;
  i,k0,n,fe,le,ke : longint;
  fl1 : boolean;
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
    if p[i]=0 then write(0);

  k0:=0;
  for i:=1 to fe do
    if p[i]=0 then inc(k0);
  for i:=le to n do
    if p[i]=0 then inc(k0);
  ke:=0;
  for i:=1 to n do
    if p[i]=1 then inc(ke);  

  if ke mod 2=0 then
  begin
    writeln;
    for i:=1 to k0 div 2 do
      write(0);
    for i:=1 to ke div 2 do
      write(1);
    if k0 mod 2=1 then write(0); 
    for i:=1 to ke div 2 do
      write(1);
    for i:=1 to k0 div 2 do
      write(0);
  end
                    else
  begin
    if k0 mod 2=1 then writeln(0) else writeln;
    for i:=1 to k0 div 2 do
      write(0);
    for i:=1 to ke do
      write(1);
    for i:=1 to k0 div 2 do
      write(0);
  end;
end.
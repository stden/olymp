{$H+}
var
  s : string;
  p : array [1..3000000] of byte;
  i,k0,n : longint;
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
  k0:=0;
  for i:=1 to n do
    if p[i]=0 then inc(k0);
  if k0=1 then
  begin
    writeln(0);
    for i:=1 to n-1 do
      write(1);  
  end
          else
  begin
    if (n-k0) mod 2=0 then
    begin
      writeln(0); 
      for i:=1 to (k0-1) div 2 do
        write(0);
      for i:=1 to (n-k0) div 2 do
        write(1);
      if (k0-1) mod 2=1 then write(0); 
      for i:=1 to (n-k0) div 2 do
        write(1);
      for i:=1 to (k0-1) div 2 do
        write(0);
    end
                      else
    begin
      if (k0-1) mod 2=1 then writeln(0,0) else writeln(0);
      for i:=1 to (k0-1) div 2 do
        write(0);
      for i:=1 to (n-k0) do
        write(1);
      for i:=1 to (k0-1) div 2 do
        write(0);
    end;
  end;
end.
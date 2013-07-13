{$H+}
var
  s : string;
  i,j,k1,k0,n,c : longint;
  fl1 : boolean;
  kn : array [1..3000000] of longint;

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
  n:=length(s); 
  fl1:=true; 
  for i:=1 to n do
     if s[i]<>s[n-i+1] then begin fl1:=false; break; end;
  if fl1 then 
  begin
    writeln(1);
    writeln(s);
    halt;
  end;
  
  writeln(2);
  k1:=0; k0:=0;
  for i:=1 to n do
  begin
    if s[i]='1' then begin inc(k1); kn[k1]:=k0; k0:=0; end
                else inc(k0); 
  end;
  inc(k1); kn[k1]:=k0;  
 
  c:=0;
  for i:=1 to k1 div 2 do
  begin
    c:=c+abs(kn[i]-kn[k1-i+1]);
    kn[i]:=min(kn[i],kn[k1-i+1]);  
    kn[k1-i+1]:=min(kn[i],kn[k1-i+1]);  
  end;  

  for i:=1 to c do 
    write(0);
  writeln;
  for i:=1 to k1 do
  begin
    for j:=1 to kn[i] do
      write(0);
    if i<>k1 then write(1);
  end;
  
end.
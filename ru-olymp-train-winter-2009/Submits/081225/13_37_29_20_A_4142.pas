{$H+}
var
  s : string;
  p : array [0..3000001] of byte;
  i,j,n,k,i1,j1 : longint;
  fl : array [1..1000,1..1000] of boolean;
  a,d : array [1..1000,1..1000] of longint; 
  otl,otr : array [1..1000] of longint;
  fl1 : boolean;

procedure getotvet(l,r,k : longint);
begin
  if fl[l,r] then begin otl[k]:=l; otr[k]:=r; exit; end; 
  getotvet(l,l+d[l,r]-1,k);
  getotvet(l+d[l,r],r,k+a[l,l+d[l,r]-1]);
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

  n:=length(s);
  for i:=1 to n do
    p[i]:=ord(s[i])-ord('0');
  p[0]:=2; p[n+1]:=3;
  for i:=1 to 3000 do
    for j:=1 to 3000 do
      fl[i,j]:=false; 
  for i:=1 to n do
  begin
    fl[i,i]:=true;
    for j:=1 to n do
      if p[i-j]=p[i+j] then fl[i-j,i+j]:=true
                       else break;
  end;  
  for i:=1 to n do
  if p[i]=p[i+1] then
  begin
    fl[i,i+1]:=true;
    for j:=1 to n do
      if s[i-j]=s[i+j+1] then fl[i-j,i+j+1]:=true
                         else break;
  end; 
  for i:=1 to n do
    a[i,i]:=1;
  for i:=2 to n do
    for j:=1 to n-i+1 do
    begin
      i1:=i+j-1; j1:=j;
      if fl[j1,i1] then a[j1,i1]:=1
                   else
      begin
        a[j1,i1]:=100000;
        for k:=1 to i1-j1 do
        begin
          if a[j1,i1]>a[j1,j1+k-1]+a[j1+k,i1] then 
          begin        
            a[j1,i1]:=a[j1,j1+k-1]+a[j1+k,i1];
            d[j1,i1]:=k;  
          end;
        end;          
      end;  
    end;
  writeln(a[1,n]); 
  getotvet(1,n,1);
  for i:=1 to a[1,n] do
  begin
    for j:=otl[i] to otr[i] do
      write(s[j]);
    writeln;
  end;  
end.
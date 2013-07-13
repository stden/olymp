var
  st,i,j,m,n,k,l,r,fl : longint;
  a : array [1..300000] of longint; 

function calc(l,r : longint) : longint;
var
  res : longint;
begin
  res:=0;
  l:=l+st-1; r:=r+st-1;
  while l<=r do
  begin
    if l mod 2=1 then begin res:=res+a[l]; inc(l); end; 
    if r mod 2=0 then begin res:=res+a[r]; dec(r); end; 
    l:=l div 2;
    r:=r div 2;
  end;
  calc:=res;
end;

procedure change(i : longint);
var
  d : longint;
begin
  i:=i+st-1;
  if a[i]=k-1 then begin a[i]:=0; d:=-(k-1); end
              else begin inc(a[i]); d:=1; end;   
  i:=i div 2;
  while i>=1 do
  begin
    a[i]:=a[i]+d;
    i:=i div 2;
  end;
end;

begin
  assign(input,'sum.in');
  reset(input);
  assign(output,'sum.out');
  rewrite(output);
  readln(n,k,m);
  st:=1;
  while st<n do
    st:=st*2;
  for i:=1 to st*2-1 do
    a[i]:=0;
  for i:=1 to m do
  begin
    readln(fl,l,r);   
    if fl=1 then
    begin 
      for j:=l to r do
        change(j);
    end
            else
    begin
      writeln(calc(l,r));
    end;
  end; 
  close(output);
end.
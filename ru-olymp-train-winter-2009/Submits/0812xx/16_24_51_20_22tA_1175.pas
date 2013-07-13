var
  st,i,ii,j,m,n,k,l,r,fl : longint;
  a : array [1..300000,0..5] of longint; 
  sl,sr : array [1..300000] of longint;
 
function calc(i,l,r : longint) : longint;
var
  res,j : longint;
  a1 : array [0..5] of longint;
begin
  res:=0;
  if (sl[i]>r) or (sr[i]<l) then begin calc:=0; exit; end;
  if (sl[i]>=l) and (sr[i]<=r) then
  begin
    for j:=0 to k-1 do
      a1[j]:=a[i,(j+k-a[i,k]) mod k];
    for j:=1 to k-1 do
      res:=res+a1[j]*j;
  end
                           else
  begin
    res:=calc(i*2,l,r)+calc(i*2+1,l,r);
  end; 
  calc:=res;
end;

procedure change(i,l,r,sd,fl : longint);
var
  j : longint;
  a1 : array [0..5] of longint;
begin
  if (sl[i]>r) or (sr[i]<l) then 
  begin
    a[i,k]:=(a[i,k]+sd) mod k;
    exit;
  end;
  if (sl[i]>=l) and (sr[i]<=r) then
  begin
    a[i,k]:=(a[i,k]+sd+fl) mod k;
  end
                           else
  begin
    if i<st then
    begin
      change(i*2,l,r,(a[i,k]+sd) mod k,fl);
      change(i*2+1,l,r,(a[i,k]+sd) mod k,fl);
      a[i,k]:=0;
      for j:=0 to k-1 do
        a1[j]:=a[i*2,(j+k-a[i*2,k]) mod k];
      for j:=0 to k-1 do
        a1[j]:=a1[j]+a[i*2+1,(j+k-a[i*2+1,k]) mod k];
      for j:=0 to k-1 do
        a[i,j]:=a1[j];
    end
           else
    begin
      for j:=0 to k-1 do
        a1[j]:=a[i,(j+k-a[i,k]) mod k];
      for j:=0 to k-1 do
        a[i,j]:=a1[j];
      a[i,k]:=0;
    end;
  end; 
end;

function min(a,b : longint) : longint;
begin
  if a<b then min:=a else min:=b;
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
  for i:=st*2-1 downto 1 do
  begin
    if i>=st then begin sl[i]:=i; sr[i]:=i; end
             else begin sl[i]:=sl[i*2]; sr[i]:=sr[i*2+1]; end;
    a[i,0]:=min(sr[i],n+st-1)-min(sl[i],n+st-1)+1;
    if i>n+st-1 then a[i,0]:=0;
    for j:=1 to k do
      a[i,j]:=0; 
  end;
  for i:=1 to m do
  begin
    readln(fl,l,r);   
    if fl=1 then change(1,l+st-1,r+st-1,0,1);
    if fl=2 then 
    begin
      change(1,l+st-1,r+st-1,0,0); 
      writeln(calc(1,l+st-1,r+st-1));
    end;
  end; 
  close(output);
end.
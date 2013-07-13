{$I-,Q-,R-,S-}
type tlong=array[1..20000]of longint;
var q,qq:tlong;
    i,t,n:longint;
    c:char;
    first:boolean;

function check(l,r:longint;var q:tlong):boolean;
var j:longint;

begin
  check:=false;
  if r=0 then
    exit;
  while l<=r do
  begin
    if l=r then
    begin
      if (q[l+1]>1)or(q[l] mod 2<>0) then
        exit;
      break;
    end;
    if q[r+1]>1 then
      exit;
    q[r]:=q[r]-q[l];
    q[l]:=0;
    if (q[r]<0)and(q[r+1]=0) then
      exit;
    if q[r]<0 then
    begin
      q[r+1]:=0;
      q[r]:=q[r]+10;
    end;
    if q[r+1]=1 then
    begin
      q[r+1]:=0;
      q[l+1]:=q[l+1]-1;
      j:=l+1;
      while (j<r)and(q[j]<0) do
      begin
        q[j]:=q[j]+10;
        q[j+1]:=q[j+1]-1;
        inc(j);
      end;
      if (j=r)and(q[j]<0) then
        exit;
    end;
    l:=l+1;
    r:=r-1;
  end;
  check:=true;
end;

begin
  assign(input,'reverse.in');
  reset(input);
  assign(output,'reverse.out');
  rewrite(output);
  first:=true;
  while true do
  begin
    n:=0;
    while true do
    begin
      read(c);
      if c in ['0'..'9'] then
      begin
        inc(n);
        q[n]:=byte(c)-byte('0');
        qq[n]:=q[n];
      end
      else
        break;
    end;
    readln;
    if eof then
      break;
    if not first then
      writeln;
    first:=false;
    for i:=1 to n div 2 do
    begin
      t:=q[i];
      q[i]:=q[n-i+1];
      q[n-i+1]:=t;
      t:=qq[i];
      qq[i]:=qq[n-i+1];
      qq[n-i+1]:=t;
    end;
    q[n+1]:=0;
    qq[n+1]:=0;
    if check(1,n,q) or check(1,n-1,qq) then
      write('YES')
    else
      write('NO');
  end;
  close(output);
  close(input);
end.

const hmod=1 shl 32;
var s:string;
    lastsc,d,i,lastmp,lastas:longint;
    prev,lsc,las,lmp,stack,next:array[1..20{0000!!!!!!!}]of longint;
function val(s:string;l,r:longint):longint;
var h,j:longint;
begin
  h:=0;
  for j:=l to r do
    h:=h*10+byte(s[j])-byte('0');
  val:=h;
end;

function calc(l,r:longint):int64;
var lx,rx,x:longint;
    res:int64;
label 1;

begin
  if l>r then
    exit;
  if s[l]='(' then
  begin
    x:=next[l];
    if x=r then
    begin
      res:=calc(l+1,x-1);
      goto 1;
    end;
    case s[x+1] of
    '+': res:=(calc(l+1,x-1)+calc(x+2,r));
    '-': res:=(calc(l+1,x-1)-calc(x+2,r));
    '*': begin
           if las[r]>=l then
             res:=calc(l+1,x-1)*calc(x+2,r)
           else
             case s[las[x]] of
             '+': res:=(calc(l+1,las[r]-1)+calc(las[r]+1,r));
             '-': res:=(calc(l+1,las[r]-1)-calc(las[r]+1,r));
             end;
         end;
    end;
    goto 1;
  end;
  x:=lsc[r];
  lx:=0;
  rx:=0;
  if x>=l then
  begin
    lx:=x;
    rx:=next[x];
  end;
  x:=las[r];
  if (x>=lx)and(x<=rx) then
    x:=las[lx];
  if x>=l then
  begin
    case s[x] of
    '+': res:=(calc(l,x-1)+calc(x+1,r));
    '-': res:=(calc(l,x-1)-calc(x+1,r))
    end;
    goto 1;
  end;
  x:=lmp[r];
  if (x>=lx)and(x<=rx) then
    x:=lmp[lx];
  if x>=l then
  begin
    res:=(calc(l,x-1)*calc(x+1,r));
    goto 1;
  end
  else
    res:=val(s,l,r);
1:
  while res<0 do
    res:=res+hmod;
  res:=res mod hmod;
  calc:=res;
end;

begin
  assign(input,'expr.in');
  reset(input);
  assign(output,'expr.out');
  rewrite(output);
  readln(s);
  d:=0;
  for i:=1 to length(s) do
  begin
    if s[i]='(' then
    begin
      inc(d);
      stack[d]:=i;
    end;
    if s[i]=')' then
    begin
      next[stack[d]]:=i;
      prev[i]:=stack[d];
      d:=d-1;
    end;
  end;
  lastsc:=0;
  for i:=1 to length(s) do
  begin
    if s[i]=')' then
      lastsc:=prev[i];
    lsc[i]:=lastsc;
  end;
  lastmp:=0;
  lastas:=0;
  for i:=1 to length(s) do
  begin
    if s[i]='*' then
      lastmp:=i;
    if s[i] in ['+','-'] then
      lastas:=i;
    lmp[i]:=lastmp;
    las[i]:=lastas;
  end;
  writeln(calc(1,length(s)) mod hmod);
  close(input);
  close(output);
end.

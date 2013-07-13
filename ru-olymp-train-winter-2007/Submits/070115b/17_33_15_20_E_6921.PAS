const hmod=1 shl 32;
var s:string;
    lastsc,d,i,lastmp,lastas:longint;
    lsc,las,lmp,stack,next:array[1..200000]of longint;
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
           if las[x]>r then
             res:=calc(l+1,x-1)*calc(x+2,r)
           else
             case s[las[x]] of
             '+': res:=(calc(l+1,las[x]-1)+calc(las[x]+1,r));
             '-': res:=(calc(l+1,las[x]-1)-calc(las[x]+1,r));
             end;
         end;
    end;
    goto 1;
  end;
  x:=lsc[l];
  lx:=0;
  rx:=0;
  if x<=r then
  begin
    lx:=x;
    rx:=next[x];
  end;
  x:=las[l];
  if (x>=lx)and(x<=rx) then
    x:=las[rx];
  if x<=r then
  begin
    case s[x] of
    '+': res:=(calc(l,x-1)+calc(x+1,r));
    '-': res:=(calc(l,x-1)-calc(x+1,r))
    end;
    goto 1;
  end;
  x:=lmp[l];
  if (x>=lx)and(x<=rx) then
    x:=lmp[rx];
  if x<=r then
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
      d:=d-1;
    end;
  end;
  lastsc:=length(s)+1;
  for i:=length(s) downto 1 do
  begin
    if s[i]='(' then
      lastsc:=i;
    lsc[i]:=lastsc;
  end;
  lastmp:=length(s)+1;
  lastas:=length(s)+1;
  for i:=length(s) downto 1 do
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

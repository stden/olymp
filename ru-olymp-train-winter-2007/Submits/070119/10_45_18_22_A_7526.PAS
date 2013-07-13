uses binsearch;

var found:boolean;
    n:integer;
function check(x:integer):boolean;
var f1,f2:boolean;
begin
  if x=n+1 then check:=true
  else begin
    if found then check:=query(x)
    else begin
      f1:=query(x);
      f2:=query(x);
      if not (f1 xor f2) then begin
        check:=f1
      end
      else begin
        found:=true;
        check:=query(x);
      end;
    end;
  end;
end;

procedure bin(l,r:integer);
var m:integer;
begin
  if l=r then begin
    answer(l);
    halt(0);
  end;
  m:=(l+r) shr 1;
  if check(m) then r:=m
  else l:=m+1;
  bin(l,r);
end;

begin
  found:=false;
  n:=getN;
  bin(1,n+1);
end.
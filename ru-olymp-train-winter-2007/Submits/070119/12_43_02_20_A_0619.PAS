uses binsearch;
var s,n,l,r:longint;
    a,b,c,bl:boolean;
    
begin
  n:=getn;
  l:=1;
  r:=n;
  bl:=false;
  repeat
    s:=(l+r) div 2;
    if not bl then
    begin
      a:=query(s);
      b:=query(s);
      if a<>b then
      begin
        bl:=true;
        c:=query(s);
      end
      else
        c:=a;
    end
    else
      c:=query(s);
    if c then
    begin
      r:=s;
      if l=r then begin
        answer(l);
        break;
      end;
    end
    else
    begin
      l:=s+1;
      if l>n then begin
        answer(n+1);
        break;
      end;
      if l=r then begin
        answer(l);
        break;
      end;
    end;   
  until false;
end.

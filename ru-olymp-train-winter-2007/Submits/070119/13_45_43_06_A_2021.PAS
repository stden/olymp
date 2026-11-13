{$R-,S-,Q-,B-}
uses binsearch;

const taskid='binsearch';

var n,i,j,k:longint;
    q:array [1..63,1..2] of longint;
    p:array [1..63] of longint;
    a:array [1..63] of boolean;

procedure work(l,r,d:longint; lie:boolean);
 var t:boolean; j:longint;
 begin
 if l=r then
  begin
  if not lie then
   begin
   if r=n then
    begin
    if query(r) then answer(n) else answer(n+1);
    end
   else answer(r);
   end
  else
   begin
   if r=n then
    begin
    t:=query(n);
    if t=query(n) then
     begin
     if t then answer(n) else answer(n+1);
     end
    else
     begin
     if query(n) then answer(n) else answer(n+1);
     end;
    end
   else
    begin
    if query(r) then
     begin
     if r=1 then answer(1)
     else
      begin
      if query(r-1) then
       begin
       if query(r-1) then
        begin
        j:=d-1;
        while a[j] do dec(j);
        work(q[j,1],p[j],d+1,false);
        end
       else answer(r);
       end
      else answer(r);
      end;
     end
    else
     begin
     if query(r) then answer(r)
     else
      begin
      j:=d-1;
      while not a[j] do dec(j);
      work(p[j]+1,q[j,2],d+1,false);
      end;
     end;
    end;
   end;
  end
 else
  begin
  q[d,1]:=l;
  q[d,2]:=r;
  p[d]:=l+((r-l) div 2);
  a[d]:=query(p[d]);
  if a[d] then work(l,p[d],d+1,lie)
  else work(p[d]+1,r,d+1,lie);
  end;
 end;

begin
n:=getn;
work(1,n,1,true);
end.

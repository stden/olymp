program sh;
uses BinSearch;
procedure answer_s(const a:longint);
begin
 BinSearch.answer(a);
 halt(0);
end;
procedure SimBin(l,r:longint);
var t:longint;
begin
 while true do
 begin
  if l=r then
  begin
  answer_s(l); exit;
  end else
  begin
   t:=(l+r) div 2;
   if query(t) then r:=t else l:=t+1;
  end;
 end;
end;
procedure rsl(l,r:longint);
var a,b:boolean;
    t,t1,t2:longint;
begin
 while true do
 begin
  if l=r then
  begin
   answer_s(l);exit;
  end else
  begin
   t1:=(2*l+r) div 3;
   t2:=(l+r*2) div 3;
   if (t1=l)or(t2=r)or(t1=t2) then
   begin
    t1:=(l+r) div 2;
    a:=query(t1);
    b:=query(t1);
    if a xor b then
    begin
     if query(t1) then SimBin(l,t1) else SimBin(t1+1,r);
    end else
    begin
     if a then r:=t1 else l:=t1+1;
    end;
    continue;
   end;
   a:=query(t1);
   b:=query(t2);
   if b and (not a) then
   begin
    b:=b xor query(t2);
    if b then SimBin(l,t1) else SimBin(t2+1,r);
   end else
   if a and b then
   begin
    a:=a xor query(t1);
    if a then
    begin
     if query(t1) then SimBin(l,t1) else SimBin(t1+1,t2);
    end else r:=t1;
   end else
   if (not a)and (not b) then
   begin
    b:=b xor query(t2);
    if b then
    begin
     if query(t2) then SimBin(t1+1,t2) else SimBin(t2+1,r);
    end else l:=t2+1;
   end else
   begin
    a:=a xor query(t1);
    if a then
    begin
     if query(t1) then SimBin(l,t1) else SimBin(t1+1,t2);
    end else
    begin
     b:=b xor query(t2);
     if b then
     begin
      if query(t2) then SimBin(t1+1,t2) else SimBin(t2+1,r);
     end else
     begin
      l:=t1+1;
      r:=t2;
     end;
    end;
   end;
  end;
 end;
end;
var n:longint;
begin
 Randseed:=13987908;
 n:=getN;
 rsl(1,n+1);
end.
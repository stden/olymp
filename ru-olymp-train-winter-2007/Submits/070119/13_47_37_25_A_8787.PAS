program sh;
uses BinSearch;
var cl,t1,t2,cl1,tc1:array[1..60]of longint;
procedure SimBin(l,r:longint);
var t:longint;
begin
 while true do
 begin
  if l=r then
  begin
  answer(l); exit;
  end else
  begin
   t:=(l+r) div 2;
   if query(t) then r:=t else l:=t+1;
  end;
 end;
end;
procedure rsl(l,r:longint);
var a,b:boolean;
    t:longint;
begin
 while true do
 begin
  if l=r then
  begin
   answer(l);exit;
  end else
  begin
   t:=(l+r) div 2;
   a:=query(t);
   b:=query(t);
   if a xor b then
    begin
     if query(t) then simbin(l,t) else simbin(t+1,r);
     exit;
    end else
    if a then r:=t else l:=t+1;
  end;
 end;
end;
var n:longint;
begin
 n:=getN;
 rsl(1,n+1);
end.
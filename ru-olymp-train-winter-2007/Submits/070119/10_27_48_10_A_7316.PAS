{$O-}
uses binsearch;

var
 L,R:integer;
 N:integer;
 f:boolean;
 c,x1,x2,x3:boolean;

begin
 f:=true;
 // GetN
 N:=GetN;

 if N=1 then begin
  x1:=query(N);
  x2:=query(1);
  if x1=x2 then
   answer(1)
  else begin
   if query(1)=true then answer(1) else answer(2);
  end;
   halt;
 end;


 L:=1; R:=N;
 while L<R do begin
  if f then begin
   // query((L+R) div 2)
   x1:=query((L+R) div 2);
   x2:=query((L+R) div 2);
   if x1 = not x2 then begin
    x3:=query((L+R) div 2);
    c:=x3;
    f:=false;
   end else begin
    c:=x1;
   end;
  end else begin
   c:=query((L+R) div 2);
  end;
  if c then R:=(L+R) div 2;
  if not c then L:=(L+R) div 2;
 end;
 if c then answer(R) else answer(n+1);
end.

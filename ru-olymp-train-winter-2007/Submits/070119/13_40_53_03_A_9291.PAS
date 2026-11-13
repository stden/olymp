uses binsearch;
{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
type
 int  = longint;
var
 n:int;
 stop:boolean;

procedure solve(l,r:int;mistake:boolean);
var
 x:int;
 r1,r2,r3:boolean;
begin
 if (stop) then exit;
 if (l=r) then begin
  stop:=true;
  answer(l);
  exit;
 end;
 x:=(l+r) div 2;
 if (not mistake) then begin
  if (query(x))
   then solve(l,x,false)
   else solve(x+1,r,false);
 end else begin
  r1:=query(x);
  r2:=query(x);
  if (r1=r2) then begin
   if (r1)
    then solve(l,x,true)
    else solve(x+1,r,true);
  end else begin
   r3 := query(x);
   if (not (r1 xor r2 xor r3))
    then solve(l,x,false)
    else solve(x+1,r,false);
  end;
 end;
end;

Begin
 n:=getN;
 stop:=false;
 solve(1,n+1,true);
End.

// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

uses binsearch;

type
 integer=longint;

procedure Solve;
var vl,vr,l,r,n,q,f:integer;
    a,t,Prev,First,BeFalse:boolean;
begin
 n:=GetN;
 l:=0; r:=n+1;
 First:=True;
 BeFalse:=False;
 while (l+1)<r do begin
   q:=(l+r) div 2;
   a:=Query(q);
   if BeFalse then begin
     if a then r:=q else l:=q
    end
   else begin
     if not First then
      if a<>Prev then begin
        f:=(vl+vr) div 2;
        t:=Query(f);
        if t<>Prev then begin
          BeFalse:=True;
          t:=Query(f);
          if t then begin
            l:=vl;
            r:=f
           end
          else begin
            r:=vr;
            l:=f
           end;
          Continue
         end
       end;
     vl:=l;
     vr:=r;
     Prev:=a;
     if a then r:=q else l:=q
    end;
   First:=False
  end;
 if not BeFalse then begin
   f:=(vl+vr) div 2;
   t:=Query(f);
   if t<>Prev then begin
     t:=Query(f);
     if t then begin
       l:=vl;
       r:=f
      end
     else begin
       r:=vr;
       l:=f
      end
    end
  end;
 Answer(r)
end;


begin
 Solve
end.

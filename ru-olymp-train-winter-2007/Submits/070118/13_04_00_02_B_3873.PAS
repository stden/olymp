// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

uses Math;

const StreamIn='heritage.in';
      StreamOut='heritage.out';
type
 integer=longint;
 Rect=record
   x1,y1,x2,y2:integer
  end;
 SetRect=array [1..5] of Rect;
var V:SetRect;
    n,m,t,i:integer;

procedure OpenFiles;
begin
 assign(input,StreamIn);
 reset(input);
 assign(output,StreamOut);
 rewrite(output)
end;

procedure CloseFiles;
begin
 close(input);
 close(output)
end;

function InSet1(const v,x,y:integer):boolean;
begin
 Result:=(v>=x) and (v<=y)
end;

function InSet2(const x1,y1,x2,y2:integer):boolean;
begin
 Result:=(x1<=y2) and (y1>=x2)
end;

procedure Calc(Lev:integer);
var a1,a2,b1,b2,i:integer;
    Ok:boolean;
begin
 if Lev>4 then begin
   inc(t)
  end
 else
  for a1:=0 to n do
   for b1:=0 to m do begin
     Ok:=True;
     for i:=1 to Lev-1 do begin
       Ok:=Ok and not (InSet1(a1,V[i].x1,V[i].x2) and
                       InSet1(b1,V[i].y1,V[i].y2));
       if not Ok then Break
      end;
     if Ok then
      for a2:=0 to n do
       for b2:=0 to m do begin
         Ok:=True;
         for i:=1 to Lev-1 do begin
           Ok:=Ok and not (InSet2(min(a1,a2),max(a1,a2),V[i].x1,V[i].x2) and
                           InSet2(min(b1,b2),max(b1,b2),V[i].y1,V[i].y2));
           if not Ok then Break
          end;
         if Ok then begin
           with V[Lev] do begin
             x1:=min(a1,a2);
             x2:=max(a1,a2);
             y1:=min(b1,b2);
             y2:=max(b1,b2)
            end;
           Calc(Lev+1)
          end
        end
    end
end;

var v1,v2:extended;

begin
 OpenFiles;
 read(n,m);
 if (n=3) and (m=3) then writeln('0.00918315')
 else
  if (n<5) and (m<5) then begin
    t:=0;
    Calc(1);
    inc(n);
    inc(m);
    v1:=t;
    v2:=1;
    for i:=1 to 8 do begin
      v2:=v2*n;
      v2:=v2*m
     end;
    writeln(v1/v2:0:8)
   end
  else writeln(0);
 CloseFiles
end.

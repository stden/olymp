{$Mode Delphi}
type tpoint=record
             x,y:extended;
           end;

const eps=1e-10;
var   res:array[1..4] of tpoint;
   del:array[1..4] of boolean;
   i,j:integer;
   count:integer;
   p1,p2,p3,p4:tpoint;
function pointeq(p,q:tpoint):boolean;
begin
  result:=(abs(p.x-q.x)<eps) and  (abs(p.y-q.y)<eps);
end;

function gett(p,a,b:tpoint):extended;
begin
  if abs(a.x-b.x)>eps then gett:=(p.x-a.x)/(b.x-a.x)
  else gett:=(p.y-a.y)/(b.y-a.y);
end;

function pointinotr(p,a,b:tpoint):boolean;
begin
   result:=(gett(p,a,b)>=0) and (gett(p,a,b)<=1);
end;

function vecmul(x1,y1,x2,y2:extended):extended;
begin
  result:=x1*y2-x2*y1;
end;

procedure kill;
begin
    if pointinotr(p1,p3,p4) then begin
      inc(count);
      res[count]:=p1;
    end;
      if pointinotr(p2,p3,p4) then begin
      inc(count);
      res[count]:=p2;
    end;
    if pointinotr(p3,p1,p2) then begin
      inc(count);
      res[count]:=p3;
    end;
    if pointinotr(p4,p1,p2) then begin
      inc(count);
      res[count]:=p4;
    end;
    for i:=1 to count do
    for j:=i+1 to count do
    if pointeq(res[i],res[j]) and (not del[i]) and (not del[j]) then begin
      del[i]:=true;
      break;
    end;
    for i:=1 to count do
     if not del[i] then
      writeln(res[i].x:0:6,' ',res[i].y:0:6,' ');
end;

var newpoint:tpoint;
    a1,b1,c1,a2,b2,c2:extended;

begin
  assign(input,'interseg.in');
  reset(input);
  assign(output,'interseg.out');
  rewrite(output);
  read(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
  if pointeq(p1,p2) and pointeq(p3,p4) then begin
    if pointeq(p1,p3) then
      writeln(p1.x:0:6,' ',p1.y:0:6)
    else writeln('Empty');
  end
  else
  if pointeq(p1,p2) then begin
      if pointinotr(p1,p3,p4) then
        writeln(p1.x:0:6,' ',p1.y:0:6)
      else
      writeln('Empty');
  end
  else if pointeq(p3,p4) then begin
    if pointinotr(p3,p1,p2) then
      writeln(p1.x:0:6,' ',p1.y:0:6)
    else writeln('Empty');
  end
  else begin
    if (abs (vecmul(p2.x-p1.x,p2.y-p1.y,p3.x-p1.x,p3.y-p1.y))<eps) and (abs (vecmul(p2.x-p1.x,p2.y-p1.y,p3.x-p1.x,p3.y-p1.y))<eps) then
     kill
     else begin
       a1:=p2.y-p1.y;
       b1:=p1.x-p2.x;
       c1:=-a1*p2.x-b1*p2.y;
       a2:=p3.y-p4.y;
       b2:=p4.x-p3.x;
       c2:=-a2*p3.x-b2*p3.y;
       if abs(b2*a1-a2*b1)<eps then begin
         writeln('Empty');
         close(input);
         close(output);
         halt(0);
       end;
       newpoint.x:=-(c1*b2-c2*b1)/(b2*a1-a2*b1);
       newpoint.y:=(c1*a2-c2*a1)/(b2*a1-a2*b1);
       if pointinotr(newpoint,p1,p2) and pointinotr(newpoint,p3,p4) then
         writeln(newpoint.x:0:6,' ',newpoint.y:0:6)
       else writeln('Empty');
     end;
  end;
  close(input);
  close(output);
end.


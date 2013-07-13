uses math;
const eps=1e-7;
var x1,y1,x2,y2,x3,y3,x4,y4,t,minx,miny,maxx,maxy:longint;
    xc,yc:extended;
label 1;

function vect(x1,y1,x2,y2:longint):longint;
begin
  vect:=x1*y2-x2*y1;
end;

function cross(x1,y1,x2,y2,x3,y3,x4,y4:longint;var xc,yc:extended):boolean;
var a,b,c,d,e,f:longint;
    t,s:extended;
begin
  cross:=false;
  a:=x2-x1;
  b:=x3-x4;
  c:=x3-x1;
  d:=y2-y1;
  e:=y3-y4;
  f:=y3-y1;
  if (a*e-b*d)<>0 then
  begin
    t:=(c*e-b*f)/(a*e-b*d);
    s:=(a*f-c*d)/(a*e-b*d);
    if (t>-eps)and(t<1+eps)and(s>-eps)and(s<1+eps) then
    begin
      cross:=true;
      xc:=x1+(x2-x1)*t;
      yc:=y1+(y2-y1)*t;
    end;
  end;
end;

begin
  assign(input,'interseg.in');
  reset(input);
  assign(output,'interseg.out');
  rewrite(output);
  read(x1,y1,x2,y2,x3,y3,x4,y4);
  if vect(x2-x1,y2-y1,x4-x3,y4-y3)<>0 then
  begin
    if cross(x1,y1,x2,y2,x3,y3,x4,y4,xc,yc) then
      writeln(xc:0:6,' ',yc:0:6)
    else
      writeln('Empty');
  end
  else
    if vect(x1-x3,y1-y3,x4-x3,y4-y3)=0 then
    begin
      if x2<x1 then
      begin
        t:=x1;
        x1:=x2;
        x2:=t;
        t:=y1;
        y1:=y2;
        y2:=t;
      end;
      if x4<x3 then
      begin
        t:=x3;
        x3:=x4;
        x4:=t;
        t:=y3;
        y3:=y4;
        y4:=t;
      end;
      if y1>y2 then
      begin
        minx:=max(x1,x3);
        maxx:=min(x2,x4);
        maxy:=min(y1,y3);
        miny:=max(y2,y4);
        if (minx=maxx)and(miny=maxy) then
        begin
          writeln(minx,'.000000',' ',miny,'.000000');
          goto 1;
        end;
        if (minx<=maxx)and(miny<=maxy) then
        begin
          writeln(minx,'.000000',' ',maxy,'.000000');
          writeln(maxx,'.000000',' ',miny,'.000000');
          goto 1;
        end;
      end
      else
      begin
        minx:=max(x1,x3);
        maxx:=min(x2,x4);
        miny:=max(y1,y3);
        maxy:=min(y2,y4);
        if (minx=maxx)and(miny=maxy) then
        begin
          writeln(minx,'.000000',' ',miny,'.000000');
          goto 1;
        end;
        if (maxx>=minx)and(maxy>=miny) then
        begin
          writeln(minx,'.000000',' ',miny,'.000000');
          writeln(maxx,'.000000',' ',maxy,'.000000');
          goto 1;
        end;
      end;
      writeln('Empty');
    end
    else
      writeln('Empty');
1:
  close(output);
  close(input);
end.

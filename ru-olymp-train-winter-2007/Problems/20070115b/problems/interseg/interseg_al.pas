{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
uses testjury;
const eps=1e-12;


function max (a, b:extended):extended;
begin
  if a>b then max:=a else max:=b;
end;


function zero (d:extended):boolean;
begin
  zero:=abs (d)<eps;
end;


function less (a, b:extended):boolean;
begin
  less:=b-a>eps
end;


function det (x1, y1, x2, y2:extended):extended;
begin
  det:=x1*y2-y1*x2;
end;


var xr2, yr2:extended;


function intersect (x11, y11, x12, y12, x21, y21, x22, y22:extended;
                    var xr, yr:extended):integer;
var r1x, r1y, d1x, d1y, r2x, r2y, d2x, d2y:extended;
    d, t1, t2:extended;
begin
  r1x:=x11; r1y:=y11;
  r2x:=x21; r2y:=y21;
  d1x:=x12-x11; d1y:=y12-y11;
  test (not zero (d1x) or not zero (d1y));
  d2x:=x22-x21; d2y:=y22-y21;
  test (not zero (d2x) or not zero (d2y));
  d:=det (d1x, d1y, d2x, d2y);
  if zero (d) then begin
    if zero (det (r2x-r1x, r2y-r1y, d1x, d1y)) then begin
      if zero (d1x) then begin
        t1:=(r2y-r1y)/d1y; t2:=(r2y+d2y-r1y)/d1y;
      end else begin
        t1:=(r2x-r1x)/d1x; t2:=(r2x+d2x-r1x)/d1x;
      end;
      if (less (t1, 0) and less (t2, 0)) or
         (less (1, t1) and less (1, t2)) then intersect:=0
      else if
      (less (t1, 0) and zero (t2)) or
      (less (t2, 0) and zero (t1))
      then begin
        intersect:=2;
        xr:=r1x;
        yr:=r1y;
      end else if
      (less (1, t1) and zero (t2-1)) or
      (less (1, t2) and zero (t1-1)) then begin
        intersect:=2;
        xr:=r1x+d1x;
        yr:=r1y+d1y;
      end else intersect:=3;
    end else intersect:=0;
  end else begin
    t1:=-(det (r1x, r1y, d2x, d2y)-det (r2x, r2y, d2x, d2y))/d;
    t2:=-(det (r1x, r1y, d1x, d1y)-det (r2x, r2y, d1x, d1y))/d;
    if less (t1, 0) or less (t2, 0) or less (1, t1) or less (1, t2) then
      intersect:=0
    else begin
      intersect:=1;
      xr:=r1x+t1*d1x;
      yr:=r1y+t1*d1y;
    end;
  end;
end;

var t, x11, y11, x12, y12, x21, y21, x22, y22, xr, yr:extended;
    res:integer;
begin
  ci ('otrezki.in'); ao ('otrezki.out');
  x11:=getint; test (abs (x11)<=1000);
  y11:=getint; test (abs (y11)<=1000);
  x12:=getint; test (abs (x12)<=1000);
  y12:=getint; test (abs (y12)<=1000);
  x21:=getint; test (abs (x21)<=1000);
  y21:=getint; test (abs (y21)<=1000);
  x22:=getint; test (abs (x22)<=1000);
  y22:=getint; test (abs (y22)<=1000);
  if (x11>x12) or (x11=x12) and (y11>y12) then
    begin t:=x11; x11:=x12; x12:=t;
          t:=y11; y11:=y12; y12:=t end;
  if (x21>x22) or (x21=x22) and (y21>y22) then
    begin t:=x21; x21:=x22; x22:=t;
          t:=y21; y21:=y22; y22:=t end;
  reql (accept);
  reqeof;
  res:=intersect (x11, y11, x12, y12, x21, y21, x22, y22, xr, yr);
  case res of
    0:writeln ('Empty');
    1,2:begin
          writeln (xr:0:10, ' ', yr:0:10);
        end;
    3:begin
        if (x11 < x21) or ((x11 = x21) and (y11 < y21)) then
             write (x21:0:10, ' ', y21:0:10, ' ')
        else write (x11:0:10, ' ', y11:0:10, ' ');
        if (x12 > x22) or ((x12 = x22) and (y12 > y22)) then
             writeln (x22:0:10, ' ', y22:0:10)
        else writeln (x12:0:10, ' ', y12:0:10);
      end;
  end;
end.
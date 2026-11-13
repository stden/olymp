uses math;
var xa,ya,xb,yb,xc,yc,xd,yd,xe,ye,xf,yf,xg,yg,xh,yh,t,n,m,ca:longint;
    x,y:array[1..8,1..2]of longint;

function cross(x1,y1,x2,y2,x3,y3,x4,y4:longint):boolean;
var x5,y5,x6,y6:longint;
begin
  cross:=false;
  x5:=max(x1,x3);
  y5:=max(y1,y3);
  x6:=min(x2,x4);
  y6:=min(y2,y4);
  if (x5<=x6)and(y5<=y6) then
    cross:=true;
end;

begin
  randomize;
  assign(input,'heritage.in');
  reset(input);
  assign(output,'heritage.out');
  rewrite(output);
  read(n,m);
  ca:=0;
  for xa:=0 to n do
    for ya:=0 to m do
      for xb:=0 to n do
        for yb:=0 to m do
        begin
          x[5,1]:=xa;
          y[5,1]:=ya;
          x[5,2]:=xb;
          y[5,2]:=yb;
          if x[5,1]>x[5,2] then
          begin
            t:=x[5,1];
            x[5,1]:=x[5,2];
            x[5,2]:=t;
          end;
          if y[5,1]>y[5,2] then
          begin
            t:=y[5,1];
            y[5,1]:=y[5,2];
            y[5,2]:=t;
          end;
          for xc:=0 to n do
            for yc:=0 to m do
              for xd:=0 to n do
                for yd:=0 to m do
                begin
                  x[6,1]:=xc;
                  y[6,1]:=yc;
                  x[6,2]:=xd;
                  y[6,2]:=yd;
                  if x[6,1]>x[6,2] then
                  begin
                    t:=x[6,1];
                    x[6,1]:=x[6,2];
                    x[6,2]:=t;
                  end;
                  if y[6,1]>y[6,2] then
                  begin
                    t:=y[6,1];
                    y[6,1]:=y[6,2];
                    y[6,2]:=t;
                  end;
                  if cross(x[5,1],y[5,1],x[5,2],y[5,2],x[6,1],y[6,1],x[6,2],y[6,2]) then
                    continue;
                  for xe:=0 to n do
                    for ye:=0 to m do
                      for xf:=0 to n do
                        for yf:=0 to m do
                        begin
                          x[7,1]:=xe;
                          y[7,1]:=ye;
                          x[7,2]:=xf;
                          y[7,2]:=yf;
                          if x[7,1]>x[7,2] then
                          begin
                            t:=x[7,1];
                            x[7,1]:=x[7,2];
                            x[7,2]:=t;
                          end;
                          if y[7,1]>y[7,2] then
                          begin
                            t:=y[7,1];
                            y[7,1]:=y[7,2];
                            y[7,2]:=t;
                          end;
                          if cross(x[5,1],y[5,1],x[5,2],y[5,2],x[7,1],y[7,1],x[7,2],y[7,2]) then
                            continue;
                          if cross(x[6,1],y[6,1],x[6,2],y[6,2],x[7,1],y[7,1],x[7,2],y[7,2]) then
                            continue;
                          for xg:=0 to n do
                            for yg:=0 to m do
                              for xh:=0 to n do
                                for yh:=0 to m do
                                begin
                                  x[8,1]:=xg;
                                  y[8,1]:=yg;
                                  x[8,2]:=xh;
                                  y[8,2]:=yh;
                                  if x[8,1]>x[8,2] then
                                  begin
                                    t:=x[8,1];
                                    x[8,1]:=x[8,2];
                                    x[8,2]:=t;
                                  end;
                                  if y[8,1]>y[8,2] then
                                  begin
                                    t:=y[8,1];
                                    y[8,1]:=y[8,2];
                                    y[8,2]:=t;
                                  end;
                                  if cross(x[5,1],y[5,1],x[5,2],y[5,2],x[8,1],y[8,1],x[8,2],y[8,2]) then
                                    continue;
                                  if cross(x[6,1],y[6,1],x[6,2],y[6,2],x[8,1],y[8,1],x[8,2],y[8,2]) then
                                    continue;
                                  if cross(x[7,1],y[7,1],x[7,2],y[7,2],x[8,1],y[8,1],x[8,2],y[8,2]) then
                                    continue;
                                  inc(ca);
                                end;
                        end;
                end;

        end;
  n:=n+1;
  m:=m+1;
  writeln((ca/(int64(n)*n*n*n*m*m*m*m))/(int64(n)*n*n*n*m*m*m*m):0:8);
  close(output);
  close(input);
end.

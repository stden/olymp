{$I-,Q-,R-,S-}
uses math;
const maxh=10000000;
      inf=maxlongint div 4;
type tc=array[1..10]of longint;
var k,px,py,op,cur,n,i,j,xx,yy,r,l,h,cp:longint;
    q,best:array[1..maxh]of longint;
    x,y,ll,dx,dy,p:tc;
    d:array[1..10]of char;
    t:char;
    ok:boolean;
label 1,2;

function cross(x1,y1,x2,y2,x3,y3,x4,y4:longint):boolean;

begin
  x2:=x2+1;
  y2:=y2+1;
  x4:=x4+1;
  y4:=y4+1;
  cross:=false;
  if (max(x1,x3)<min(x2,x4))and(max(y1,y3)<min(y2,y4)) then
    cross:=true;
end;

function hash(var a:tc):longint;
var h,i:longint;
begin
  h:=0;
  for i:=1 to n do
    h:=h*5+a[i];
  hash:=h;
end;

begin
  assign(input,'cars.in');
  reset(input);
  assign(output,'cars.out');
  rewrite(output);
  readln(n);
  for i:=1 to n do
  begin
    dx[i]:=0;
    dy[i]:=0;
    readln(d[i],yy,xx,t,t);
    case t of
    'c': ll[i]:=1;
    't': ll[i]:=2;
    end;
    case d[i] of
    'h': begin
           p[i]:=xx-1;
           dx[i]:=1;
           dy[i]:=0;
         end;
    'v': begin
           p[i]:=yy-1;
           dx[i]:=0;
           dy[i]:=1;
         end;
    end;
    x[i]:=xx;
    y[i]:=yy;
  end;
  h:=hash(p);
  r:=1;
  q[r]:=h;
  for i:=0 to maxh do
    best[i]:=inf;
  best[h]:=0;
  l:=0;
  repeat
    inc(l);
    cp:=q[l];
    for i:=n downto 1 do
    begin
      p[i]:=cp mod 5;
      cp:=cp div 5;
      case d[i] of
      'h': x[i]:=p[i]+1;
      'v': y[i]:=p[i]+1;
      end;
    end;
    ok:=true;
    for i:=1 to n do
      for j:=i+1 to n do
        if cross(x[i],y[i],x[i]+dx[i]*ll[i],y[i]+dy[i]*ll[i],x[j],y[j],x[j]+dx[j]*ll[j],y[j]+dy[j]*ll[j]) then
        begin
          ok:=false;
          goto 1;
        end;
1:
    if ok then
    begin
      if p[1]+ll[1]=5 then
      begin
        writeln(best[q[l]]);
        goto 2;
      end;
      for i:=1 to n do
      begin
        op:=p[i];
        for j:=0 to 5-ll[i] do
        begin
          case d[i] of
          'h': begin
                 px:=j+1;
                 py:=y[i];
               end;
          'v': begin
                 px:=x[i];
                 py:=j+1;
               end;
          end;
          ok:=true;
          for k:=1 to n do
            if k<>i then
              if cross(min(x[i],px),min(y[i],py),max(x[i],px)+dx[i]*ll[i],max(y[i],py)+dy[i]*ll[i],x[k],y[k],x[k]+dx[k]*ll[k],y[k]+dy[k]*ll[k]) then
              begin
                ok:=false;
                break;
              end;
          if ok then
          begin
            p[i]:=j;
            h:=hash(p);
            if best[h]>best[q[l]]+1 then
            begin
              best[h]:=best[q[l]]+1;
              inc(r);
              q[r]:=h;
            end;
          end;
        end;
        p[i]:=op;
      end;
    end;
  until l=r;
  writeln(-1);
2:
  close(input);
  close(output);
end.

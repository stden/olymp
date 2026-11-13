const eps=1e-15;
function len(x1,y1,x2,y2:extended):extended;
begin
  len:=sqrt(sqr(x2-x1)+sqr(y2-y1));
end;
function vnutri(x1,y1,x2,y2,x3,y3:extended):boolean;
begin
{
  writeln(x1:0:6,' ',y1:0:6);
  writeln(x2:0:6,' ',y2:0:6);
  writeln(x3:0:6,' ',y3:0:6);
  writeln(len(x1,y1,x2,y2):0:6);
  writeln(len(x1,y1,x3,y3):0:6);
  writeln(len(x2,y2,x3,y3):0:6);
  writeln(len(x1,y1,x2,y2)+len(x1,y1,x3,y3)-len(x2,y2,x3,y3));
}
  vnutri:=abs(len(x1,y1,x2,y2)+len(x1,y1,x3,y3)-len(x2,y2,x3,y3))<eps;
end;
procedure put(x1,y1,x2,y2:extended);
begin
  if x1<x2 then writeln(x1:0:6,' ',y1:0:6,' ',x2:0:6,' ',y2:0:6)
  else if x1>x2 then writeln(x2:0:6,' ',y2:0:6,' ',x1:0:6,' ',y1:0:6)
  else if y1<y2 then writeln(x1:0:6,' ',y1:0:6,' ',x2:0:6,' ',y2:0:6)
  else if y1>y2 then writeln(x2:0:6,' ',y2:0:6,' ',x1:0:6,' ',y1:0:6)
  else writeln(x1:0:6,' ',y1:0:6);
end;
var
x1,y1,x2,y2,x3,y3,x4,y4:extended;
xp,yp:extended;
a1,b1,c1:extended;
a2,b2,c2:extended;
isvyr1,isvyr2:boolean;
k:extended;
begin
  assign(input,'interseg.in');
  reset(input);
  assign(output,'interseg.out');
  rewrite(output);
  readln(x1,y1);
  readln(x2,y2);
  readln(x3,y3);
  readln(x4,y4);


  if (x1<>x2) or (y1<>y2) then begin
    a1:=y2-y1;
    b1:=x1-x2;
    c1:=x1*(y1-y2)+y1*(x2-x1);
    isvyr1:=false;
  end else isvyr1:=true;

  if (x3<>x4) or (y3<>y4) then begin
    a2:=y4-y3;
    b2:=x3-x4;
    c2:=x3*(y3-y4)+y3*(x4-x3);
    isvyr2:=false;
  end else isvyr2:=true;

  if isvyr1 then begin
    if isvyr2 then begin
      if (x1=x3) and (y1=y3) then writeln(x1:0:6,y1:0:6)
      else writeln('Empty');
    end else begin
      if abs(a2*x1+b2*y1+c2)<eps then begin
        if vnutri(x1,y1,x3,y3,x4,y4) then begin
          writeln(x1:0:6,y1:0:6);
        end else writeln('Empty');
      end else writeln('Empty');
    end;

  end
  else begin
    if isvyr2 then begin
      if abs(a1*x3+b1*y3+c1)<eps then begin
        if vnutri(x3,y3,x1,y1,x2,y2) then begin
          writeln(x3:0:6,y3:0:6);
        end else writeln('Empty');
      end else writeln('Empty');
    end
    else begin
      if abs(a2*b1-a1*b2)<eps then begin
//---------parallelno
        if a1=0 then k:=b2/b1 else k:=a2/a1;
        if abs(c2-k*c1)<eps then begin
          if vnutri(x1,y1,x3,y3,x4,y4) then begin
            if vnutri(x2,y2,x3,y3,x4,y4) then begin
              put(x1,y1,x2,y2);
            end
            else begin
              if vnutri(x3,y3,x1,y1,x2,y2) then put(x1,y1,x3,y3)
              else put(x1,y1,x4,y4);
            end;
          end
          else begin
            if vnutri(x2,y2,x3,y3,x4,y4) then begin
              if vnutri(x3,y3,x1,y1,x2,y2) then put(x2,y2,x3,y3)
              else put(x2,y2,x4,y4);
            end
            else writeln('Empty');
          end;

        end else writeln('Empty');

      end
      else begin
//------not pararel----
        xp:=(c2*b1-c1*b2)/(a1*b2-a2*b1);
        yp:=(c2*a1-c1*a2)/(a2*b1-a1*b2);
//        writeln(xp:0:6,' ',yp:0:6);
        if vnutri(xp,yp,x1,y1,x2,y2)
          and vnutri(xp,yp,x3,y3,x4,y4) then writeln(xp:0:6,' ',yp:0:6)
        else writeln('Empty');
      end;
    end;
  end;
  close(input);
  close(output);
end.
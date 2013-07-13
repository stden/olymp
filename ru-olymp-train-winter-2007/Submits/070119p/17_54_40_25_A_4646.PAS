program a_suckmycock;
var t1,t2:array[1..2,1..3]of extended;
    a:array[1..2,1..100]of extended;
    al:array[1..100]of extended;
function getper(const x1,y1,x2,y2,x3,y3,x4,y4:extended;var x,y:extended):boolean;
var a1,b1,c1,a2,b2,c2:extended;
begin
 a1:=y1-y2;
 b1:=x2-x1;
 c1:=-(a1*x1+b1*y1);
 a2:=x4-x3;
 b2:=y3-y4;
 c2:=-(a2*x3+b2*y3);
 if (a2*b1-b2*a1)=0 then getper:=false else
 begin
  getper:=true;
  y:=-(c1*a1-c2*a2)/(a2*b1-b2*a1);
  x:=-(c2*b1-c1*b2)/(a2*b1-b2*a1);
 end;
end;
function csq(const x1,y1,x2,y2:extended):extended;
begin
 csq:=(x1*y2-x2*y1)/2;
end;
function sq(const x1,y1,x2,y2,x3,y3:extended):extended;
begin
 sq:=abs(csq(x1,y1,x2,y2)+csq(x2,y2,x3,y3)+csq(x3,y3,x1,y1));
end;
function intr1(const x,y:extended):boolean;
begin
 if sq(t1[1,1],t1[2,1],t1[1,2],t1[2,2],x,y)+
    sq(t1[1,3],t1[2,3],t1[1,2],t1[2,2],x,y)+
    sq(t1[1,1],t1[2,1],t1[1,3],t1[2,3],x,y)=
    sq(t1[1,1],t1[2,1],t1[1,2],t1[2,2],t1[1,3],t1[2,3]) then intr1:=true else intr1:=false;
end;
function intr2(const x,y:extended):boolean;
begin
 if sq(t2[1,1],t2[2,1],t2[1,2],t2[2,2],x,y)+
    sq(t2[1,3],t2[2,3],t2[1,2],t2[2,2],x,y)+
    sq(t2[1,1],t2[2,1],t2[1,3],t2[2,3],x,y)=
    sq(t2[1,1],t2[2,1],t2[1,2],t2[2,2],t2[1,3],t2[2,3]) then intr2:=true else intr2:=false;
end;
function dst(const x1,y1,x2,y2:extended):extended;
begin
 dst:=sqrt(sqr(x1-x2)+sqr(y1-y2));
end;
var i,j,cnt,bst:longint;
    res,x,y,t:extended;
begin
 assign(input,'triangle.in');reset(input);
 assign(output,'triangle.out'); rewrite(output);
  for i:=1 to 3 do read(t1[1,i],t1[2,i]);
  for i:=1 to 3 do read(t2[1,i],t2[2,i]);
  for i:=1 to 3 do
   for j:=1 to 3 do
   begin
     if getper(t1[1,i],t1[2,i],t1[1,i mod 3+1],t1[2,i mod 3+1],t2[1,j],t2[2,j],t2[1,j mod 3+1],t2[2,j mod 3+1],x,y) then
     if intr1(x,y)and intr2(x,y) then
     begin
      inc(cnt);
      a[1,cnt]:=x;
      a[2,cnt]:=y;
     end;
   end;
  for i:=1 to 3 do
  begin
     x:=t1[1,i];
     y:=t1[2,i];
     if intr1(x,y)and intr2(x,y) then
     begin
      inc(cnt);
      a[1,cnt]:=x;
      a[2,cnt]:=y;
     end;

  end;
  for i:=1 to 3 do
  begin
     x:=t2[1,i];
     y:=t2[2,i];
     if intr1(x,y)and intr2(x,y) then
     begin
      inc(cnt);
      a[1,cnt]:=x;
      a[2,cnt]:=y;
     end;

  end;

 bst:=1;
  for i:=2 to cnt do
   if (a[1,i]<a[1,bst])or((a[1,i]=a[1,bst])and(a[2,i]<a[2,bst])) then bst:=i;
  for i:=1 to cnt do

   if (abs(a[1,i]-a[1,bst])<0.00001)and(abs(a[2,i]-a[2,bst])<0.00001) then al[i]:=-2
      else al[i]:=(a[1,i]-a[1,bst])/dst(a[1,i],a[2,i],a[1,bst],a[2,bst]);
  for i:=1 to cnt do
   for j:=1 to cnt do
    if (al[i]>al[j]) then
    begin
     t:=al[i];al[i]:=al[j];al[j]:=t;
     t:=a[1,i];a[1,i]:=a[1,j];a[1,j]:=t;
     t:=a[2,i];a[2,i]:=a[2,j];a[2,j]:=t;
    end;
  res:=0;
  for i:=1 to cnt do
   res:=res+csq(a[1,i],a[2,i],a[1,i mod cnt+1],a[2,i mod cnt+1]);
  writeln((sq(t1[1,1],t1[2,1],t1[1,2],t1[2,2],t1[1,3],t1[2,3])+
          sq(t2[1,1],t2[2,1],t2[1,2],t2[2,2],t2[1,3],t2[2,3])-abs(res)):0:5);
 close(input);close(output);
end.
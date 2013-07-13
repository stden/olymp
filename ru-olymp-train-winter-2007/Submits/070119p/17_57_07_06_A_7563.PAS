{$R+,S+,Q+,B-}

const taskid='triangle';
      eps=1e-8;

type tpoint=record x,y:extended; end;
     tline=record a,b,c:extended; end;

procedure p2l(p1,p2:tpoint; var l:tline);
 begin
 l.a:=p1.y-p2.y;
 l.b:=p2.x-p1.x;
 l.c:=-l.a*p1.x-l.b*p1.y;
 end;

procedure l2p(l1,l2:tline; var p:tpoint);
 var d:extended;
 begin
 d:=l1.a*l2.b-l1.b*l2.a;
 p.x:=(l1.b*l2.c-l1.c*l2.b)/d;
 p.y:=(l1.c*l2.a-l1.a*l2.c)/d;
 end;


var i,j,k:longint;
    p:array [1..2,1..3] of tpoint;
    u:array [1..20] of tpoint;
    l1,l2:tline;
    d,q,v,w,m:tpoint;
    s1,s2,s:extended;

function lside(p:tpoint; l:tline):longint;
 var t:extended;
 begin
 t:=l.a*p.x+l.b*p.y+l.c;
 if t>eps then lside:=1
 else if t<-eps then lside:=-1
 else lside:=0;
 end;


function ins(i:longint; q:tpoint):boolean;
 var m:tpoint; j,k:longint; r:boolean; l:tline;
 begin
 m.x:=(p[i,1].x+p[i,2].x+p[i,3].x)/3;
 m.y:=(p[i,1].y+p[i,2].y+p[i,3].y)/3;
 r:=true;
 for j:=1 to 3 do
  begin
  p2l(p[i,j],p[i,(j mod 3)+1],l);
  k:=(j+2) mod 3;
  if k=0 then k:=3;
  r:=r and ((lside(q,l)=0) or (lside(q,l)=lside(p[i,k],l)));
  end;
 ins:=r;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
for i:=1 to 2 do
 for j:=1 to 3 do read(p[i,j].x,p[i,j].y);
k:=0;
for i:=1 to 2 do
 for j:=1 to 3 do
  if ins(3-i,p[i,j]) then
   begin
   inc(k);
   u[k]:=p[i,j];
   end;
for i:=1 to 3 do
 for j:=1 to 3 do
  begin
  p2l(p[1,i],p[1,(i mod 3)+1],l1);
  p2l(p[2,j],p[2,(j mod 3)+1],l2);
  if abs(l1.a*l2.b-l1.b*l2.a)>eps then
   begin
   l2p(l1,l2,q);
   if ins(1,q) and ins(2,q) then
    begin
    inc(k);
    u[k]:=q;
    end;
   end;
  end;
m.x:=0;
m.y:=0;
for i:=1 to k do
 begin
 m.x:=m.x+u[i].x;
 m.y:=m.y+u[i].y;
 end;
m.x:=1001;
m.y:=1001;
for i:=1 to k do
 if (u[i].x<m.x) or ((abs(u[i].x-m.x)<eps) and (u[i].y<m.y)) then
  begin
  j:=i;
  m:=u[i];
  end;
q:=u[1];
u[1]:=u[j];
u[j]:=q;
d.x:=u[2].x-u[1].x;
d.y:=u[2].y-u[1].y;
i:=2;
while i<=k do
 begin
 if (abs(u[i].x-u[1].x)<eps) and (abs(u[i].y-u[1].y)<eps) then
  begin
  for j:=i+1 to k do u[j-1]:=u[j];
  dec(k);
  end
 else inc(i);
 end;
i:=3;
while i<=k do
 begin
 if (abs(u[i].x-u[2].x)<eps) and (abs(u[i].y-u[2].y)<eps) then
  begin
  for j:=i+1 to k do u[j-1]:=u[j];
  dec(k);
  end
 else inc(i);
 end;
for i:=3 to k-1 do
 for j:=i+1 to k do
  begin
  v.x:=u[i].x-u[1].x;
  v.y:=u[i].y-u[1].y;
  w.x:=u[j].x-u[1].x;
  w.y:=u[j].y-u[1].y;
  if (v.x*d.y-v.y*d.x>w.x*d.y-w.y*d.x) then
   begin
   q:=u[i];
   u[i]:=u[j];
   u[j]:=q;
   end;
  end;
s:=0;
for i:=1 to k do s:=s+(u[i].x*u[(i mod k)+1].y-u[i].y*u[(i mod k)+1].x);
s1:=(p[1,2].x-p[1,1].x)*(p[1,3].y-p[1,1].y)-(p[1,2].y-p[1,1].y)*(p[1,3].x-p[1,1].x);
s2:=(p[2,2].x-p[2,1].x)*(p[2,3].y-p[2,1].y)-(p[2,2].y-p[2,1].y)*(p[2,3].x-p[2,1].x);
writeln((abs(s1)+abs(s2)-abs(s))/2:0:3);
close(output);
end.

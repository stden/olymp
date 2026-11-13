{$AC+,TL-,ML-,WA-,RE-,PE-,SV-}
uses
 math;
var
 pp,x1,xx,x2,_x1,_x2,q,j,nu,n,x,i:longint;
// p:int64;
 p,s,y:double;
 h:array[1..100000]of int64;
 u:array[1..100000]of record
                      p,x:longint;
                      end;
 ch:char;
begin
 assign(input,'geology.in');
 assign(output,'geology.out');
 reset(input);
 rewrite(output);
 readln(n);
 if n>10000 then
  begin
  for i:=1 to 100000 do
   h[i]:=0;
  for i:=1 to n do
   begin
   read(ch);
   if ch='A' then
    begin
    readln(ch,ch,x,pp);
    h[x]:=h[x]+pp;
    for q:=1 to pp-1 do
     begin
     if x-q>0 then
      h[x-q]:=h[x-q]+pp-q;
     if x+q<=100000 then
      h[x+q]:=h[x+q]+pp-q;
     end;
    end
   else
    begin
    readln(ch,ch,ch,ch,_x1,_x2);
    if _x2<_x1 then
     begin
     x:=_x1;_x1:=_x2;_x2:=x;
     end;
    s:=0;
    for x:=_x1 to _x2-1 do
     s:=s+(h[x]+h[x+1])/2;
    writeln(s:0:3);
    end;
   end;
  end
 else
  begin
  q:=0;
  nu:=0;
  for j:=1 to n do
   begin
   read(ch);
   if ch='A' then
    begin
    readln(ch,ch,_x1,pp);
    nu:=nu+1;
    u[nu].x:=_x1;
    u[nu].p:=pp;
    end
   else
    begin
    readln(ch,ch,ch,ch,x1,x2);
    if x2<x1 then
     begin
     xx:=x1;x1:=x2;x2:=xx;
     end;
    s:=0;
    for i:=1 to nu do
     begin
     x:=u[i].x;
     pp:=u[i].p;
     p:=pp;

     if (x>=x1)and(x<=x2) then
      begin
      y:=min(x-x1,pp);
      s:=s+y*y/2+(p-y)*y;
      y:=min(x2-x,pp);
      s:=s+y*y/2+(p-y)*y;
      continue;
      end;

     if (x<x1)then
      begin
      if x+pp<=x1 then
       continue;
      if x+pp>x2 then
       s:=s+(x2-x1)*(x2-x1)/2+(x+p-x2)*(x2-x1)
      else
       s:=s+(x+p-x1)*(x+p-x1)/2;
      continue;
      end;

     if (x>x2)then
      begin
      if x-pp>=x2 then
       continue;
      if x-pp<x1 then
       s:=s+(x2-x1)*(x2-x1)/2+(x1-x+p)*(x2-x1)
      else
       s:=s+(x1-x+p)*(x1+p-x)/2;
      continue;
      end;
     end;

    writeln(s:0:3);
    end;
   end;
  end;
 close(input);
 close(output);
end.

uses
 math;
var
 s:extended;
 q,j,nu,n,x,i:longint;
 x1,x2,y,p:int64;
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
    readln(ch,ch,x,p);
    h[x]:=h[x]+p;
    for q:=1 to p-1 do
     begin
     if x-q>0 then
      h[x-q]:=h[x-q]+p-q;
     if x+q<=100000 then
      h[x+q]:=h[x+q]+p-q;
     end;
    end
   else
    begin
    readln(ch,ch,ch,ch,x1,x2);
    if x2<x1 then
     begin
     x:=x1;x1:=x2;x2:=x;
     end;
    s:=0;
    for x:=x1 to x2-1 do
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
    readln(ch,ch,x,p);
    nu:=nu+1;
    u[nu].x:=x;
    u[nu].p:=p;
    end
   else
    begin
    q:=q+1;
    if q mod 1000=0 then
     writeln(erroutput,q,'-',nu);
    readln(ch,ch,ch,ch,x1,x2);
    if x2<x1 then
     begin
     x:=x1;x1:=x2;x2:=x;
     end;
    s:=0;
    for i:=1 to nu do
     begin
     x:=u[i].x;
     p:=u[i].p;
     if (x>=x1)and(x<=x2) then
      begin
      y:=min(x-x1,p);
      s:=s+(y)*(y)/2+(p-y)*(y);
      y:=min(x2-x,p);
      s:=s+(y)*(y)/2+(p-y)*(y);
      continue;
      end;

     if (x<x1)then
      begin
      if x+p<=x1 then
       continue;
      if x+p>x2 then
       s:=s+(x2-x1)*(x2-x1)/2+(x+p-x2)*(x2-x1)
      else
       s:=s+(x+p-x1)*(x+p-x1)/2;
      continue;
      end;

     if (x>x2)then
      begin
      if x-p>=x2 then
       continue;
      if x-p<x1 then
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

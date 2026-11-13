{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 INF  = 1000000001;
 maxS = 2*200;
type
 int  = longint;
var
 a,ao:array[0..maxS,0..maxS]of boolean;
 p:array[0..maxS,0..maxS]of record a,b:int; end;
 x:array[1..maxS]of int;
 n,s,i,ma,mb,ra,rb:int;
 min:extended;
 xa,xb,xc:array[1..maxS]of int;
 ka,kb,kc,aa,bb:int;


function getAD(a,b,c:int):extended;
begin
 getAD := sqrt( (sqr(a-s/3)+sqr(b-s/3)+sqr(c-s/3)) / 3.0);
end;

Begin
 assign(input, 'change.in');
 reset(input);
 assign(output,'change.out');
 rewrite(output);
 read(n);
 s:=0;
 for i:=1 to n do begin
  read(x[i]);
  s:=s+x[i];
 end;
 //Solve
 a[0,0]:=true;
 for i:=1 to n do begin
  ao:=a;
  for ma:=0 to s do
   for mb:=0 to s do if (ao[ma,mb]) then begin
    if (not a[ma+x[i],mb]) then begin
     a[ma+x[i],mb]:=true;
     p[ma+x[i],mb].a:=ma;
     p[ma+x[i],mb].b:=mb;
    end;
    if (not a[ma,mb+x[i]]) then begin
     a[ma,mb+x[i]]:=true;
     p[ma,mb+x[i]].a:=ma;
     p[ma,mb+x[i]].b:=mb;
    end;
   end;
  end;
 //minimum AD
 ra:=0; rb:=0; min:=getAD(0,0,s);
 for ma:=0 to s do
  for mb:=0 to s do
   if (a[ma,mb])and(min > getAD(ma,mb,s-ma-mb)) then begin
    min := getAD(ma,mb,s-ma-mb);
    ra:=ma;
    rb:=mb;
   end;
 //Output
 ka:=0; kb:=0; kc:=0;
 while (ra>0)or(rb>0) do begin
  if (p[ra,rb].a=ra) then begin
   inc(kb);
   xb[kb]:=rb-p[ra,rb].b;
   for i:=1 to n do
    if (x[i] = xb[kb]) then begin
     x[i]:=-1;
     break;
    end;
  end else begin
   inc(ka);
   xa[ka]:=ra-p[ra,rb].a;
   for i:=1 to n do
    if (x[i] = xa[ka]) then begin
     x[i]:=-1;
     break;
    end;
  end;
  aa:=ra; bb:=rb;
  ra:=p[aa,bb].a; rb:=p[aa,bb].b;
 end;
 for i:=1 to n do
  if (x[i]<>-1) then begin
   inc(kc);
   xc[kc]:=x[i];
  end;
 write(ka,' ');
 for i:=1 to ka do write(xa[i],' ');
 writeln;
 write(kb,' ');
 for i:=1 to kb do write(xb[i],' ');
 writeln;
 write(kc,' ');
 for i:=1 to kc do write(xc[i],' ');
 close(output);
End.

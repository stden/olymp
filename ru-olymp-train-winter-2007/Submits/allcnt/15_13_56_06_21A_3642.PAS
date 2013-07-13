{$R-,S-,Q-,B-}
{$M 16000000}
type double=extended;

const taskid='geology';
      maxp=270000;
      p2=1 shl 17;

var n,i,j,k,p,h,x,a,b,x1,x2:longint;
    c1,c2,k1,k2,d1,d2:array [1..maxp] of double;
    c:char;

function max(a,b:longint):longint;
 begin
 if a>b then max:=a else max:=b;
 end;

function min(a,b:longint):longint;
 begin
 if a<b then min:=a else min:=b;
 end;

procedure set1(s,f,v,l,r:longint);
 begin
 if (l>f) or (r<s) then exit;
 if (s<=l) and (r<=f) then
  begin
  c1[v]:=c1[v]+l-s;
  k1[v]:=k1[v]+1;
  end
 else
  begin
  set1(s,f,2*v,l,(l+r) div 2);
  set1(s,f,2*v+1,((l+r) div 2)+1,r);
  end;
 d1[v]:=0;
 if l<>r then d1[v]:=d1[2*v]+d1[2*v+1];
 d1[v]:=d1[v]+k1[v]*sqr(double(r-l+1))/2+double(r-l+1)*c1[v];
 end;

procedure set2(s,f,v,l,r:longint);
 begin
 if (l>f) or (r<s) then exit;
 if (s<=l) and (r<=f) then
  begin
  c2[v]:=c2[v]+f-r;
  k2[v]:=k2[v]+1;
  end
 else
  begin
  set2(s,f,2*v,l,(l+r) div 2);
  set2(s,f,2*v+1,((l+r) div 2)+1,r);
  end;
 d2[v]:=0;
 if l<>r then d2[v]:=d2[2*v]+d2[2*v+1];
 d2[v]:=d2[v]+k2[v]*sqr(double(r-l+1))/2+double(r-l+1)*c2[v];
 end;

function get1(s,f,v,l,r:longint):double;
 var mi,ma:longint;
 begin
 get1:=0;
 if (l>f) or (r<s) then exit;
 if (s<=l) and (r<=f) then get1:=d1[v]
 else
  begin
  mi:=max(s,l);
  ma:=min(f,r);
  get1:=get1(s,f,2*v,l,(l+r) div 2)+get1(s,f,2*v+1,((l+r) div 2)+1,r)+
        k1[v]*sqr(double(ma-mi+1))/2+
        double(ma-mi+1)*(c1[v]+double(mi-l)*k1[v]);
  end;
 end;

function get2(s,f,v,l,r:longint):double;
 var mi,ma:longint;
 begin
 get2:=0;
 if (l>f) or (r<s) then exit;
 if (s<=l) and (r<=f) then get2:=d2[v]
 else
  begin
  mi:=max(s,l);
  ma:=min(f,r);
  get2:=get2(s,f,2*v,l,(l+r) div 2)+get2(s,f,2*v+1,((l+r) div 2)+1,r)+
        k2[v]*sqr(double(ma-mi+1))/2+
        double(ma-mi+1)*(c2[v]+double(r-ma)*k2[v]);
  end;
 end;

begin
fillchar(d1,sizeof(d1),0);
fillchar(c1,sizeof(c1),0);
fillchar(k1,sizeof(k1),0);
fillchar(d2,sizeof(d2),0);
fillchar(c2,sizeof(c2),0);
fillchar(k2,sizeof(k2),0);
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n);
for i:=1 to n do
 begin
 read(c);
 if c='A' then
  begin
  read(c); read(c);
  readln(x,p);
  set1(x-p+1,x,1,1,p2);
  set2(x+1,x+p,1,1,p2);
  end
 else
  begin
  read(c); read(c); read(c); read(c);
  readln(x1,x2);
  if x1>x2 then
   begin
   p:=x1;
   x1:=x2;
   x2:=p;
   end;
  writeln(get1(x1+1,x2,1,1,p2)+get2(x1+1,x2,1,1,p2):0:3);
  end
 end;
close(output);
end.

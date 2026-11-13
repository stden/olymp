{$M 16000000}
{$H+,B-}
{$I-,Q-,R-,S-}
uses
 Math;
const
 root = 1;
 maxN = 1 shl 17;
type
 int  = longint;
 TRec = record x,p:int; end;
var
 s:array[1..2*maxN]of int;
 l,r:array[1..2*maxN]of int;
 d:array[1..2*maxN]of TRec;
 n,k,i,j,x,p,x1,x2:int;
 ch:char;
 res,h1,h2:extended;

function sum(a,b:int):int;
begin
 sum := ((b*(b+1)) div 2)  - ((a*(a-1)) div 2);
end;

function sumInfl(x,p,l,r:int):int;
var h1,h2:int;
begin
 l:=max(l,x-p);
 r:=min(r,x+p);
 h1:=p-abs(x-l);
 h2:=p-abs(x-r);
 if (l>=x)or(r<=x) then begin
  sumInfl := sum(min(h1,h2),max(h1,h2));
 end else begin
  sumInfl := sum(h1,p)+sum(h2,p)-p;
 end;
end;

procedure relax(i:int);
begin
 s[i]:=s[2*i]+s[2*i+1];
 l[i]:=min(l[2*i],l[2*i+1]);
 r[i]:=max(r[2*i],r[2*i+1]);
end;

procedure initRSQ;
var i:int;
begin
 fillchar(s,sizeof(s),0);
 fillchar(d,sizeof(d),0);
 for i:=n to 2*n-1 do begin
  l[i]:=i-n+1;
  r[i]:=i-n+1;
 end;
 for i:=n-1 downto 1 do relax(i);
end;

procedure doChanges(v:int);
var i,j:int;
begin
 if (d[v].p=0) then exit;
 i:=d[v].x-d[v].p;
 j:=d[v].x+d[v].p;
 if (j<=l[v])or(r[v]<=i) then begin
  d[v].x:=0; d[v].p:=0; exit;
 end;
 s[v] := s[v] + sumInfl(d[v].x,d[v].p,l[v],r[v]);
 if (i<=l[v])and(r[v]<=j) then begin
  if (v <= n-1) then begin
   doChanges(2*v);
   d[2*v].x:=d[v].x; d[2*v].p:=d[v].p;
   doChanges(2*v+1);
   d[2*v+1].x:=d[v].x; d[2*v+1].p:=d[v].p;
  end;
 end else
 if (j<=r[2*v]) then begin
  doChanges(2*v);
  d[2*v].x:=d[v].x; d[2*v].p:=d[v].p;
 end else
 if (i>=l[2*v+1]) then begin
  doChanges(2*v+1);
  d[2*v+1].x:=d[v].x; d[2*v+1].p:=d[v].p;
 end else begin
  doChanges(2*v);
  d[2*v].x:=d[v].x; d[2*v].p:=d[v].p;
  doChanges(2*v+1);
  d[2*v+1].x:=d[v].x; d[2*v+1].p:=d[v].p;
 end;
 d[v].x:=0; d[v].p:=0;
end;

procedure addDev(x,p:int);
begin
 doChanges(root);
 d[root].x:=x;
 d[root].p:=p;
end;

function getSum(v,i,j:int):int;
begin
 doChanges(v);
 if (i<=l[v])and(r[v]<=j) then begin
  getSum:=s[v];
 end else
 if (j<=r[2*v]) then begin
  getSum:=getSum(2*v,i,j);
 end else
 if (i>=l[2*v+1]) then begin
  getSum:=getSum(2*v+1,i,j);
 end else begin
  getSum:=getSum(2*v,i,j)+getSum(2*v+1,i,j);
 end;
end;

Begin
 assign(input, 'geology.in');
 reset(input);
 assign(output,'geology.out');
 rewrite(output);
 n:=maxN;
 initRSQ;
 readln(k);
 for i:=1 to k do begin
  read(ch);
  if (ch='A') then begin
   for j:=1 to 2 do read(ch);
   readln(x,p);
   addDev(x,p);
  end else begin
   for j:=1 to 4 do read(ch);
   readln(x1,x2);
   if (x1>x2) then begin x:=x1; x1:=x2; x2:=x; end;
   res:=0;
   if (x2-x1>=1) then begin
    h1:=getSum(root,x1,x1);
    h2:=getSum(root,x2,x2);
    res := (h1+h2)/2.0;
    if (x2-x1>=2) then res := res + getSum(root,x1+1,x2-1);
   end else res:=0;
   writeln(res:0:3);
  end;
 end;
 close(output);
End.

{$M 16000000}
{$H+,B-}
{$I-,Q-,R-,S-}
uses
 Math;
const
 INF  = 1000000001;
 maxN = 200;
type
 int  = longint;
var
 p,c,a,risk,s,r:array[1..maxN]of int;
 res,rn:array[0..10000]of int;
 n,maxS,i,v,w,x,y:int;

procedure getAnswer(v:int);
var v0,sc,rc:int;
begin
 v0:=v;
 sc:=0; rc:=0;
 repeat
  if (sc<c[v]-a[v]+1) then inc(rc,risk[v]);
  sc:=sc+a[v];
  v:=p[v];
 until (v=1);
 s[v0]:=sc; r[v0]:=rc;
end;

Begin
 assign(input, 'system.in');
 reset(input);
 assign(output,'system.out');
 rewrite(output);
 //Input
 read(n);
 for i:=1 to n do
  read(p[i],c[i],a[i],risk[i]);
 //
 for w:=2 to n do
  getAnswer(w);
 //
 maxS := c[1]-a[1]+1;
 for x:=1 to maxS do res[x]:=INF;
 res[0]:=0;
 for w:=2 to n do begin
  rn:=res;
  for x:=0 to maxS-1 do if (res[x]<>INF) then begin
   y:=min(x+s[w],maxS);
   rn[y]:=min(rn[y],res[x]+r[w]);
  end;
  res:=rn;
 end;
 writeln(min(res[maxS],risk[1]));
 close(output);
End.

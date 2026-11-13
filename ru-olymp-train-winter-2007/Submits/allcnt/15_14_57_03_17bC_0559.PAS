{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
uses
 Math;
const
 INF  = 1000000001;
 maxN = 10000;
type
 int  = longint;
var
 c:array[0..maxN,1..3]of int;
 d:array[0..maxN]of int;
 n,i,k:int;

Begin
 assign(input, 'linguae.in');
 reset(input);
 assign(output,'linguae.out');
 rewrite(output);
 read(n);
 for i:=0 to n-1 do
  for k:=1 to 3 do
   read(c[i,k]);
 for i:=0 to n-1 do begin
  if (i>=1) then begin
   c[i,1]:=min(c[i,1],c[i-1,2]);
   c[i,2]:=min(c[i,2],c[i-1,3]);
  end;
  if (i>=2) then
   c[i,1]:=min(c[i,1],c[i-2,3]);
 end;
 for i:=1 to n do d[i]:=INF;
 d[0]:=0;
 for i:=0 to n-1 do
  for k:=1 to 3 do
   d[min(i+k,n)] := min( d[min(i+k,n)] , d[i]+c[i,k] );
 writeln(d[n]);
 close(output);
End.

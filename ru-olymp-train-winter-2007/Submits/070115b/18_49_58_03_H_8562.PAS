//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
const
 maxN = 50000+1;
 imp  = 'IMPOSSIBLE';
type
 int  = longint;
var
 a,h:array[0..maxN]of int;
 n,hs,pos,x,i,t:int;

procedure swap(i,j:int);
var t:int;
begin
 t:=h[i]; h[i]:=h[j]; h[j]:=t;
end;

procedure siftdown(i:int);
var j:int;
begin
 while (2*i <= hs) do begin
  if (h[2*i]>h[i]) then j:=2*i else j:=i;
  if (2*i+1<=hs)and(h[2*i+1]>h[j]) then j:=2*i+1;
  if (i=j) then break;
  swap(i,j);
  i:=j;
 end;
end;

procedure sort(l,r:int);
var n,i:int;
begin
 n:=r-l+1;
 for i:=l to r do
  h[i-l+1]:=a[i];
 hs:=n;
 for i:=(n div 2) downto 1 do
  siftdown(i);
 while (hs>1) do begin
  swap(1,hs);
  dec(hs);
  siftdown(1);
 end;
 for i:=l to r do
  a[i]:=h[i-l+1];
end;

Begin
 assign(input, 'nextperm.in');
 reset(input);
 assign(output,'nextperm.out');
 rewrite(output);
 read(n);
 a[0]:=0;
 for i:=1 to n do read(a[i]);
 pos:=n;
 while (a[pos-1]>a[pos]) do dec(pos);
 if (pos=1) then writeln(imp) else begin
  x:=pos;
  for i:=pos to n do
   if (a[pos-1]<a[i])and(a[i]<a[x]) then x:=i;
  t:=a[pos-1]; a[pos-1]:=a[x]; a[x]:=t;
  sort(pos,n);
  for i:=1 to n do write(a[i],' ');
 end;

 close(output);
End.

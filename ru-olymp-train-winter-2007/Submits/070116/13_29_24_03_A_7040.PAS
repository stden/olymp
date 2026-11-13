{$B-,I-,Q-,R-,S-}
const
 maxN = 15;
type
 int  = longint;
var
 a,b:array[1..maxN,1..maxN]of boolean;
 p:array[1..maxN]of int;
 used:array[1..maxN]of boolean;
 n,m,i,v,w:int;
 act:int64;

procedure printRes(res:boolean);
var i:int;
begin
 if (res) then begin
  writeln('YES');
  for i:=1 to m do
   write(p[i],' ');
  end else writeln('NO');
 close(output);
 halt(0);
end;

procedure gen(pos:int);
var i,j,x:int;
begin
 if (pos=m+1) then begin
  for i:=1 to m do
   for j:=i+1 to m do
    if (b[i,j] xor a[p[i],p[j]]) then exit;
  printRes(true);
 end else begin
  for x:=1 to n do
   if (not used[x]) then begin
    p[pos]:=x;
    used[x]:=true;
    gen(pos+1);
    used[x]:=false;
   end;
 end;
end;

Begin
 assign(input, 'map.in');
 reset(input);
 assign(output,'map.out');
 rewrite(output);
 read(m);
 fillchar(b,sizeof(b),0);
 for i:=1 to m-1 do begin
  read(v,w);
  b[v,w]:=true;
  b[w,v]:=true;
 end;
 read(n);
 fillchar(a,sizeof(a),0);
 for i:=1 to n-1 do begin
  read(v,w);
  a[v,w]:=true;
  a[w,v]:=true;
 end;
 act:=1;
 for i:=1 to m do begin
  act:=act*(n-i);
  if (act>1e7) then printRes(false);
 end;
 fillchar(used,sizeof(used),false);
 gen(1);
 printRes(false);
 //close(output);
End.

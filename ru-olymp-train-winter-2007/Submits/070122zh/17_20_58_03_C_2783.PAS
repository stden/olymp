{$M 16000000}
{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 maxN = 200;
type
 int  = longint;
 TArr = array[0..maxN]of int;
var
 a:array[1..maxN]of TArr;
 b,ne:TArr;
 n,k,x,y,i,j,l,t:int;
 ok:boolean;

procedure sort(var a:TArr);
var i,j,t:int;
begin
 for i:=1 to a[0]-1 do
  for j:=1 to a[0]-i do
   if (a[j]>a[j+1]) then begin
    t:=a[j]; a[j]:=a[j+1]; a[j+1]:=t;
    end;
end;

function next(a,b:TArr):TArr;
var n,i,j,t:int;
begin
 n:=b[0];
 for i:=1 to a[0] do
  for j:=1 to b[0] do
   if (a[i]=b[j]) then begin a[i]:=j; break; end;
 //
 if (a[a[0]]=n) then begin
  dec(a[0]);
  inc(a[a[0]]);
 end else begin
  inc(a[0]);
  a[a[0]]:=a[a[0]-1]+1;
 end;
 //
 for i:=1 to a[0] do
  a[i]:=b[a[i]];
 next:=a;
end;

Begin
 assign(input,'partitions.in');
 reset(input);
 assign(output,'partitions.out');
 rewrite(output);
 while (true) do begin
  readln(n,k);
  if (n=0)and(k=0) then break;
  fillchar(a,sizeof(a),0);
  for i:=1 to k do begin
   repeat
    read(x);
    inc(a[i][0]);
    a[i][a[i][0]]:=x;
   until seekeoln;
   readln;
  end;
  b[0]:=0;
  for i:=k downto 1 do begin
   for j:=1 to a[i][0] do begin
    inc(b[0]);
    b[b[0]]:=a[i][j];
   end;
   sort(b);
   if (a[i][0]=1)and(a[i][1]=b[b[0]]) then continue;
   ne:=next(a[i],b);
   ok:=true;
   for j:=1 to b[0] do
    if (b[j]<ne[1]) then begin ok:=false; break; end;
   if (ok) then break;
  end;
  if (not ok) then begin
   writeln(n,' ',n);
   for j:=1 to n do writeln(j);
  end else begin
   k:=i;
   for l:=1 to ne[0] do
    for j:=1 to b[0] do
     if (b[j]=ne[l]) then begin
      b[j]:=b[b[0]]; dec(b[0]);
      break;
     end;
   sort(b);
   writeln(n,' ',(k-1)+1+b[0]);
   for j:=1 to k-1 do begin
    for l:=1 to a[j][0] do write(a[j][l],' ');
    writeln;
   end;
   for j:=1 to ne[0] do
    write(ne[j],' ');
   writeln;
   for j:=1 to b[0] do
    writeln(b[j]);
  end;
  writeln;
 end;
 close(output);
End.

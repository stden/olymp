//{$B-,H+,I+,Q+,R+,S+}
{$B-,H+,I-,Q-,R-,S-}
const
 INF  = 1000000001;
 maxL = 10000;
type
 int  = longint;
var
 s:string;
 a:array[1..maxL]of int;
 n,i:int;
 res:boolean;

function wout1(l,r:int):boolean; forward;
function with1(l,r:int):boolean; forward;

function Rev(x:int):int;
var res:int;
begin
 res := 0;
 while (x>0) do begin
  res := 10*res + (x mod 10);
  x := x div 10;
 end;
 Rev := res;
end;

procedure minus1(pos:int);
begin
 while (a[pos]=0) do begin
  a[pos]:=9;
  dec(pos);
 end;
 dec(a[pos]);
end;

function wout1(l,r:int):boolean;
var n,x,i:int;
begin
 if (l+1>=r) then begin
  n := 0; //
  for i:=l to r do
   n := 10*n + a[i];
  wout1 := false;
  for x:=1 to 99 do begin
   if (x>n) then break;
   if (x + Rev(x) = n) then begin wout1:=true; break; end;
  end;
  exit;
 end;
 if (a[l]=a[r])   then wout1 := wout1(l+1,r-1) else
 if (a[l]=a[r]+1) then wout1 := with1(l+1,r-1) else wout1 := false;
end;

function with1(l,r:int):boolean;
var n,x,i:int;
begin
 if (l+1>=r) then begin
  n := 1; //leading 1
  for i:=l to r do
   n := 10*n + a[i];
  with1 := false;
  for x:=1 to 99 do begin
   if (x>n) then break;
   if (x + Rev(x) = n) then begin with1:=true; break; end;
  end;
  exit;
 end;
 if (a[l]=0)and(a[r]=9) then begin
  with1 := with1(l+1,r-1);
  exit;
 end;
 minus1(r-1);
 if (a[l]=a[r])   then begin
  with1:=(wout1(l+1,r-1)and(a[r]<=8));
 end else
 if (a[l]=a[r]+1) then begin
  with1:=(with1(l+1,r-1)and(a[r]<=8));
 end else with1:=false;
end;

Begin
 assign(input, 'reverse.in');
 reset(input);
 assign(output,'reverse.out');
 rewrite(output);
 readln(s);
 while (s[1]<>'0') do begin
  n := length(s);
  for i:=1 to n do
   a[i] := ord(s[i]) - ord('0');
  res := wout1(1,n) OR ((a[1]=1) and with1(2,n));
  if (res)
   then writeln('YES')
   else writeln('NO');
  readln(s);
 end;
 close(output);
End.

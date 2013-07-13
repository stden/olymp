{$M 16000000}
{$H-,B-}
{$I-,Q-,R-,S-}
uses
 Math;
const
 eps  = 1e-10;
 maxL = 1000;
 L2   = 11;
type
 int  = longint;
 TArr = array[0..maxL]of int;
 Frac = record a:TArr; k,n:int; end;
var
 sa,sb:string;
 a,b,c:Frac;
 x,y:extended;
 i:int;

function parse(s:string):Frac;
var
 res:Frac;
 i,poz:int;
begin
 res.n:=0;
 for i:=1 to length(s) do
  if (s[i]=';')or(s[i]=',') then inc(res.n) else
   if (s[i]='(') then res.k:=res.n-1;
 fillchar(res.a,sizeof(res.a),0);
 poz:=1;
 for i:=0 to res.n do begin
  while (not(s[poz] in ['0'..'9'])) do inc(poz);
  while (s[poz] in ['0'..'9']) do begin
   res.a[i] := 10*res.a[i] + ord(s[poz])-ord('0');
   inc(poz);
  end;
 end;
 parse:=res;
end;

function calc(f:Frac):extended;
var
 res:extended;
 i:int;
begin
 for i:=f.n+1 to maxL do
  f.a[i] := f.a[f.k+1+((i-1) mod (f.n-f.k))];
 res:=f.a[maxL];
 for i:=maxL-1 downto 0 do
  res := f.a[i] + 1/res;
 calc:=res;
end;

function make(val:extended):Frac;
var
 a:TArr;
 f:Frac;
 i,j,l,k:int;
 period:boolean;
begin
 for i:=0 to maxL do begin
  a[i]:=round(floor(val));
  if (val-a[i]<eps) then break;
  val:=1/(val-a[i]);
 end;
 make.n:=-1;
 for l:=1 to L2 do
  for i:=1 to L2-2*l+1 do begin
   j:=i+l-1;
   period:=true;
   for k:=j+1 to L2 do
    if (a[i+((k-1) mod l)]<>a[k]) then period:=false;
   if (period) then begin
    f.a:=a;
    f.k:=i-1;
    f.n:=j;
    make:=f;
    exit;
   end;
  end;
end;

Begin
 assign(input, 'aplusb.in');
 reset(input);
 assign(output,'aplusb.out');
 rewrite(output);
 readln(sa);
 a:=parse(sa);
 readln(sb);
 b:=parse(sb);
 x:=calc(a);
 y:=calc(b);
 c:=make(x+y);
 if (c.n=-1) then begin
  writeln('Impossible');
 end else begin
  write('[',c.a[0],';');
  for i:=1 to c.k do
   write(c.a[i],',');
  write('(');
  for i:=c.k+1 to c.n-1 do
   write(c.a[i],',');
  write(c.a[c.n]);
  writeln(')]');
 end;
 close(output);
End.

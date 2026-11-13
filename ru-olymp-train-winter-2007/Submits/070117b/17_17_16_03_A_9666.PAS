{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 INF  = 1000000001;
type
 int  = longint;
var
 a:array[1..44,'a'..'z']of int64;
 n,i:int;
 c,d:char;
 res:int64;

Begin
 assign(input, 'badsubstr.in');
 reset(input);
 assign(output,'badsubstr.out');
 rewrite(output);
 read(n);
 a[1,'a']:=1; a[1,'b']:=1; a[1,'c']:=1;
 for i:=2 to n do
  for c:='a' to 'c' do begin
   a[i,c]:=0;
   for d:='a' to 'c' do
    if (d+c<>'ab') then a[i,c]:=a[i,c]+a[i-1,d];
  end;
 if (n<>0) then begin
  res:=0;
  for c:='a' to 'z' do
   res := res + a[n,c];
 end else res:=1;
 writeln(res);
 close(output);
End.

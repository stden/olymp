//{$H-,B-,I+,Q+,R+,S+}
{$H+,B-,I-,Q-,R-,S-}
const
 maxL = 20000000;
type
 int  = longint;
var
 s,p:string;
 d:array[1..maxL]of int;
 n,m,i,j,k,q:int;

procedure prefix;
var i,q:int;
begin
 d[1]:=0; q:=0;
 for i:=2 to n do begin
  while (q>0)and(p[q+1]<>p[i]) do q:=d[q];
  if (p[q+1]=p[i]) then inc(q);
  d[i]:=q;
 end;
end;


Begin
 assign(input, 'rle.in');
 reset(input);
 assign(output,'rle.out');
 rewrite(output);
 readln(s); n:=length(s);
 p:='';
 i:=1;
 while (i<=n) do begin
  if ('a'<=s[i])and(s[i]<='z') then begin
   p:=p+s[i];
   inc(i);
  end else begin
   k:=0;
   while ('0'<=s[i])and(s[i]<='9') do begin
    k := 10*k + ord(s[i])-ord('0');
    inc(i);
   end;
   for j:=1 to k do
    p:=p+s[i];
   inc(i);
  end;
 end;
 n:=length(p);
 prefix;
 read(m);
 for i:=1 to m do begin
  read(q);
  writeln(d[q]);
 end;
 close(output);
End.

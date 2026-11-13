{$H+,B-}
{$I+,Q+,R+,S+}
//{$I-,Q-,R-,S-}
const
 maxL = 10000;
type
 int  = longint;
var
 a:array[0..maxL,0..maxL]of boolean;
 p,s:array[1..maxL]of char;
 str:string;
 m,n,i,j:int;

Begin
 assign(input, 'patterns.in');
 reset(input);
 assign(output,'patterns.out');
 rewrite(output);
 readln(str);
 m:=length(str);
 for i:=1 to m do p[i]:=str[i];
 readln(str);
 n:=length(str);
 for i:=1 to n do s[i]:=str[i];
 a[0,0]:=true;
 i:=1;
 while (i<=m)and(p[i]='*') do begin
  a[i,0]:=true;
  inc(i);
 end;
 for i:=1 to m do
  for j:=1 to n do begin
   if (p[i]='?')or(p[i]=s[j]) then a[i,j]:=a[i-1,j-1] else
   if (p[i]='*') then a[i,j]:=(a[i,j-1] or a[i-1,j]);
  end;
 if (a[m,n])
  then writeln('YES')
  else writeln('NO');
 close(output);
End.

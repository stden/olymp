{$H+,B-}
{$I+,Q+,R+,S+}
//{$I-,Q-,R-,S-}
const
 maxL = 10000;
type
 int  = longint;
var
 a,ao:array[0..maxL]of boolean;
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
 //Init
 fillchar(a,sizeof(a),false);
 a[0]:=true;
 j:=1;
 while (j<=m)and(p[j]='*') do begin
  a[j]:=true;
  inc(j);
 end;
 //Solve
 for i:=1 to n do begin
  ao:=a;
  fillchar(a,sizeof(a),false);
  for j:=1 to m do begin
   if (p[j]='?')or(s[i]=p[j]) then a[j]:=ao[j-1] else
   if (p[j]='*') then a[j]:=(a[j-1] or ao[j]);
  end;
 end;
 //Out
 if (a[m])
  then writeln('YES')
  else writeln('NO');
 close(output);
End.

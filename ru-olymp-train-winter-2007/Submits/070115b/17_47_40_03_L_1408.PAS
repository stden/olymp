//{$H-,B-,I-,Q+,R+,S+}
{$H+,B-,I-,Q-,R-,S-}
const
 INF  = 1000000001;
type
 int  = longint;
var
 d:array[1..10000]of int;
 t,p:string;
 n,m:int;
 ch:char;

function next():char;
var ch:char;
begin
 ch:=#0;
 while (not eof()) do begin
  read(ch);
  if (33<=ord(ch))and(ord(ch)<=126) then break;
 end;
 if not ((33<=ord(ch))and(ord(ch)<=126)) then ch:=#0;
end;

procedure prefix;
var i,q:int;
begin
 d[1]:=0; q:=0;
 for i:=2 to m do begin
  while (q>0)and(p[q]<>p[i]) do q:=d[q];
  if (p[q+1]=p[i]) then inc(q);
  d[i]:=q;
 end;
end;

procedure kmp;
var i,q:int;
begin
 q:=0;
 for i:=1 to n do begin
  while (q>0)and(p[q]<>t[i]) do q:=d[q];
  if (p[q+1]=t[i]) then inc(q);
  if (q=m) then begin
   writeln(i-m+1);
   q:=d[q];
  end;
 end;
end;

Begin
 assign(input, 'substr.in');
 reset(input);
 assign(output,'substr.out');
 rewrite(output);
 p:='';
 ch:=next();
 while (ch<>'*') do begin
  p:=p+ch;
  ch:=next();
 end;
 t:='';
 ch:=next();
 while true do begin
  t:=t+ch;
  ch:=next();
  if (ch=#0) then break;
 end;
 //solve
 n:=length(t); m:=length(p);
 prefix;
 kmp;
 close(output);
End.

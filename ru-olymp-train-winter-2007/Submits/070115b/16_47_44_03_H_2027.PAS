{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 INF  = 1000000001;
 maxN = 50000;
type
 int  = longint;
var
 a,p:array[1..maxN]of int;
 used:array[1..maxN]of boolean;
 n,cnt,i:int;
 res:boolean;

procedure gen(pos:int);
var x,st:int;
begin
 if (pos=n+1) then begin
  inc(cnt);
  if (cnt=2) then begin
   for i:=1 to n do write(p[i],' ');
   close(output);
   halt(0);
  end;
  exit;
 end;
 if (cnt=0) then st:=a[pos] else st:=1;
 for x:=st to n do
  if (not used[x]) then begin
   p[pos]:=x;
   used[x]:=true;
   gen(pos+1);
   used[x]:=false;
  end;
end;

Begin
 assign(input, 'nextperm.in');
 reset(input);
 assign(output,'nextperm.out');
 rewrite(output);
 read(n);
 for i:=1 to n do read(a[i]);
 res:=false;
 for i:=1 to n do
  if (a[i]<>n-i+1) then res:=true;
 if (res) then begin
  fillchar(used,sizeof(used),0);
  cnt:=0;
  gen(1);
 end else writeln('IMPOSSIBLE');
 close(output);
End.

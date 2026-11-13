{$M 16000000}
{$H+,B-}
{$I+,Q+,R+,S+}
//{$I-,Q-,R-,S-}
const
 maxN = 5000;
type
 int  = longint;
 Stack = array[0..maxN]of int;
var
 a:array[1..maxN,1..maxN]of int;
 res:array[1..maxN]of Stack;
 vis,need:array[1..maxN]of int;
 s:stack;
 str:string;
 n,i,j,k,poz,x,v:int;

function getNum(c:char):int;
begin
 if ('0'<=c)and(c<='9') then getNum:=ord(c)-ord('0') else
 if ('A'<=c)and(c<='Z') then getNum:=ord(c)-ord('A')+10 else
 if ('a'<=c)and(c<='z') then getNum:=ord(c)-ord('a')+36 else
 if (c='!') then getNum:=62 else getNum:=63;
end;

procedure push(var s:Stack;x:int);
begin
 inc(s[0]);
 s[s[0]]:=x;
end;

procedure dfs(v,L:int);
var w:int;
begin
 if (vis[v]=0) then vis[v]:=1;
 push(s,v);
 for w:=1 to n do if (a[v,w]=1) then
  if (vis[w]=0) then dfs(w,L+1) else
  if (vis[w]=2)and(need[L+1]=1) then begin
   res[L+1]:=s;
   need[L+1]:=2;
  end;
end;

Begin
 assign(input, 'tourism.in');
 reset(input);
 assign(output,'tourism.out');
 rewrite(output);
 //Input
 readln(n);
 readln(str);
 read(k);
 fillchar(need,sizeof(need),0);
 for i:=1 to k do begin
  read(j);
  need[j]:=1;
 end;
 s[0]:=0;
 for i:=1 to length(str) do begin
  x:=getNum(str[i]);
  for j:=1 to 6 do begin
   push(s,(x mod 2));
   x:=(x div 2);
  end;
 end;
 fillchar(a,sizeof(a),0);
 poz:=1;
 for i:=1 to n-1 do
  for j:=i+1 to n do begin
   a[i,j]:=s[poz];
   a[j,i]:=(a[i,j]+1) mod 2;
   inc(poz);
  end;
 //Solve
 fillchar(res,sizeof(res),0);
 for v:=1 to n do begin
  fillchar(s,sizeof(s),0);
  fillchar(vis,sizeof(vis),0);
  vis[v]:=2;
  dfs(v,0);
 end;
 //Out
 for i:=1 to n do
  if (need[i]=1) then writeln(-1) else
  if (need[i]=2) then begin
   for j:=1 to res[i][0] do write(res[i][j]-1,' ');
   writeln;
  end;
 close(output);
End.

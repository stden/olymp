{$M 16000000}
{$H+,B-}
{$I-,Q-,R-,S-}
const
 maxN = 4004;
 INF  = 3*maxN+7;
type
 int  = integer;
 Stack = array[0..maxN]of int;
var
 a:array[1..maxN,1..maxN]of boolean;
 res:array[1..maxN]of Stack;
 h,b:array[1..maxN]of int;
 have,ho,hi,fc:array[1..maxN]of boolean;
 s,c:stack;
 str:string;
 n,L,i,j,k,poz,x,v,w:int;

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
var w,j,cl:int;
begin
 h[v]:=L;
 push(s,v);
 for w:=1 to n do if (a[v,w]) then
  if (h[w]=-1) then dfs(w,L+1) else
  if (h[w]<>INF)and(not have[L-h[w]+1]) then begin
   cl:=L-h[w]+1;
   for j:=h[w]+1 to L+1 do
    push(res[cl],s[j]);
   have[cl]:=true;
  end;
 h[v]:=INF;
end;

Begin
 assign(input, 'tourism.in');
 reset(input);
 assign(output,'tourism.out');
 rewrite(output);
 //Input
 readln(n);
 //A
 readln(str);
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
   a[i,j]:=(s[poz]=1);
   a[j,i]:=(not a[i,j]);
   inc(poz);
  end;
 //
 read(k);
 for i:=1 to k do
  read(b[i]);
 //Solve
 fillchar(res,sizeof(res),0);
 fillchar(have,sizeof(have),false);
 //L=3
 for v:=1 to n do begin
  for w:=1 to n do
   if (a[v,w])and(a[w,1])and(a[1,v]) then begin
    have[3]:=true;
    push(res[3],v);
    push(res[3],w);
    push(res[3],1);
    break;
   end;
  if (have[3]) then break;
 end;
 //DFS heuristics
 for v:=1 to n do begin
  fillchar(s,sizeof(s),0);
  for w:=1 to n do h[w]:=-1;
  dfs(v,0);
 end;
 //R-C
 for L:=4 to n do
  if (not have[L]) then begin
   c:=res[L-1];
   fillchar(fc,sizeof(fc),false);
   for i:=1 to c[0] do fc[c[i]]:=true;
   fillchar(hi,sizeof(hi),false); ho:=hi;
   for v:=1 to n do if (not fc[v]) then begin
    for i:=1 to c[0] do
     if (a[v,c[i]]) then hi[v]:=true else ho[v]:=true;
    if (hi[v])and(ho[v]) then break;
   end;
   if (v<=n)and(hi[v])and(ho[v]) then begin
    push(c,c[1]);
    for i:=1 to c[0]-1 do
     if (a[c[i],v])and(a[v,c[i+1]]) then begin
      for j:=c[0] downto i+2 do
       c[j]:=c[j-1];
      c[i+1]:=v;
      res[L]:=c;
      have[L]:=true;
      break;
     end;
   end else begin
    for v:=1 to n do begin
     for w:=1 to n do
      if (a[v,w])and(hi[w])and(ho[v]) then begin
       push(res[L],w);
       for j:=1 to L-2 do
        push(res[L],c[j]);
       push(res[L],v);
       have[L]:=true;
       break;
      end;
     if (have[L]) then break;
    end;
   end;
  end;
 //Out
 for i:=1 to k do
  if (b[i]<=n)and(have[b[i]]) then begin
   for j:=1 to res[b[i]][0] do write(res[b[i]][j]-1,' ');
   writeln;
  end else writeln(-1);
 close(output);
End.

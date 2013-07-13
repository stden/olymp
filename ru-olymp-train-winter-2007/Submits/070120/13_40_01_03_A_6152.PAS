{$M 16000000}
//{$H+,B-,I+,Q+,R+,S+}
{$H+,B-,I-,Q-,R-,S-}
const
 root = 1;
 maxN = 100;
 maxV = 10000;
type
 int  = longint;
var
 e              : array[1..maxV,'a'..'z']of int;
 lp,suff,outl   : array[1..maxV]of int;
 c              : array[1..maxV]of int64;
 mx             : array[0..maxN,1..maxV]of int64;
 p,SLp          : array[0..maxN,1..maxV]of int;
 n,k,free,i,res,len,v,w,cost:int;
 word:string;
 x:char;

procedure add(const s:string;cost:int64);
var v,pos,i:int;
begin
 v:=root; pos:=1;
 while (pos<=length(s))and(e[v,s[pos]]<>0) do begin
  v:=e[v,s[pos]];
  inc(pos);
 end;
 for i:=pos to length(s) do begin
  e[v,s[i]]:=free;
  v:=free;
  inc(free);
 end;
 c[v] := c[v] + cost;
end;

procedure BFS;
var
 list,prev:array[1..maxV]of int;
 p,q,v,vs,w:int;
 x:char;
begin
 fillchar(suff,sizeof(suff),0);
 fillchar(outl,sizeof(outl),0);
 //BFS
 fillchar(prev,sizeof(prev),0);
 p:=1; list[p]:=root; q:=1;
 while (p<=q) do begin
  v:=list[p]; inc(p);
  //suffix link
  if (v<>root)and(prev[v]<>root) then begin
   vs:=prev[v];
   for x:='a' to 'z' do
    if (e[vs,x]=v) then break;
   w:=suff[vs];
   while (e[w,x]=0)and(w<>root) do
    w:=suff[w];
   if (e[w,x]<>0)
    then suff[v]:=e[w,x]
    else suff[v]:=root;
  end else suff[v]:=root;
  //output link & cost
  if (c[suff[v]]>0)
   then outl[v]:=suff[v]
   else outl[v]:=outl[suff[v]];
  if (outl[v]>0)
   then c[v]:=c[v]+c[outl[v]];
  //children
  for x:='a' to 'z' do if (e[v,x]<>0) then begin
   inc(q); list[q]:=e[v,x];
   prev[e[v,x]]:=v;
   lp[e[v,x]]:=lp[v]+1;
  end;
 end;
end;

procedure relaxForSL(v,i:int);
var w,v0:int;
begin
 v0:=v;
 while (v<>root)and(suff[v]>0) do begin
  w:=suff[v];
  if (mx[i,w] <= mx[i,v]) then begin
   mx[i,w] := mx[i,v];
   p[i, w] := p[i, v];
   SLp[i,w]:=v0;
  end;
  v:=w;
 end;
end;

procedure printPath(w,i:int);
var
 v:int;
 x:char;
begin
 if (i=0) then exit;
 if (SLp[i,w]>0) then w:=SLp[i,w];
 v:=p[i,w];
 printPath(v,i-1);
 for x:='a' to 'z' do
  if (e[v,x]=w) then begin
   write(x);
   break;
  end;
end;

Begin
 assign(input, 'beauty.in');
 reset(input);
 assign(output,'beauty.out');
 rewrite(output);
 //Making tree
 fillchar(e,sizeof(e),0);
 fillchar(c,sizeof(c),0);
 free:=2;
 readln(k);
 for i:=1 to k do begin
  word:='';
  read(x);
  while (x<>' ') do begin
   word:=word+x;
   read(x);
  end;
  readln(cost);
  add(word, cost);
 end;
 //Values for tree vertices
 BFS;
 //Solve
 n:=free-1;
 readln(len);
 fillchar(mx,sizeof(mx),0);
 fillchar(p,sizeof(p),0);
 fillchar(SLp,sizeof(SLp),0);
 p[0,root]:=root;
 for i:=1 to len do begin
  for v:=1 to n do if (p[i-1,v]>0) then
   for x:='a' to 'z' do if (e[v,x]<>0) then begin
    w:=e[v,x];
    if (mx[i,w] <= mx[i-1,v]+c[w]) then begin
     mx[i,w] := mx[i-1,v]+c[w];
     p[i,w]:=v;
    end;
   end;
  for v:=1 to n do
   if (p[i,v]>0) then relaxForSL(v,i);
 end;
 //Out
 v:=1;
 for w:=2 to n do
  if (mx[len,v]<mx[len,w]) then v:=w;
 writeln(mx[len,v]);
 printPath(v,len);
 close(output);
End.

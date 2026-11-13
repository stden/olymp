uses treeunit;
const maxn = 200000;
type queue = record
   l,r:longint;
   a:array[1..maxn] of longint;
end;
procedure enqueue(var q:queue; k:longint);
begin
 q.r:=q.r+1;
 q.a[q.r]:=k;
end;
function dequeue(var q:queue):longint;
var res:longint;
begin
 res:=q.a[q.l];
 q.l:=q.l+1;
 dequeue:=res;
end;
function empty(var q:queue):boolean;
begin
 if q.l>q.r then empty:=true else empty:=false;
end;
procedure clean(var q:queue);
begin
 q.r:=0;
 q.l:=1;
end;
var n:longint;
   m:array[1..maxn] of array of longint;
   o:array[1..maxn] of array of longint;
   l,p,reber:array[1..maxn] of longint;
   k,f:array[1..maxn] of boolean;
   q:queue;
   root,steps,max,a,b,i,aa,bb,edge:longint;
   curr:longint;
procedure block(v,stop:longint);
begin
 f[v]:=false;
 for i:=0 to length(m[v])-1 do if f[m[v,i]] then if m[v,i]<>stop then begin
  reber[v]:=reber[v]-1;
  reber[m[v,i]]:=reber[m[v,i]]-1;
  block(m[v,i],stop);
 end;
end;
begin
 fillchar(f,sizeof(f),true);
 fillchar(reber,sizeof(reber),0);
 init;
 n:=getN;
 for i:=1 to n-1 do begin
  a:=getA(i);
  b:=getB(i);
  setlength(m[a],length(m[a])+1);
  setlength(o[a],length(o[a])+1);
  setlength(m[b],length(m[b])+1);
  setlength(o[b],length(o[b])+1);
  m[a,length(m[a])-1]:=b;
  o[b,length(m[b])-1]:=i;
  o[a,length(m[a])-1]:=i;
  m[b,length(m[b])-1]:=a;
  reber[a]:=reber[a]+1;
  reber[b]:=reber[b]+1;
 end;
 while true do begin
  clean(q);
  root:=1;
  while not f[root] do inc(root);
  for i:=root+1 to n do if (reber[i]<reber[root])and(f[i]) then begin root:=i; break; end;
{  writeln('finded new root: ',root);}
  fillchar(l,sizeof(l),-1);
  fillchar(p,sizeof(p),-1);
  l[root]:=0;
  p[root]:=0;
  enqueue(q,root);
  fillchar(k,sizeof(k),true);
  while not empty(q) do begin
   curr:=dequeue(q);
   k[curr]:=false;
   for i:=0 to length(m[curr])-1 do if (k[m[curr,i]]) and (f[m[curr,i]]) then begin
    enqueue(q,m[curr,i]); l[m[curr,i]]:=l[curr]+1; p[m[curr,i]]:=curr;
   end;
  end;
  max:=1;
  for i:=2 to n do if l[i]>l[max] then max:=i;
  steps:=l[max] div 2;
{  writeln('finded maximal lengthae: ',max);}
  b:=max;
  for i:=1 to steps do b:=p[b];
  a:=p[b];
{  writeln('searhing edge between ',a,' and ',b);}
  for i:=0 to length(o[a])-1 do begin
   aa:=getA(o[a,i]);
   bb:=getB(o[a,i]);
   if ((aa=a)and(bb=b))or((aa=b)and(bb=a)) then begin edge:=o[a,i]; break; end;
  end;
{  writeln('edge: ',edge);}
  aa:=getA(edge);
  bb:=getB(edge);
  if query(edge)=0 then block(bb,aa) else block(aa,bb);
{  writeln('f next to the deleting:');}
{  for i:=1 to n do writeln('f[',i,']= ',f[i]);}
  steps:=0;
  edge:=0;
  for i:=1 to n do if f[i] then begin
   edge:=i; steps:=steps+1;
  end;
  if steps=1 then report(edge);
 end;
end.
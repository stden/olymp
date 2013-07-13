program sh;
const tn='linguae';
var a:array[1..3,-4..10001]of longint;
    i,j,n:longint;
    bst:array[0..10005]of longint;
function min(const a,b:longint):longint;
begin
 if a<b then min:=a else min:=b;
end;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 read(n);
 for i:=0 to n-1 do read(a[1,i],a[2,i],a[3,i]);
 a[1,-1]:=maxlongint div 2;
 a[2,-1]:=maxlongint div 2;
 a[3,-1]:=maxlongint div 2;
 a[1,-2]:=maxlongint div 2;
 a[2,-2]:=maxlongint div 2;
 a[3,-2]:=maxlongint div 2;
 a[1,-3]:=maxlongint div 2;
 a[2,-3]:=maxlongint div 2;
 a[3,-3]:=maxlongint div 2;
 a[1,-4]:=maxlongint div 2;
 a[2,-4]:=maxlongint div 2;
 a[3,-3]:=maxlongint div 2;
 bst[0]:=0;
 for i:=1 to n+5 do bst[i]:=maxlongint div 2;
 for j:=1 to n+3 do
  for i:=1 to n+3 do
  begin
   bst[i]:=min(bst[i+1],min(bst[i],min(bst[i-1]+a[1,i-1],min(bst[i-2]+a[2,i-2],bst[i-3]+a[3,i-3]))));
  end;
  writeln(bst[n]);
 close(input);close(output);
end.

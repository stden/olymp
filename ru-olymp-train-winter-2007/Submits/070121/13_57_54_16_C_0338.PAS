{$M 16000000}
uses Math;
const
 MaxN = 300000;


var
 n,i,j,p,k,ff:longint;
 x,y:array[0..MaxN] of int64;
 w,t:array[0..MaxN] of longint;
 u:array[0..MaxN] of boolean;
 st:array[0..MaxN] of longint;
 f:boolean;

procedure qsort(l,r:longint);
var
 i,j,m,tmp:longint;
begin
 if (l >= r) then exit;
 i:=l;
 j:=r;
 m:=x[t[l+random(r - l + 1)]];

 while i<j do begin
  while (x[t[i]] < m) do inc(i);
  while (x[t[j]] > m) do dec(j);
  if (i <= j) then begin
   tmp:=t[i];
   t[i]:=t[j];
   t[j]:=tmp;
   tmp:=w[i];
   w[i]:=w[j];
   w[j]:=tmp;
   inc(i);
   dec(j);
  end;
 end;
 qsort(l,j);
 qsort(i,r);
end;

function S(x1,y1,x2,y2,x3,y3:int64):int64;
begin
 S:=x1*y2 - x1*y3 + x2*y3 - x2*y1 + x3*y1 - x3*y2;
end;

procedure make(l, r, w:longint);
var
 c,i,j,k,h:longint;
begin
 c:=r-l+1;
 st[0]:=t[l];
 st[1]:=t[l+1];
 h:=2;
 i:=l+2;
 while (i <= r) do begin
  if (h = 1) or (w * S(x[st[h-2]], y[st[h-2]], x[st[h-1]], y[st[h-1]], x[t[i]], y[t[i]]) >= 0) then begin
   st[h]:=t[i];
   inc(h);
   inc(i);
  end else begin
   u[st[h-1]]:=true;
   writeln(st[h-2]+1,' ',st[h-1]+1,' ',t[i]+1);
   dec(h);
  end;
 end;
end;



begin
 randseed:=25566;
 fillchar(u,sizeof(u),0);
 assign(input,'tri.in');
 reset(input);
 assign(output,'tri.out');
 rewrite(output);
 read(n);
 for i:=0 to n-1 do begin
  read(x[i],y[i]);
 end;
 i:=0;
 while not(x[i]<x[(i+1) mod n]) do
  i:=(i+1) mod n;
 while not(x[i]>x[(i+1) mod n]) do
  i:=(i+1) mod n;
 j:=0;
 while not(x[i]<x[(i+1) mod n]) do begin
  t[j]:=i;
  w[j]:=-1;
  inc(j);
  i:=(i+1) mod n;
 end;
 while not(x[i]>x[(i+1) mod n]) do begin
  t[j]:=i;
  w[j]:=1;
  inc(j);
  i:=(i+1) mod n;
 end;

 qsort(0,n-1);

 j:=0;
 i:=1;
 while (j < n-2) do begin
  while (i < n - 2) and (w[i] = w[i+1]) do inc(i);
  if (j+1)<>i then begin
   make(j+1, i, -w[j+1]);
   ff:=j;
   p:=j+1;
   for k:=j+2 to i+1 do begin
    if (ff<>j)and(k+1>ff) then break;
    if not u[t[k]] then begin
     if (ff=j)and(w[j+1] * S(x[t[ff]], y[t[ff]], x[t[p]], y[t[p]], x[t[k]], y[t[k]]) <= 0) then begin
      ff:=i+1;
      writeln(t[j]+1,' ',t[i+1]+1,' ',t[p]+1);
     end;
     writeln(t[ff]+1,' ',t[p]+1,' ',t[k]+1);
     p:=k;
    end;
   end;
  end else begin
   writeln(t[j]+1,' ',t[i]+1,' ',t[i+1]+1);
  end;
  j:=i;
  inc(i);
 end;

 close(input);
 close(output);
end.

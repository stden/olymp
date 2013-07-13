{$M 32000000}
var
  k,i,j,p,l,f:longint;
  ch:char;
  d,td,num:array[0..10002] of longint;
  B:array[0..10002,0..25] of longint;
  g:array[0..10002] of int64;
  pref:array[0..10002] of longint;
  free:longint;
  a:array[0..100,0..10002] of int64;
  par:array[0..100,0..10002] of longint;
  parch:array[0..100,0..10002] of char;
  st:array[0..100] of char;

procedure qsort(l,r:longint);
var
 i,j,m,t:longint;
begin
 if (l >= r) then exit;
 i:=l;
 j:=r;
 m:=td[l+random(r - l + 1)];

 while i<j do begin
  while (td[i] < m) do inc(i);
  while (td[j] > m) do dec(j);
  if (i <= j) then begin
   t:=td[i];
   td[i]:=td[j];
   td[j]:=t;
   t:=num[i];
   num[i]:=num[j];
   num[j]:=t;
   inc(i);
   dec(j);
  end;
 end;
 qsort(l,j);
 qsort(i,r);
end;


procedure AXO;
const
 QS=100000;
var
 Q:array[0..QS]of longint;
 h,t,i,j:longint;
begin
 Q[0]:=0;
 pref[0]:=-1;
 h:=0;
 t:=1;
 while (h<>t) do begin
  i:=q[h];
  h:=h+1;
  if h>=qs then h:=h-qs;
  if i<>0 then
   g[i] := g[i] + g[pref[i]];
  for j:=0 to 25 do begin
   if B[i,j]<>-1 then begin
    Q[t]:=B[i,j];
    t:=t+1;
    if t>=qs then t:=t-qs;

    if i=0 then begin
     pref[B[i,j]]:=0;
    end else begin
     pref[B[i,j]]:=B[pref[i],j];
    end;

   end else begin
    if i=0 then
     B[i,j]:=0
    else
     B[i,j]:=B[pref[i],j];
   end;
  end;
 end;
end;

begin
 randseed:=25566;
 fillchar(B,sizeof(B),255);
 fillchar(g,sizeof(g),0);
 assign(input,'beauty.in');
 reset(input);
 assign(output,'beauty.out');
 rewrite(output);
 readln(k);
 free:=1;
 for i:=1 to k do begin
  read(ch);
  p:=0;
  while ch in ['a'..'z'] do begin
   if B[p,ord(ch)-ord('a')]=-1 then begin
    B[p,ord(ch)-ord('a')]:=free;
    inc(free);
   end;
   p:=B[p,ord(ch)-ord('a')];
   read(ch);
  end;
  readln(j);
  g[p]:=j;
 end;

 read(k);

 AXO;
 fillchar(d,sizeof(d),0);
 d[0]:=1;
 fillchar(a,sizeof(a),255);
 a[0,0]:=0;
 par[0,0]:=-1;

 for i:=1 to k do begin
  fillchar(td,sizeof(td),0);
  for j:=0 to free-1 do begin
   if a[i-1,j]=-1 then continue;
   for l:=0 to 25 do begin
    if (a[i,B[j,l]] < (a[i-1,j] + g[B[j,l]]))or( (a[i,B[j,l]] = (a[i-1,j] + g[B[j,l]])) and ((100000*d[j]+l) < td[B[j,l]]) ) then begin
     td[B[j,l]]:=100000*d[j]+l;
     a[i,B[j,l]]:=a[i-1,j] + g[B[j,l]];
     par[i,B[j,l]]:=j;
     parch[i,B[j,l]]:=chr(l+ord('a'));
    end;
   end;
  end;

  for j:=0 to free-1 do begin
   num[j]:=j;
  end;

  qsort(0,free-1);

  d[num[0]]:=0;
  f:=0;
  for j:=1 to free-1 do begin
   if td[j-1]<>td[j] then inc(f);
   d[num[j]]:=f;
  end;
 end;

 j:=0;
 for i:=0 to free-1 do begin
  if (a[k,i] > a[k,j])or((a[k,i]=a[k,j])and(d[i] < d[j])) then
   j:=i;
 end;
 writeln(a[k,j]);

 i:=k;
 while i<>0 do begin
  st[i]:=parch[i,j];
  j:=par[i,j];
  dec(i);
 end;

 for i:=1 to k do
  write(st[i]);
 close(input);
 close(output);
end.

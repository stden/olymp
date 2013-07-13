{$M 16000000}
const
 MaxN = 4010;
var
 ch:char;
 pos,n,q,w,i,j,k,kk:longint;
 G,TG:array[0..4010,0..4010] of boolean;
 s:array[0..4010] of longint;
 b,num,na:array[0..MaxN] of longint;
 ans:array[0..MaxN,0..MaxN] of integer;
 u:array[0..MaxN] of boolean;
 c,ne,p:array[0..MaxN] of longint;
 f:boolean;
procedure qsort(l,r:longint);
var
 i,j,m,t:longint;
begin
 if (l >= r) then exit;
 i:=l;
 j:=r;
 m:=b[l+random(r - l + 1)];

 while i<j do begin
  while (b[i] < m) do inc(i);
  while (b[j] > m) do dec(j);
  if (i <= j) then begin
   t:=b[i];
   b[i]:=b[j];
   b[j]:=t;
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


procedure decode(j:longint);
 var
  a,b,i:longint;
 begin
  if ch in['0'..'9'] then a:=ord(ch)-ord('0');
  if ch in['A'..'Z'] then a:=ord(ch)-ord('A')+10;
  if ch in['a'..'z'] then a:=ord(ch)-ord('a')+36;
  if ch ='!' then a:=62;
  if ch ='?' then a:=63;
  b:=0;
  for i:=j to j+5 do begin
   if (a mod 2)=1 then
    s[i]:=1
   else
    s[i]:=0;
   a:=a div 2;
  end;
 end;

procedure Build(i:longint);
 var
  j:longint;
 begin
  for j:=i+1 to n-1 do begin
   if s[j-i-1]=1 then
    G[i,j]:=true
   else
    G[j,i]:=true;
  end;
 end;


 procedure save;
 var
  i,j,k:longint;
 begin
  for i:=1 to kk do begin
   for j:=1 to na[i] do begin
    write(ans[i,j],' ');
   end;
   writeln;
  end;
  close(input);
  close(output);
  halt(0);
 end;


begin
 randseed:=25566;
 fillchar(G,sizeof(G),0);
 fillchar(TG,sizeof(TG),0);
 assign(input,'tourism.in');
 reset(input);
 assign(output,'tourism.out');
 rewrite(output);
 readln(n);
 j:=0;
 q:=0;
 for i:=1 to ((n*(n-1) div 2)+5)div 6 do begin
  read(ch);
  decode(j);
  j:=j+6;
  while (j>0)and(j>=(n-q-1)) do begin
   Build(q);
   for k:=n-q-1 to j-1 do
    s[k-n+q+1]:=s[k];
   j:=j-n+q;
   inc(q);
  end;
 end;

 read(kk);
 for i:=1 to kk do begin
  read(b[i]);
  num[i]:=i;
 end;

 qsort(1,kk);

 i:=1;
 while (i<=kk)and(b[i]<3) do begin
  na[num[i]]:=1;
  if b[i]=1  then
   ans[num[i],1]:=0;
  if b[i]=2 then
   ans[num[i],1]:=-1;
  inc(i);
 end;

 if i>kk then
  save;

 pos:=i;

 fillchar(u,sizeof(u),0);
 u[0]:=true;
 f:=false;
 c[0]:=0;

 for i:=1 to n-1 do begin
  if f then break;
  if not(G[0,i]) then continue;
  for j:=1 to n-1 do begin
   if G[i,j]and(G[j,0]) then begin
    f:=true;
    u[i]:=true;
    u[j]:=true;
    ne[0]:=1;
    c[1]:=i;
    ne[1]:=2;
    c[2]:=j;
    ne[2]:=0;
    break;
   end;
  end;
 end;

 i:=3;

 if i = b[pos] then begin
   na[num[pos]]:=i;
   ans[num[pos],1]:=0;
   k:=2;
   j:=ne[0];
   while j<>0 do begin
    ans[num[pos],k]:=c[j];
    j:=ne[j];
    inc(k);
   end;
   inc(pos);
  end;

  if pos > kk then Save;

 for i:=4 to n-1 do begin
  j:=0;
  f:=false;

  for k:=1 to i-1 do begin
   if f then break;
   for q:=0 to n-1 do
    if u[q] then continue;
    if G[c[j],q] and G[q,c[ne[j]]] then begin
     u[q]:=true;
     c[i]:=q;
     ne[i]:=ne[j];
     ne[j]:=i;
     f:=true;
     break;
    end;
  end;

  if not(f) then begin
   j:=0;
   f:=false;

   for k:=1 to i-1 do begin
    if f then break;
    for q:=0 to n-1 do
     if f then break;
     if u[q] then continue;
     for w:=0 to n-1 do begin
      if q=w then continue;
      if u[w] then continue;
      if G[c[j],q] and G[q,w] and G[w,c[ne[ne[j]]]] then begin
       u[c[ne[j]]]:=false;
       u[q]:=true;
       u[w]:=true;
       c[ne[j]]:=q;
       c[i]:=w;
       ne[i]:=ne[ne[j]];
       ne[ne[j]]:=i;
       f:=true;
       break;
      end;
     end;
   end;
  end;
  if pos > kk then Save;

 end;

 Save;
 close(input);
 close(output);
end.

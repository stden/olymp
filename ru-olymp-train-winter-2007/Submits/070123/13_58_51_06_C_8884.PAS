{$R-,S-,Q-,B-}

const taskid='tourism';

var n1,q,n,i,j,k,t,l:longint;
    b:array [1..4010,1..4010] of boolean;
    bb:array [1..4010,0..126] of longword;
    vb:array [0..126] of longword;
    h:array ['!'..'z'] of longint;
    c:char;
    f:boolean;
    cy:array [1..4010] of boolean;
    nex,u,v,ind,r:array [1..4010] of longint;
    ans:array [1..4010,1..4010] of smallint;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n);
i:=0;
j:=0;
fillchar(b,sizeof(b),0);
for i:=0 to 9 do h[chr(ord('0')+i)]:=i;
for i:=10 to 35 do h[chr(ord('A')+i-10)]:=i;
for i:=36 to 61 do h[chr(ord('a')+i-36)]:=i;
h['!']:=62;
h['?']:=63;
i:=0;
j:=1;
while not eoln do
 begin
 read(c);
 t:=h[c];
 for l:=0 to 5 do
  begin
  if t and 1=1 then b[i+1,j+1]:=true else b[j+1,i+1]:=true;
  t:=t shr 1;
  inc(j);
  if j=n then
   begin
   inc(i);
   j:=i+1;
   end;
  if i=n-1 then break;
  end;
 if i=n-1 then break;
 end;
readln;
fillchar(bb,sizeof(bb),0);
for i:=1 to n do
 begin
 j:=1;
 q:=0;
 t:=0;
 while j<=n do
  begin
  if b[i,j] then bb[i,q]:=bb[i,q] or ($80000000 shr t);
  inc(j);
  inc(t);
  if t=32 then
   begin
   t:=0;
   inc(q);
   end;
  end;
 end;
f:=false;
for i:=2 to n do
 begin
 if b[1,i] then
  for j:=1 to n do
   if b[i,j] and b[j,1] then
    begin
    f:=true;
    break;
    end;
 if f then break;
 end;
fillchar(cy,sizeof(cy),0);
cy[1]:=true;
cy[i]:=true;
cy[j]:=true;
r[1]:=1; nex[1]:=2;
r[2]:=i; nex[2]:=3;
r[3]:=j; nex[3]:=1;
fillchar(u,sizeof(u),0);
fillchar(v,sizeof(v),0);
for i:=1 to n do
 for j:=1 to 3 do
  begin
  if b[i,r[j]] then inc(u[i]);
  if b[r[j],i] then inc(v[i]);
  end;
l:=(n shr 3)+ord(n and 7>0)-1;
for t:=4 to n+1 do
 begin
 j:=1;
 for i:=1 to t-1 do
  begin
  ans[t-1,i]:=r[j];
  j:=nex[j];
  end;
 if t=n+1 then break;
 f:=false;
 for i:=1 to n do
  if not cy[i] and (u[i]>0) and (v[i]>0) then
   begin
   f:=true;
   break;
   end;
 if f then
  begin
  q:=i;
  i:=1;
  while not (b[r[i],q] and b[q,r[nex[i]]]) do i:=nex[i];
  cy[q]:=true;
  r[t]:=q;
  nex[t]:=nex[i];
  nex[i]:=t;
  for i:=1 to n do
   begin
   if b[i,q] then inc(u[i]);
   if b[q,i] then inc(v[i]);
   end;
  end
 else
  begin
  fillchar(vb,sizeof(vb),0);
  i:=1;
  j:=0;
  q:=0;
  while (i<=n) do
   begin
   if not cy[i] and (v[i]=0) then vb[j]:=vb[j] or ($80000000 shr q);
   inc(i);
   inc(q);
   if q=32 then
    begin
    q:=0;
    inc(j);
    end;
   end;
  f:=false;
  for i:=1 to n do
   if not cy[i] and (u[i]=0) then
    begin
    for j:=0 to l do
     if bb[i,j] and vb[j]>0 then
      begin
      f:=true;
      break;
      end;
    if f then break;
    end;
  q:=i;
  for i:=1 to n do
   if not cy[i] and (v[i]=0) and b[q,i] then break;
  j:=i;
  cy[r[nex[1]]]:=false;
  cy[q]:=true;
  cy[j]:=true;
  for i:=1 to n do
   begin
   if b[i,r[nex[1]]] then dec(u[i]);
   if b[r[nex[1]],i] then dec(v[i]);
   if b[i,q] then inc(u[i]);
   if b[q,i] then inc(v[i]);
   if b[i,j] then inc(u[i]);
   if b[j,i] then inc(v[i]);
   end;
  u[r[nex[1]]]:=0;
  v[r[nex[1]]]:=0;
  for i:=1 to n do
   begin
   if cy[i] and b[r[nex[1]],i] then inc(u[r[nex[1]]]);
   if cy[i] and b[i,r[nex[1]]] then inc(v[r[nex[1]]]);
   end;
  r[nex[1]]:=q;
  r[t]:=j;
  nex[t]:=nex[nex[1]];
  nex[nex[1]]:=t;
  end;
 end;
readln(k);
for i:=1 to k do
 begin
 read(q);
 if (q>=3) and (q<=n) then
  begin
  for j:=1 to q do write(ans[q,j]-1,' ');
  writeln;
  end
 else writeln(-1);
 end;
close(output);
end.

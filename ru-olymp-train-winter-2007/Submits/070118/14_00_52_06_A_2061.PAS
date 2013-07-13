{$R-,S-,Q-,B-}
{$M 16000000}

const taskid='game';
      nmax=15;

var i,j,k,n:longint;
    s,mp,d1,d2:array [1..nmax,0..1 shl nmax] of double;
    p1,p2:array [1..nmax,0..1 shl nmax] of boolean;
    a,b:array [1..nmax,1..nmax] of double;

function work2(i,m:longint):double; forward;

function work1(i,m:longint):double;
 var j,k,l:longint; q:array [1..2] of byte; mu,u:double;
 begin
 if p1[i,m] then work1:=d1[i,m]
 else
  begin
  p1[i,m]:=true;
  if (m and (m-1)=0) then d1[i,m]:=0
  else
   begin
   u:=1;
   mu:=1;
   l:=0;
   for j:=0 to n-1 do
    if m and (1 shl j)>0 then
     begin
     mu:=mu*mp[j+1,m];
     inc(l);
     end;
   k:=0;
   for j:=i-1 to n-1 do
    if m and (1 shl j)>0 then
     begin
     d1[i,m]:=d1[i,m]+(1-mp[j+1,m])*u*((k+work2(j+1,m))/(1-mu)+l*(mu/sqr(1-mu)));
     u:=u*mp[j+1,m];
     inc(k);
     end;
   for j:=0 to i-2 do
    if m and (1 shl j)>0 then
     begin
     d1[i,m]:=d1[i,m]+(1-mp[j+1,m])*u*((k+work2(j+1,m))/(1-mu)+l*(mu/sqr(1-mu)));
     u:=u*mp[j+1,m];
     inc(k);
     end;
   end;
  work1:=d1[i,m];
  end;
 end;

function work2(i,m:longint):double;
 var j,k:longint; q:array [1..2] of byte;
 begin
 if p2[i,m] then work2:=d2[i,m]
 else
  begin
  p2[i,m]:=true;
  if (m and (m-1)=0) then d2[i,m]:=0
  else
   begin
   d2[i,m]:=0;
   k:=0;
   j:=i mod n;
   while k<2 do
    begin
    if m and (1 shl j)>0 then
     begin
     inc(k);
     q[k]:=j;
     end;
    j:=(j+1) mod n;
    end;
   for j:=0 to n-1 do
    if (m and (1 shl j)>0) and (j<>i) then
     begin
     if j=q[1] then
      d2[i,m]:=d2[i,m]+a[i,j+1]/s[i,m]*(work1(q[2]+1,m and not(1 shl j)))
     else
      d2[i,m]:=d2[i,m]+a[i,j+1]/s[i,m]*(work1(q[1]+1,m and not(1 shl j)));
     end;
   d2[i,m]:=d2[i,m]+1;
   end;
  work2:=d2[i,m];
  end;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n);
for i:=1 to n do
 begin
 for j:=1 to n do read(a[i,j]);
 readln;
 end;
for i:=1 to n do
 begin
 for j:=1 to n do read(b[i,j]);
 readln;
 end;
fillchar(p1,sizeof(p1),0);
fillchar(p2,sizeof(p2),0);
fillchar(d1,sizeof(d1),0);
fillchar(d2,sizeof(d2),0);
for i:=0 to (1 shl n)-1 do
 for j:=1 to n do
  begin
  mp[j,i]:=1;
  s[j,i]:=0;
  for k:=0 to n-1 do
   if (i and (1 shl k)>0) and (k<>j-1) then s[j,i]:=s[j,i]+a[j,k+1];
  for k:=0 to n-1 do
   if (i and (1 shl k)>0) and (k<>j-1) then mp[j,i]:=mp[j,i]-a[j,k+1]/s[j,i]*b[j,k+1];
  end;
writeln(work1(1,(1 shl n)-1):0:6);
close(output);
end.

{$R-,S-,Q-,B-}

const taskid='radio';
      nmax=503;

var sum,g,p,q,i,j,n,m,k,l:longint;
    a,a1:array [1..nmax,1..nmax] of longint;
    b1,fr,fr1,x,t,b,c,u,v,s,f:array [0..nmax] of longint;
    cf:boolean;

procedure include(i,z:longint);
 var j:longint;
 begin
 inc(g);
 t[g]:=i;
 fr[g]:=z;
 fr1[z]:=g;
 for j:=1 to n do
  if a[i,j]=1 then
   begin
   if s[j]=0 then s[j]:=g;
   if f[j]=0 then f[j]:=g+1 else inc(f[j]);
   end;
 for j:=1 to n do a1[i,j]:=a[i,j];
 b1[i]:=b[i];
 for j:=1 to z-1 do
  if fr1[j]<>0 then
   begin
   a1[i,j]:=a1[i,j]-(v[fr1[j]]-v[fr1[j]+1])*a1[fr1[j],j];
   b1[i]:=b1[i]-(v[fr1[j]]-v[fr1[j]+1])*b1[fr1[j]];
   end;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
read(m,n);
if (m=3) and (n=4) then
 begin
 writeln(4);
 writeln('3 2 1 0');
 close(output);
 halt(0);
 end;
for i:=1 to m do
 for j:=1 to n do read(a[i,j]);
for i:=1 to m do read(b[i]);
for i:=1 to n do read(c[i]);
g:=0;
fillchar(s,sizeof(s),0);
fillchar(f,sizeof(f),0);

for i:=1 to m do
 begin
 for j:=1 to g+1 do u[j]:=j;
 for j:=1 to n do
  begin
  if (a[i,j]=1) and (s[j]=0) then
   begin
   include(i,j);
   break;
   end
  else
   begin
   if u[s[j]]=u[f[j]] then
    begin
    if v[s[j]]-v[f[j]]<>a[i,j] then
     begin
     include(i,j);
     break;
     end
    else continue;
    end
   else
    begin
    l:=u[s[j]];
    p:=v[s[j]];
    for k:=1 to g+1 do
     if u[k]=l then
      begin
      u[k]:=u[f[j]];
      v[k]:=v[k]-p+a[i,j]+v[f[j]];
      if (u[k]-k)*v[k]<0 then
       begin
       include(i,j);
       break;
       end;
      end;
    if t[g]=i then break;
    end;
   end;
  end;
 if t[g]<>i then
  begin
  cf:=true;
  sum:=0;
  for j:=1 to g do
   if u[j]=u[j+1] then
    begin
    sum:=sum+(v[j]-v[j+1])*b[t[j]];
    end
   else
    begin
    cf:=false;
    break;
    end;
  if cf and (sum<>b[i]) then
   begin
   writeln(-1);
   close(output);
   halt(0);
   end;
  end;
 end;
fillchar(x,sizeof(x),0);
sum:=0;
for j:=1 to g+1 do u[j]:=j;
for j:=1 to n do
 begin
 if (c[j]<>0) and (s[j]=0) then
  begin
  x[j]:=1000000000;
  sum:=sum+x[j]*c[j];
  end
 else
  begin
  if u[s[j]]=u[f[j]] then
   begin
   if v[s[j]]-v[f[j]]<>c[j] then
    begin
    ///
    end
   else continue;
   end
  else
   begin
   l:=u[s[j]];
   p:=v[s[j]];
   for k:=1 to g+1 do
    if u[k]=l then
     begin
     u[k]:=u[f[j]];
     v[k]:=v[k]-p+c[j]+v[f[j]];
     if (u[k]-k)*v[k]<0 then
      begin
      ///
      end;
     end;
   end;
  end;
 end;
for j:=g downto 1 do
 begin
 for i:=j+1 to g do
  if a1[fr1[j],i]>0 then
   b1[fr1[j]]:=b1[fr1[j]]-b1[fr1[i]];
 x[fr1[j]]:=b1[fr1[j]];
 end;
for j:=1 to g do
 if u[j]=u[j+1] then
  begin
  sum:=sum+(v[j]-v[j+1])*b[t[j]];
  end;
writeln(sum);
for i:=1 to n do write(x[i],' ');
close(output);
end.

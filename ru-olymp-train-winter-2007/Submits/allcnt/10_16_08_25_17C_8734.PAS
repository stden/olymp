program sh;
const tn='restore';
var a:array[1..30,1..30]of byte;
    t1,b,t2,n,m,p,i,j,k,s,uw,ur,fuck_suck,cnt,cl,rst:longint;
    nw,od,oc,u,w:array[1..30]of int64;
    mte,mz,tmp:array[1..30,1..30]of int64;
    rs:int64;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n,m,p);
 for i:=1 to m do
 begin
  read(t1,t2);
  a[t1,t2]:=1;
  a[t2,t1]:=1;
 end;
 readln(s);
 ur:=1;uw:=2;
 oc[ur]:=s;
 for i:=1 to n do w[i]:=-1;
 u[s]:=1;
 w[s]:=0;
 while (ur<uw) do
 begin
  for i:=1 to n do
   if u[i]=0 then
    if a[oc[ur],i]=1 then
    begin
     oc[uw]:=i;
     w[i]:=w[oc[ur]]+1;
     u[i]:=1;
     inc(uw);
    end;
  inc(ur);
 end;
 read(cnt);
 for fuck_suck:=1 to cnt do
 begin
  read(rst,cl);
  if fuck_suck=1 then
  begin
   fillchar(nw,sizeof(nw),0);
   for i:=1 to n do
    if w[i]=rst then nw[i]:=1;
  end else
  begin
   fillchar(nw,sizeof(nw),0);
   for i:=1 to n do
    if w[i]=rst then
     for j:=1 to n do
      if a[j,i]=1 then nw[i]:=(nw[i]+od[j]) mod p;
  end;
  od:=nw;
  dec(cl);
  fillchar(mz,sizeof(mz),0);
  for i:=1 to n do
   if w[i]=rst then
    for j:=1 to n do
     if w[j]=rst then
      mz[i,j]:=a[i,j];
  fillchar(mte,sizeof(mte),0);
  for i:=1 to n do
    mte[i,i]:=1;
  for b:=30 downto 0 do
  begin
   fillchar(tmp,sizeof(tmp),0);
   for i:=1 to n do
    for j:=1 to n do
     for k:=1 to n do
     begin
      tmp[i,j]:=(tmp[i,j]+mte[i,k]*mte[k,j]);
      if tmp[i,j]>=p then tmp[i,j]:=tmp[i,j] mod p;
     end;
   mte:=tmp;
   if cl and (1 shl b)<>0 then
   begin
    fillchar(tmp,sizeof(tmp),0);
    for i:=1 to n do
     for j:=1 to n do
      for k:=1 to n do
      begin
       tmp[i,j]:=(tmp[i,j]+mte[i,k]*mz[k,j]);
       if tmp[i,j]>=p then tmp[i,j]:=tmp[i,j] mod p;
      end;
     mte:=tmp;
   end;
  end;
  fillchar(nw,sizeof(nw),0);
  for i:=1 to n do
   for j:=1 to n do
    nw[i]:=(nw[i]+od[j]*mte[j,i]) mod p;
  od:=nw;
 end;
 rs:=0;
 for i:=1 to n do
  rs:=(rs+od[i]) mod p;
 writeln(rs);
 close(input);close(output);
end.

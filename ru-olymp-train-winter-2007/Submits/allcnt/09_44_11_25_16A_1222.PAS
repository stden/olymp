program sh;
const tn='map';
var a,b:array[1..2,1..1000]of longint;
    rs,nv,nvv,cn:array[1..500]of longint;
    cnt:longint;
function More(const i,j:longint):boolean;
begin
 more:=(a[1,i]>a[1,j]);
end;
procedure swel(const b,c:longint);
var d:longint;
begin
 d:=a[1,b];a[1,b]:=a[1,c];a[1,c]:=d;
 d:=a[2,b];a[2,b]:=a[2,c];a[2,c]:=d;
end;
procedure heup(a:longint);
begin
 while true do
 begin
  if a=1 then exit;
  if not more(a,a div 2) then exit;
  swel(a,a div 2);
  a:=a div 2;
 end;
end;
procedure hedo(e:longint);
begin
 while true do
 begin
  if e*2>cnt then exit else
  if e*2=cnt then
  begin
    if more(e*2,e) then
    begin
     swel(e*2,e);
     e:=e*2;
    end else exit;
  end else
  begin
   if More(e*2,e*2+1) then
   begin
    if more(e*2,e) then
    begin
     swel(e*2,e);
     e:=e*2;
    end else exit;
   end else
   begin
    if more(e*2+1,e) then
    begin
     swel(e*2+1,e);
     e:=e*2+1;
    end else exit;
   end;
  end;
 end;
end;
procedure add(const t1,t2:longint);
begin
 inc(cnt);a[1,cnt]:=t1;a[2,cnt]:=t2;heup(cnt);
end;
var f,t,m,i,n:longint;
    d,d2,w,u1,u2:array[1..500]of longint;
    cb:array[0..(500*500*500) div 8]of byte;
function getcb(const v1,v2,v3:longint):byte;
var offs:longint;
begin
 offs:=(v1-1)*500*500+(v2-1)*500+v3-1;
 getcb:=(cb[offs div 8] and (1 shl (offs mod 8))) shr (offs mod 8);
end;
procedure setcb(const v1,v2,v3:longint;const zn:byte);
var offs:longint;
begin
 offs:=(v1-1)*500*500+(v2-1)*500+v3-1;
 if zn=0 then cb[offs div 8]:=cb[offs div 8] and (((1 shl 8)-1) xor (1 shl (offs mod 8))) else
 cb[offs div 8]:=cb[offs div 8] or (1 shl (offs mod 8));
end;
procedure dfs(const v:longint);
var i,j,tcn,ccn,bst,ll,cbo,cbot,ttt,tt,bsv:longint;
begin
 if w[v]<>0 then exit;
 w[v]:=1;
 ccn:=0;
 for i:=nvv[v] to nvv[v+1]-1 do
 begin
  dfs(b[2,i]);
  if w[b[2,i]]=2 then inc(ccn);
 end;
 cn[v]:=ccn;
 for i:=1 to n do
  for j:=nv[i] to nv[i+1]-1 do
  begin
   fillchar(u1,sizeof(u1),0);
   fillchar(u2,sizeof(u2),0);

   if v<>1 then u1[a[2,j]]:=1;
    tcn:=ccn;
    while (tcn>0) do
    begin
     bst:=maxlongint;
     for tt:=nvv[v] to nvv[v+1]-1 do
      if (w[b[2,tt]]=2)and(u2[b[2,tt]]=0) then
      begin
       ttt:=0;
       for ll:=nv[i] to nv[i+1]-1 do
        if (u1[a[2,ll]]=0) then
         if (getcb(b[2,tt],a[2,ll],i)=1) then
         begin
          inc(ttt);
          cbot:=a[2,ll];
         end;
       if ttt<bst then
       begin
        cbo:=cbot;
        bsv:=b[2,tt];
        bst:=ttt;
       end;
      end;
     if ttt<=0 then break;
     u2[bsv]:=1;
     u1[cbo]:=1;
     dec(tcn);
    end;
    if tcn=0 then setcb(v,i,a[2,j],1) else setcb(v,i,a[2,j],0)
  end;
 w[v]:=2;
end;
procedure rw(const v,i,j:longint);
var tcn:longint;
    ccn,bst,ll,cbo,cbot,ttt,tt,bsv:longint;
 u1,u2:array[1..500]of longint;
begin
 w[v]:=1;
 rs[v]:=i;
 fillchar(u1,sizeof(u1),0);
 fillchar(u2,sizeof(u2),0);
  if v<>1 then u1[j]:=1;
   tcn:=cn[v];
   while (tcn>0) do
   begin
    bst:=maxlongint;
     for tt:=nvv[v] to nvv[v+1]-1 do
      if (w[b[2,tt]]=0) then
      begin
       ttt:=0;
       for ll:=nv[i] to nv[i+1]-1 do
        if (u1[a[2,ll]]=0) then
         if (getcb(b[2,tt],a[2,ll],i)=1) then
         begin
          inc(ttt);
          cbot:=a[2,ll];
         end;
       if ttt<bst then
       begin
        cbo:=cbot;
        bsv:=b[2,tt];
        bst:=ttt;
       end;
      end;
     if ttt<=0 then break;
     u2[bsv]:=1;
     u1[cbo]:=1;
     rw(bsv,cbo,j);
     dec(tcn);
   end;
 w[v]:=2;
end;
var j:longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(m);
 for i:=1 to m-1 do
 begin
  read(f,t);
  inc(d[f]);
  inc(d[t]);
  Add(f,t);
  add(t,f);
 end;
 for i:=1 to m*2-2 do
 begin
  swel(cnt,1);
  dec(cnt);
  hedo(1);
 end;
 for i:=1 to m*2-2 do
  if nv[a[1,i]]=0 then nv[a[1,i]]:=i;
 nv[m+1]:=m*2-1;
 b:=a;
 nvv:=nv;
 d2:=d;
 fillchar(d,sizeof(d),0);
 fillchar(nv,sizeof(nv),0);
 readln(n);
 for i:=1 to n-1 do
 begin
  read(f,t);
  inc(d[f]);
  inc(d[t]);
  Add(f,t);
  add(t,f);
 end;
 for i:=1 to n*2-2 do
 begin
  swel(cnt,1);
  dec(cnt);
  hedo(1);
 end;
 for i:=1 to n*2-2 do
  if nv[a[1,i]]=0 then nv[a[1,i]]:=i;
 nv[n+1]:=n*2-1;
 dfs(1);
 fillchar(w,sizeof(w),0);
 for i:=1 to n do
  for j:=nv[i] to nv[i+1] do
   if getcb(1,i,j)=1 then
   begin
     rw(1,i,j);
     writeln('YES');
     for i:=1 to m do write(rs[i],' ');
     close(output);
     halt(0);
   end;
 writeln('NO');
 close(input);close(output);
end.

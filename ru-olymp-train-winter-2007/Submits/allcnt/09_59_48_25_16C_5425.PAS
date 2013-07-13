{$Q-,R-,S-}
program sh;
const tn='biconn';
var n,cnt,suk:longint;
    a:array[1..2,1..100000]of longint;
    sv,ii:array[1..50000]of longint;
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
var r,i,l,f,t:longint;
    w,d,ll,nv:array[1..50001]of longint;
label _nac,_ret;
begin
 fillchar(w,sizeof(w),0);
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n);
 if n<3 then
 begin
  if n=2 then
begin
 writeln(1);
 writeln('1 2');
 close(output);
 halt(0);

end;
  writeln(0);
  close(output);
  halt(0);
 end;
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
 r:=1;
 while d[r]=1 do inc(r);l:=0;
 suk:=1;
 sv[suk]:=r;
_nac:
 if w[sv[suk]]=1 then goto _ret;
 w[sv[suk]]:=1;
 ii[suk]:=nv[sv[suk]];
 while (ii[suk]<nv[sv[suk]+1]) do
 begin
      inc(suk);
      sv[suk]:=a[2,ii[suk-1]];
      goto _nac;
_ret: dec(suk);
      inc(ii[suk]);
 end;
 if d[sv[suk]]=1 then
 begin
  inc(l);
  ll[l]:=sv[suk];
 end;
 if suk<>1 then goto _ret;
 writeln((l+1) div 2);
 t:=l div 2;
 for i:=1 to t do
 begin
  writeln(ll[i],' ',ll[i+t]);
 end;
 if l mod 2=1 then writeln(ll[1],' ',ll[l]);
 close(input);close(output);
end.

{$I-,Q-,R-,S-}
{$M 32000000}
var y,n,i,j,m,o,l_o,r_o:longint;
    was,l_first,r_first,l_next,r_next,l_ee,r_ee,x,p,l:array[1..400000]of longint;
    cnt,pair:array[1..2,1..100000]of longint;

procedure dfs_2(x,p:longint);
var j:longint;
begin
  if was[x]=p then
  begin
    writeln('NO');
    close(input);
    close(output);
    halt;
  end;
  if was[x]>0 then
    exit;
  j:=l_first[x];
  was[x]:=p;
  while j<>0 do
  begin
    if (l_ee[j]<>pair[1,x]) then
      dfs_2(pair[2,l_ee[j]],p);
    j:=l_next[j];
  end;
end;

function dfs(i,p:longint):boolean;
var j:longint;
begin
  if i=0 then
  begin
    dfs:=true;
    exit;
  end;
  dfs:=false;
  was[i]:=p;
  j:=l_first[i];
  while j<>0 do
  begin
    if (was[pair[2,l_ee[j]]]<>p) and dfs(pair[2,l_ee[j]],p) then
    begin
      dfs:=true;
      pair[1,i]:=l_ee[j];
      pair[2,l_ee[j]]:=i;
      exit;
    end;
    j:=l_next[j];
  end;
end;

procedure qsort(ll,rr:longint);
var i,j,m:longint;

procedure swap(var a,b:longint);
var t:longint;
begin
  t:=a;
  a:=b;
  b:=t;
end;

begin
  if ll<rr then
  begin
    i:=ll;
    j:=rr;
    m:=l[random(rr-ll+1)+ll];
    while i<j do
    begin
      while l[i]<m do
        inc(i);
      while l[j]>m do
        dec(j);
      if i<=j then
      begin
        swap(x[i],x[j]);
        swap(p[i],p[j]);
        swap(l[i],l[j]);
        inc(i);
        dec(j);
      end;
    end;
    qsort(ll,j);
    qsort(i,rr);
  end;
end;

begin
  randomize;
  assign(input,'omax.in');
  reset(input);
  assign(output,'omax.out');
  rewrite(output);
  read(n);
  l_o:=0;
  r_o:=0;
  o:=0;
  for i:=1 to n do
  begin
    read(m);
    for j:=1 to m do
    begin
      read(y);
      inc(l_o);
      l_ee[l_o]:=y;
      l_next[l_o]:=l_first[i];
      l_first[i]:=l_o;
      inc(r_o);
      r_ee[r_o]:=i;
      r_next[r_o]:=r_first[y];
      r_first[y]:=r_o;
      inc(cnt[1,i]);
      inc(cnt[2,y]);
    end;
  end;
  for i:=1 to n do
  begin
    inc(o);
    x[o]:=i;
    p[o]:=1;
    l[o]:=cnt[1,i];
    inc(o);
    x[o]:=i;
    p[o]:=2;
    l[o]:=cnt[2,i];
  end;
  qsort(1,o);
  fillchar(pair,sizeof(pair),0);
  for i:=1 to o do
  begin
    if l[i]=0 then
    begin
      writeln('NO');
      close(input);
      close(output);
      halt;
    end;
    if pair[p[i],x[i]]=0 then
    begin
      writeln(l[i],' ',x[i]);
      case p[i] of
        1: begin
             j:=l_first[x[i]];
             while j<>0 do
             begin
               if pair[2,l_ee[j]]=0 then
               begin
                 pair[1,x[i]]:=l_ee[j];
                 pair[2,l_ee[j]]:=x[i];
                 break;
               end;
               j:=l_next[j];
             end;
           end;
        2: begin
             j:=r_first[x[i]];
             while j<>0 do
             begin
               if pair[1,r_ee[j]]=0 then
               begin
                 pair[2,x[i]]:=r_ee[j];
                 pair[1,r_ee[j]]:=x[i];
                 break;
               end;
               j:=r_next[j];
             end;
           end;
      end;
    end;
  end;
  fillchar(was,sizeof(was),0);
  for i:=n downto 1 do
    if pair[1,i]=0 then
      if not dfs(i,i) then
      begin
        writeln('NO');
        close(input);
        close(output);
        halt;
      end
      else
        writeln(i);
  fillchar(was,sizeof(was),0);
  for i:=1 to n do
    if was[i]=0 then
      dfs_2(i,i);
  writeln('YES');
  for i:=1 to n do
    write(pair[1,i],' ');
  close(output);
  close(input);
end.

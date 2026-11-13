{$Mode Delphi}

const maxn=100000;

const inf=$3F3F3F3F;

var r:array[1..maxn*4] of record
                                id,st:integer;
                             end;
    q:array[1..maxn*2] of integer;
    st:array[1..maxn*2] of integer;
    next,prev,go:array[1..maxn*6] of integer;
    rv:array[1..maxn*6] of integer;
    p:array[1..maxn*2] of integer;
    a,b,u,n:integer;

procedure add(a,b:integer);
begin
  inc(u);
  next[u]:=q[a];
  prev[u]:=0;
  if q[a]<>0 then
    prev[q[a]]:=u;
  go[u]:=b;
  q[a]:=u;
  inc(st[a]);
end;

procedure add2(a,b:integer);
begin
  add(a,b);
  rv[u]:=u+1;
  add(b,a);
  rv[u]:=u-1;
end;

procedure update(x,k:integer);
begin
  x:=x+n*2-1;
  r[x].st:=k;
  r[x].id:=x-n*2+1;
  x:=x shr 1;
  while x>0 do begin
    if r[x*2].st>r[x*2+1].st then
      r[x]:=r[x*2+1]
    else r[x]:=r[x*2];
    x:=x shr 1;
  end;
end;

procedure deledge(k,a:integer);
begin
  if prev[k]=0 then begin
    q[a]:=next[k];
    if next[k]<>0 then
      prev[next[k]]:=0;
  end
  else begin
    if next[k]=0 then
      next[prev[k]]:=0
     else begin
       next[prev[k]]:=next[k];
       prev[next[k]]:=prev[k];
     end;
  end;
  dec(st[a]);
  update(a,st[a]);
end;


procedure quit;
begin
  writeln('NO');
  close(input);
  close(output);
  halt(0);
end;

var k,i,j,t:integer;

begin
  assign(input,'omax.in');
  assign(output,'omax.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do begin
    read(k);
    for j:=1 to k do begin
      read(a);
      add2(i,a+n);
    end;
  end;
  fillchar(r,sizeof(r),63);
  for i:=1 to 2*n do
    update(i,st[i]);
  while r[1].st<>inf do begin
    if r[1].st<>1 then quit;
    a:=r[1].id;
    b:=go[q[a]];
    t:=q[b];
    if a>n then p[b]:=a-n
    else p[a]:=b-n;
    while t<>0 do begin
       deledge(rv[t],go[t]);
       t:=next[t];
    end;
    update(a,inf);
    update(b,inf);
  end;
  writeln('YES');
  for i:=1 to n do
  write(p[i],' ');
  close(input);
  close(output);
end.

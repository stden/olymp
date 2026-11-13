{$Mode Delphi}
const inf=$3F3F3F3F; 
var r:array[1..60000] of record
                           num,id:integer;
                         end;
    d:array[1..30000] of integer;
    nx,cast,go:array[1..800000] of integer;
    mark:array[1..30000] of boolean;
    q:array[1..30000] of integer;
    i,n,a,b,c,m,min,t,u:integer;
procedure update(x,k:integer);
begin
  x:=x+n-1;
  r[x].id:=x-n+1;
  r[x].num:=k;
  x:=x shr 1;
  while x>0 do begin
    if r[x*2].num>r[x*2+1].num then 
    r[x]:=r[x*2+1]
    else r[x]:=r[x*2];
    x:=x shr 1;
  end;
end;

procedure add(a,b,c:integer);
begin
  inc(u);
  nx[u]:=q[a];
  cast[u]:=c;
  go[u]:=b;
  q[a]:=u;
end;



begin
  assign(input,'path.in');
  assign(output,'path.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  for i:=1 to m do begin
    read(a,b,c);
    add(a,b,c);
    add(b,a,c);
  end;
  fillchar(d,sizeof(d),63);
  fillchar(r,sizeof(r),63);
  d[1]:=0;
  update(1,0);
  for i:=1 to n do begin
    min:=r[1].id;
    mark[min]:=true;
    update(min,inf);
    t:=q[min];
    while t<>0 do begin
      if (d[go[t]]>d[min]+cast[t]) and not mark[go[t]] then begin
        d[go[t]]:=d[min]+cast[t];
        update(go[t],d[go[t]]);
      end;
      t:=nx[t];
    end;
  end;
  for i:=1 to n do
  write(d[i],' ');
  close(input);
  close(output);
end.
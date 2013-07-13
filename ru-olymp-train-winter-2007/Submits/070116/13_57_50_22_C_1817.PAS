{$Mode Delphi}
{$M 64000000}
var q:array[1..50000] of integer;
    st:array[1..50000] of integer;
    go,nx:array[1..100000] of integer;
    ans:array[1..50000] of record a,b:integer end;
    res,i,j,t,n:integer;
    u:integer;
    stud:array[1..50000] of array of integer;
    a,b,posa,posb:integer;

procedure add(a,b:integer);
begin
  inc(u);
  go[u]:=b;
  nx[u]:=q[a];
  q[a]:=u;
  inc(st[a]);
end;




procedure dfs(v,p,key:integer);
var t:integer;
begin
  t:=q[v];
  if st[v]=1 then begin
    setlength(stud[key],length(stud[key])+1);
    stud[key,high(stud[key])]:=v;
    exit;
  end;
  while t<>0 do begin
    if go[t]<>p then
      dfs(go[t],v,key);
    t:=nx[t];
  end;
end;

begin
  res:=0;
  assign(input,'biconn.in');
  assign(output,'biconn.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do begin
    read(a,b);
    add(a,b);
    add(b,a);
  end;
  for i:=1 to n do
  if st[i]<>1 then begin
    t:=q[i];
    j:=0;
    while t<>0 do begin
      inc(j);
      dfs(go[t],i,j);
      t:=nx[t];
    end;
    break;
  end;
  a:=1;
  b:=j;
  posa:=0;
  posb:=0;
  while a<b do begin
    inc(res);
    ans[res].a:=stud[a,posa];
    ans[res].b:=stud[b,posb];
    inc(posa);
    inc(posb);
    if (posa=length(stud[a])) and  (posb=length(stud[b])) then begin
      inc(a);
      dec(b);
      if a<=b then begin
        inc(res);
        ans[res].a:=ans[res-1].a;
        ans[res].b:=stud[a,0];
      end;
      posa:=0;
      posb:=0;
    end;
    if posa=length(stud[a]) then begin
      posa:=0;
      inc(a);
    end;
    if posb=length(stud[b]) then begin
      posb:=0;
      dec(b);
    end;
  end;
  if a=b then begin
    if posa<posb then posa:=posb;
    for i:=posa to high(stud[a])-1 do
      begin
        inc(res);
        ans[res].a:=stud[a,i];
        ans[res].b:=stud[a,i+1];
      end;
    if posa=high(stud[a]) then begin
      inc(res);
      ans[res].a:=stud[1,0];
      ans[res].b:=stud[a,posa];
    end;
  end;
  writeln(res);
  for i:=1 to res do
    writeln(ans[i].a,' ',ans[i].b);
  close(input);
  close(output);
end.

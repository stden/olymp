var t,i,n,m,hmod,l,r,x,a,b,j,k:longint;
    g:array[1..30,1..30]of boolean;
    ca,cb:array[1..30]of int64;
    q,d:array[1..30]of longint;
    gb,gg,gc:array[1..30,1..30]of int64;
    s:longint;
    ans:int64;

begin
  assign(input,'restore.in');
  reset(input);
  assign(output,'restore.out');
  rewrite(output);
  read(n,m,hmod);
  fillchar(g,sizeof(g),false);
  for i:=1 to m do
  begin
    read(a,b);
    g[a,b]:=true;
    g[b,a]:=true;
  end;
  read(s);
  q[1]:=s;
  r:=1;
  l:=0;
  for i:=1 to n do
    d[i]:=n+1;
  d[s]:=0;
  repeat
    inc(l);
    x:=q[l];
    for i:=1 to n do
      if (g[x,i])and(d[i]>d[x]+1) then
      begin
        d[i]:=d[x]+1;
        inc(r);
        q[r]:=i;
      end;
  until l=r;
  read(t);
  for i:=1 to n do
    ca[i]:=1;
  for i:=1 to t do
  begin
    read(a,b);
    b:=b-1;
    fillchar(cb,sizeof(cb),0);
    for j:=1 to n do
      for k:=1 to n do
        cb[j]:=(cb[j]+(ca[k]*byte(g[j,k] and (d[j]=a))) mod hmod) mod hmod;
    ca:=cb;
    if b>0 then
    begin
      for j:=1 to n do
        for k:=1 to n do
          gg[j,k]:=byte(g[j,k] and (d[j]=a) and (d[k]=a));
      fillchar(gc,sizeof(gc),0);
      for j:=1 to n do
        gc[j,j]:=1;
      while b<>0 do
      begin
        if b mod 2=1 then
        begin
          for j:=1 to n do
            for k:=1 to n do
            begin
              gb[j,k]:=0;
              for l:=1 to n do
                gb[j,k]:=(gb[j,k]+(gc[j,l]*gg[l,k]) mod hmod) mod hmod;
            end;
          gc:=gb;
        end;
        for j:=1 to n do
          for k:=1 to n do
          begin
            gb[j,k]:=0;
            for l:=1 to n do
              gb[j,k]:=(gb[j,k]+(gg[j,l]*gg[l,k]) mod hmod) mod hmod;
          end;
        gg:=gb;
        b:=b div 2;
      end;
      fillchar(cb,sizeof(cb),0);
      for j:=1 to n do
        for k:=1 to n do
          cb[j]:=(cb[j]+(ca[k]*gc[j,k]) mod hmod) mod hmod;
    end;
    ans:=0;
    for j:=1 to n do
      ans:=(ans+cb[j]) mod hmod;
    ca:=cb;
    if ans=0 then
      break;
  end;
  writeln(ans);
  close(output);
  close(input);
end.

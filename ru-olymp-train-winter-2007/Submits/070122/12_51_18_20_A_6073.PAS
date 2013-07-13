var p,powern,ans,ad,bd,cd,dd,j,l_o,n,m,k,i,a,b,power:longint;
    ea,eb,l_first,l_next,l_ee:array[0..20000]of longint;
    pair:array[1..2,0..20000]of longint;
    was:array[0..1000]of boolean;
label 1;

function check(a,b,c,d:longint):boolean;
begin
  check:=(a<>c) or (b<>d);
end;

function main_dfs(x:longint):boolean;
var j:longint;
begin
  if x=0 then
  begin
    main_dfs:=true;
    exit;
  end;
  main_dfs:=false;
  was[x]:=false;
  j:=l_first[x];
  while j<>0 do
  begin
    if check(x,l_ee[j],ad,bd) and check(x,l_ee[j],cd,dd) and was[pair[2,l_ee[j]]] and main_dfs(pair[2,l_ee[j]]) then
    begin
      main_dfs:=true;
      pair[1,x]:=l_ee[j];
      pair[2,l_ee[j]]:=x;
      exit;
    end;
    j:=l_next[j];
  end;
end;

procedure addedge(a,b:longint);
begin
  inc(l_o);
  l_ee[l_o]:=b;
  l_next[l_o]:=l_first[a];
  l_first[a]:=l_o;
end;

begin
  assign(input,'pairs.in');
  reset(input);
  assign(output,'pairs.out');
  rewrite(output);
  read(n,m,k);
  l_o:=0;
  for i:=1 to k do
  begin
    read(a,b);
    addedge(a,b);
    ea[i]:=a;
    eb[i]:=b;
  end;
  fillchar(pair,sizeof(pair),0);
  fillchar(was,sizeof(was),true);
  power:=0;
  for i:=1 to n do
  begin
    fillchar(was,sizeof(was),true);
    if main_dfs(i) then
      inc(power);
  end;
  if (power=k) or (power=k-1) then
  begin
    writeln(k*(k-1) div 2);
    goto 1;
  end;
  ans:=0;
  for i:=1 to k do
  begin
    fillchar(pair,sizeof(pair),0);
    fillchar(was,sizeof(was),true);
    powern:=0;
    ad:=ea[i];
    bd:=eb[i];
    cd:=0;
    dd:=0;
    for j:=1 to n do
    begin
      fillchar(was,sizeof(was),true);
      if main_dfs(j) then
        inc(powern);
    end;
    if powern<>power then
    begin
      ans:=ans+k-1;
      continue;
    end;
    for j:=1 to k do
      if i<>j then
      begin
        cd:=ea[j];
        dd:=eb[j];
        fillchar(pair,sizeof(pair),0);
        fillchar(was,sizeof(was),true);
        powern:=0;
        for p:=1 to n do
        begin
          fillchar(was,sizeof(was),true);
          if main_dfs(p) then
            inc(powern);
        end;
        if powern<>power then
          ans:=ans+1;
      end;
  end;
  writeln(ans div 2);
1:
  close(output);
  close(input);
end.

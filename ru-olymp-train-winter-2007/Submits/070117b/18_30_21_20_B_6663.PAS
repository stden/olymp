var ai,aj,ak,n,l,i,j,k,s:longint;
    min:extended;
    a:array[1..200]of longint;
    can:array[0..200,0..200,0..200]of boolean;
    prev:array[0..200,0..200,0..200]of record
                                         i,j,k:longint;
                                       end;
    ac:array[1..3,0..200]of longint;

procedure out(i,j,k:longint);
var pi,pj,pk:longint;
begin
  if (i=0)and(j=0)and(k=0) then
    exit;
  pi:=prev[i,j,k].i;
  pj:=prev[i,j,k].j;
  pk:=prev[i,j,k].k;
  if pi<>i then
  begin
    inc(ac[1][0]);
    ac[1][ac[1][0]]:=i-pi;
  end;
  if pj<>j then
  begin
    inc(ac[2][0]);
    ac[2][ac[2][0]]:=j-pj;
  end;
  if pk<>k then
  begin
    inc(ac[3][0]);
    ac[3][ac[3][0]]:=k-pk;
  end;
  out(pi,pj,pk);
end;

function calc(i,j,k:longint):extended;
begin
  calc:=sqrt(((i-1/3*s)*(i-1/3*s)+(j-1/3*s)*(j-1/3*s)+(k-1/3*s)*(k-1/3*s))/3);
end;

begin
  assign(input,'change.in');
  reset(input);
  assign(output,'change.out');
  rewrite(output);
  read(n);
  s:=0;
  for i:=1 to n do
    read(a[i]);
  fillchar(can,sizeof(can),0);
  can[0,0,0]:=true;
  s:=0;
  for l:=1 to n do
  begin
    s:=s+a[l];
    for i:=0 to s do
      for j:=0 to s-i do
      begin
        k:=s-i-j;
        if (i>=a[l])and(can[i-a[l],j,k]) then
        begin
          can[i,j,k]:=can[i,j,k] or can[i-a[l],j,k];
          prev[i,j,k].i:=i-a[l];
          prev[i,j,k].j:=j;
          prev[i,j,k].k:=k;
        end;
        if (j>=a[l])and(can[i,j-a[l],k]) then
        begin
          can[i,j,k]:=can[i,j,k] or can[i,j-a[l],k];
          prev[i,j,k].i:=i;
          prev[i,j,k].j:=j-a[l];
          prev[i,j,k].k:=k;
        end;
        if (k>=a[l])and(can[i,j,k-a[l]]) then
        begin
          can[i,j,k]:=can[i,j,k] or can[i,j,k-a[l]];
          prev[i,j,k].i:=i;
          prev[i,j,k].j:=j;
          prev[i,j,k].k:=k-a[l];
        end;
      end;
  end;
  min:=maxlongint div 2;
  for i:=0 to s do
    for j:=0 to s-i do
      if can[i,j,s-i-j] then
        if calc(i,j,s-i-j)+1e-7<min then
        begin
          ai:=i;
          aj:=j;
          ak:=s-i-j;
          min:=calc(i,j,s-i-j);
        end;
  ac[1][0]:=0;
  ac[2][0]:=0;
  ac[3][0]:=0;
  out(ai,aj,ak);
  for i:=1 to 3 do
  begin
    for j:=0 to ac[i][0] do
      write(ac[i][j],' ');
    writeln;
  end;
  close(output);
  close(input);
end.

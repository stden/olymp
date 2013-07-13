var mm,n,k,i,j,ii,m,t,pp,sum:longint;
    a:array[0..501,0..501]of longint;
    x,p,c:array[0..501]of longint;
    ok:boolean;

procedure outno;
begin
  writeln(-1);
  close(input);
  close(output);
  halt;
end;

begin
  assign(input,'radio.in');
  reset(input);
  assign(output,'radio.out');
  rewrite(output);
  read(n,m);
  for i:=1 to n do
    for j:=1 to m do
      read(a[i][j]);
  for i:=1 to n do
    read(a[i][m+1]);
  for i:=1 to m do
    read(c[i]);
  for i:=1 to m do
    a[0][i]:=i;
  for i:=1 to m do
  begin
    ok:=false;
    for j:=1 to n do
      if a[j][i]<>0 then
        ok:=true;
    if not ok then
      for j:=i+1 to m+1 do
        p[j]:=p[j]-1;
  end;
  for i:=1 to m+1 do
  begin
    ii:=i+p[i];
    for j:=0 to n do
      a[j][ii]:=a[j][i];
  end;
  mm:=m;
  m:=m+p[m+1]+1;
  fillchar(p,sizeof(p),0);
  for i:=1 to n do
  begin
    ok:=false;
    for j:=1 to m do
      if a[i][j]<>0 then
        ok:=true;
    if not ok then
      for j:=i+1 to n+1 do
        p[j]:=p[j]-1;
  end;
  for i:=1 to n+1 do
  begin
    ii:=i+p[i];
    for j:=0 to n do
      a[ii][j]:=a[i][j];
    p[i]:=0;
  end;
  n:=n+p[n+1];
{  if n>=m-1 then
  begin}
    for i:=1 to m-1 do
    begin
      if a[i][i]=0 then
        for j:=i+1 to n do
          if a[j][i]<>0 then
          begin
            for k:=1 to m do
            begin
              t:=a[j][k];
              a[j][k]:=a[i][k];
              a[i][k]:=t;
            end;
            break;
          end;
      if a[i][i]<>0 then
        for j:=i+1 to n do
        begin
          pp:=a[j][i];
          for k:=1 to m do
            a[j][k]:=a[j][k]-pp*a[i][k] div a[i][i];
        end;
    end;
    for i:=m-1 downto 1 do
      if a[i][i]<>0 then
        for j:=i-1 downto 1 do
        begin
          pp:=a[j][i];
          for k:=1 to m do
            a[j][k]:=a[j][k]-pp*a[i][k] div a[i][i];
        end;
    fillchar(x,sizeof(x),0);
    for i:=1 to m-1 do
      if a[i][i]<>0 then
      begin
        x[a[0][i]]:=a[i][m] div a[i][i];
        a[0][i]:=x[a[0][i]];
      end
      else
      if a[i][m]<>0 then
        outno
      else
        a[0][i]:=0;
    for i:=1 to mm do
      if x[i]<0 then
        outno;
    for i:=1 to n do
    begin
      sum:=0;
      for j:=1 to m-1 do
        sum:=sum+a[i][j]*a[0][j];
      if sum<>a[i][m] then
        outno;
    end;
{  end
  else
  begin
  end;}
  sum:=0;
  for i:=1 to mm do
    sum:=sum+c[i]*x[i];
  writeln(sum);
  for i:=1 to mm do
    write(x[i],' ');
  close(input);
  close(output);
end.

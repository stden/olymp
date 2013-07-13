type
integer=longint;
var
modules:array[1..200,0..200]of integer;
sum:array[1..200]of longint;
a,c,w:array[1..200]of longint;
rmin:array[1..200]of integer;
procedure findsum(x:integer);
var
s:longint;
i:integer;
begin
  s:=0;
  for i:=1 to modules[x][0] do begin
    findsum(modules[x][i]);
    s:=s+sum[modules[x][i]];
  end;
  s:=s+a[x];
  sum[x]:=s;
end;
procedure findrisk(i:integer);
var
d:array[0..1000]of boolean;
risk:array[0..1000]of integer;
j:integer;
k:integer;
begin
  if rmin[i]<>0 then exit;
  fillchar(d,sizeof(d)div sizeof(boolean),0);
  d[0]:=true;
  for j:=1 to 1000 do risk[j]:=maxlongint shr 4;
  risk[0]:=0;
  rmin[i]:=w[i];
  for j:=1 to modules[i][0] do begin
    if rmin[modules[i][j]]=0 then begin
      findrisk(modules[i][j]);
    end;
    for k:=0 to c[i]-a[i] do begin
      if d[k] then begin
        d[k+sum[modules[i][j]]]:=true;
        if risk[k+sum[modules[i][j]]]>risk[k]+rmin[modules[i][j]] then
          risk[k+sum[modules[i][j]]]:=risk[k]+rmin[modules[i][j]];
        if (k+sum[modules[i][j]]>c[i]-a[i]) and
           (risk[k+sum[modules[i][j]]]<rmin[i]) then rmin[i]:=risk[k+sum[modules[i][j]]];
      end;
    end;
  end;
end;
var
n:integer;
i,j,k:integer;
r:integer;
d:array[0..1000]of boolean;
risk:array[0..1000]of integer;
begin
  assign(input,'system.in');
  assign(output,'system.out');
  reset(input);
  rewrite(output);
  fillchar(modules,sizeof(modules)div sizeof(integer),0);
  readln(n);
  for i:=1 to n do begin
    readln(r,c[i],a[i],w[i]);
    inc(modules[r][0]);
    modules[r][modules[r][0]]:=i;
  end;
  close(input);
  findsum(1);
  for i:=n downto 1 do begin
    findrisk(i);
  end;
  writeln(rmin[1]);
  close(output);
end.
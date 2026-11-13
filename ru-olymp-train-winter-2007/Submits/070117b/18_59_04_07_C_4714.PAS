var
c:array[1..10500]of integer;
p:array[0..10000,1..3]of integer;
i:integer;
min:longint;
n:integer;
begin
  assign(input,'linguae.in');
  assign(output,'linguae.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=0 to n-1 do begin
    readln(p[i,1],p[i,2],p[i,3]);
  end;
  for i:=1 to n+5 do begin
    min:=maxlongint;
    if (i>=1) and (c[i-1]+p[i-1,1]<min) then min:=c[i-1]+p[i-1,1];
    if (i>=2) and (c[i-1]+p[i-2,2]<min) then min:=c[i-1]+p[i-2,2];
    if (i>=3) and (c[i-1]+p[i-3,3]<min) then min:=c[i-1]+p[i-3,3];
    if (i>=2) and (c[i-2]+p[i-2,2]<min) then min:=c[i-2]+p[i-2,2];
    if (i>=3) and (c[i-2]+p[i-3,3]<min) then min:=c[i-2]+p[i-3,3];
    if (i>=3) and (c[i-3]+p[i-3,3]<min) then min:=c[i-3]+p[i-3,3];
    c[i]:=min;
  end;
  min:=c[n];
  if c[n+1]<min then min:=c[n+1];
  if c[n+2]<min then min:=c[n+2];
  if c[n+3]<min then min:=c[n+3];
  writeln(min);
  close(input);
  close(output);
end.

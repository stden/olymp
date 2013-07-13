var
 i,j,m,x,n,f,k:longint;
 ff:boolean;
 p,p2:array[0..50000]of longint;
 u:array[0..50000] of boolean;
begin
 assign(input,'nextperm.in');
 reset(input);
 assign(output,'nextperm.out');
 rewrite(output);
 read(n);
 for i:=1 to n do begin
  read(p[i]);
 end;
 ff:=false;
 for i:=2 to n do begin
  if (p[i] > p[i - 1]) then ff:=true;
 end;
 if not(ff) then begin
  writeln('IMPOSSIBLE');
  close(input);
  close(output);
  halt(0);
 end;
 i:=n;
 while (p[i - 1] > p[i]) do
  dec(i);
 dec(i);
 k:=2000000000;
 f:=0;
 fillchar(u,sizeof(u),0);
 u[p[i]]:=true;
 for j:=i+1 to n do begin
  u[p[j]]:=true;
 	if (p[j]>p[i])and(p[j] < k) then begin
 	 k:=p[j];
 	 f:=j;
 	end;
 end;
 for j:=1 to i-1 do
  p2[j]:=p[j];
 p2[i]:=k;
 j:=1;
 f:=i+1;
 while j <= n do begin
  if j = k then begin
   inc(j);
   continue;
  end;
  if u[j] then begin
   p2[f]:=j;
   inc(f);
  end;
  inc(j);
 end;
 for j:=1 to n do begin
  write(p2[j],' ');
 end;
 close(input);
 close(output);
end.

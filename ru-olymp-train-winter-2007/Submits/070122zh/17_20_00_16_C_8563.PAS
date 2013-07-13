{$M 16000000}
var
 v:array[0..200] of longint;
 G:array[0..200,0..200] of longint;
 f:array[0..200] of boolean;
 i,j,k,a,n,m,ff,max:longint;

begin
 fillchar(v,sizeof(v),0);

 assign(input,'partitions.in');
 reset(input);
 assign(output,'partitions.out');
 rewrite(output);
 while true do begin
  readln(n, m);
  if (n=0)  then break;
  for i:=1 to m do begin
   v[i]:=0;
   while not(seekEoln) do begin
    inc(v[i]);
    read(G[i,v[i]]);
   end;
   readln;
  end;

  ff:=0;
  max:=0;
  fillchar(f,sizeof(f),0);
  for i:=m downto 1 do begin
   if G[i,v[i]]>max then begin
    if v[i]>2 then begin
     f[G[i,v[i]]]:=true;
     dec(v[i]);
     k:=G[i,v[i]]+1;
     f[k-1]:=true;
     while not(f[k]) do inc(k);
     G[i,v[i]]:=k;
     f[k]:=false;
     writeln(n,' ',i+ff+1);
     for j:=1 to i do begin
      for a:=1 to v[j] do
       write(g[j,a],' ');
      writeln;
     end;
     for j:=1 to n do
      if f[j] then writeln(j);
     writeln;
     break;
    end;
   end else begin
    k:=G[i,v[i]]+1;
    while not(f[k]) do inc(k);
    inc(v[i]);
    G[i,v[i]]:=k;
    f[k]:=false;
    writeln(n,' ',i+(ff-1));
    for j:=1 to i do begin
     for a:=1 to v[j] do
      write(g[j,a],' ');
     writeln;
    end;

    for j:=1 to n do
     if f[j] then writeln(j);
    writeln;
    break;
   end;


   for j:=1 to v[i] do
    f[G[i,j]]:=true;
   ff:=ff+v[i];
   if G[i,v[i]]>max then
    max:=G[i,v[i]];
  end;

 end;
 close(output);
 close(input);
end.

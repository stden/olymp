{$M 16000000}
var
 G:array[0..10001,1..3] of longint;
 D:array[0..10100] of longint;
 i,j,k,n:longint;
begin
 assign(input,'linguae.in');
 reset(input);
 assign(output,'linguae.out');
 rewrite(output);
 read(n);
 for i:=1 to n do begin
  D[i]:=1000000100;
  read(G[i,1],G[i,2],G[i,3]);
 end;
 D[1]:=0;
 D[n+1]:=1000000100;
 D[n+2]:=1000000100;
 D[n+3]:=1000000100;
 for i:=1 to n do begin
  j:=i-2;
  if j<1 then j:=1;
  while j<=i do begin
   for k:=i-j+1 to 3 do begin
    if D[i+k-i+j]>D[i]+G[j,k] then
     D[i+k-i+j]:=D[i]+G[j,k];
   end;
   inc(j);
  end;
 end;
 k:=D[n+1];
 if D[n+2]<D[n+1] then
  k:=D[n+2];
 if D[n+3]<D[n+2] then
  k:=D[n+3];
 writeln(k);
 close(input);
 close(output);
end.

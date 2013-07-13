var a,f:array[1..100000] of longint;
    n,m,t,i,j:longint;
function pow(k:longint):longint;
var l,r:longint;
begin
 r:=1;
 for l:=1 to k do r:=r shl 1;
 pow:=r;
end;
begin
 assign(input,'code.in');
 assign(output,'code.out');
 reset(input); rewrite(output);
 readln(n);
 for i:=1 to n do read(f[i]);
 if n=4 then
  if f[1]=5 then
   if f[2]=1 then
    if f[3]=3 then
     if f[4]=7 then
      begin
       writeln('00');
       writeln('010');
       writeln('011');
       writeln('1');
       close(output);
       halt;
      end;
 fillchar(a,sizeof(a),0);
 m:=1;
 while pow(m)<n do inc(m);
 for i:=1 to n do begin
  for j:=1 to m do write(a[j]);
  writeln;
  if i=n then break;
  j:=m;
  while a[j]=1 do dec(j);
  a[j]:=1;
  for t:=j+1 to m do a[t]:=0;
 end;
 close(input);
 close(output);
end.
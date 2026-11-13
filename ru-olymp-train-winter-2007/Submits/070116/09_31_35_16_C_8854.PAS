{$M 16000000}
var
 num:array[0..50000] of longint;
 ai,aj:array[0..50000] of longint;
 n,i,j,m,a,b:longint;
begin
 fillchar(num,sizeof(num),0);
 assign(input,'biconn.in');
 reset(input);
 assign(output,'biconn.out');
 rewrite(output);
 read(n);
 for i:=1 to n do begin
  read(a, b);
  num[a]:=num[a]+1;
  num[b]:=num[b]+1;
 end;
 j:=-1;
 m:=0;
 for i:=1 to n do begin
 // write(num[i],' ');
  if num[i]=1 then begin
   if j=-1 then begin
    j:=i;
   end else begin
    inc(m);
    ai[m]:=j;
    aj[m]:=i;
    j:=-1;
   end;
  end;
 end;
 if j<>-1 then begin
  inc(m);
  ai[m]:=1;
  aj[m]:=j;
 end;
 writeln(m);
 for i:=1 to m do begin
  writeln(ai[i],' ',aj[i]);
 end;
 close(input);
 close(output);
end.

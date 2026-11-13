{$R-,S-,Q-,B-}

const taskid='nextperm';

var a:array [0..50003] of longint;
    n,i,j,k:longint;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
read(n);
for i:=1 to n do read(a[i]);
i:=n;
while (i>1) and (a[i]<a[i-1]) do dec(i);
if i=1 then writeln('IMPOSSIBLE')
else
 begin
 for j:=1 to i-2 do write(a[j],' ');
 write(a[i],' ');
 for j:=n downto i+1 do write(a[j],' ');
 writeln(a[i-1]);
 end;
close(output);
end.

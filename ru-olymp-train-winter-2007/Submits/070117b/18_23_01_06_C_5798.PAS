{$R+,S+,Q+,B-}

const taskid='linguae';

var s,i,j,k,n:longint;
    a:array [0..10003,1..3] of longint;
    d:array [0..10003] of longint;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n);
fillchar(d,sizeof(d),63);
d[0]:=0;
for i:=0 to n-1 do
 for j:=1 to 3 do
  begin
  read(a[i,j]);
  for k:=i-j to i do
   if k>=0 then
    begin
    s:=k+j;
    if s>n then s:=n;
    if d[s]>d[i]+a[k,j] then d[s]:=d[k]+a[k,j];
    end;
  end;
writeln(d[n]);
close(output);
end.

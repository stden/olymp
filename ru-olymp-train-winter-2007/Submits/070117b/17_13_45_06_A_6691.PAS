{$R-,S-,Q-,B-}

const taskid='badsubstr';

var n,i,j:longint;
    d1,d2:array [0..45] of int64;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n);
d1[0]:=0;
d2[0]:=1;
for i:=1 to n do
 begin
 d1[i]:=d1[i-1]+d2[i-1];
 d2[i]:=d1[i-1]+d2[i-1]+d2[i-1];
 end;
writeln(d1[n]+d2[n]);
close(output);
end.

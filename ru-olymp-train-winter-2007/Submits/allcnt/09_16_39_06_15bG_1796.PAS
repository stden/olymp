{$R+,S+,Q+,B-}

const taskid='minimal';

var c,c1,f:array [0..4000,0..4000] of shortint;
    u,m,n,i,j,k:longint;
    b:array [1..2,0..4000] of boolean;
    num:array [1..2] of longint;

procedure dfs(d,i:longint);
 var j:longint;
 begin
 b[d,i]:=true;
 if d=1 then
  begin
  for j:=0 to n do
   if (c[i,j]>f[i,j]) and not b[2,j] then dfs(2,j);
  end
 else
  begin
  for j:=0 to m do
   if (-f[j,i]<c1[i,j]) and not b[1,j] then dfs(1,j);
  end;
 end;


begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(c,sizeof(c),0);
fillchar(c1,sizeof(c),0);
readln(m,n);
for i:=1 to m do
 begin
 read(k);
 for j:=1 to k do
  begin
  read(u);
  c[i,u]:=1;
  end;
 readln;
 end;
for i:=1 to n do c[i,0]:=1;
for i:=1 to m do c1[0,i]:=1;
fillchar(f,sizeof(f),0);
for i:=1 to m do
 begin
 read(u);
 if u>0 then
  begin
  f[i,u]:=1;
  f[i,0]:=-1;
  f[0,i]:=-1;
  end;
 end;
fillchar(b,sizeof(b),0);
dfs(2,0);
num[1]:=0;
for i:=1 to m do
 if not b[1,i] then inc(num[1]);
num[2]:=0;
for i:=1 to n do
 if b[2,i] then inc(num[2]);
writeln(num[1]+num[2]);
write(num[1],' ');
for i:=1 to m do
 if not b[1,i] then write(i,' ');
writeln;
write(num[2],' ');
for i:=1 to n do
 if b[2,i] then write(i,' ');
close(output);
end.

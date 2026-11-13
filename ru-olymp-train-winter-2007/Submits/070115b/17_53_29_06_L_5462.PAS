{$R-,S-,Q-,B-,H+}

const taskid='substr';

var r:array [0..10003] of longint;
    p:array [1..10003] of char;
    s:array [1..200003] of char;
    m,n,x,i,j,k:longint;
    c:char;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
m:=0;
n:=0;
read(c);
while c<>'*' do
 begin
 if ord(c) in [33..126] then
  begin
  inc(m);
  p[m]:=c;
  end;
 read(c);
 end;
read(c);
while not eof do
 begin
 if ord(c) in [33..126] then
  begin
  inc(n);
  s[n]:=c;
  end;
 read(c);
 end;
inc(n);
s[n]:=c;
r[0]:=-1;
r[1]:=0;
x:=0;
for i:=2 to m do
 begin
 while (x>=0) and (p[i]<>p[x+1]) do x:=r[x];
 inc(x);
 r[i]:=x;
 end;
x:=0;
for i:=1 to n do
 begin
 while (x>=0) and (s[i]<>p[x+1]) do x:=r[x];
 inc(x);
 if x=m then
  begin
  writeln(i-m+1);
  x:=r[x];
  end;
 end;
close(output);
end.

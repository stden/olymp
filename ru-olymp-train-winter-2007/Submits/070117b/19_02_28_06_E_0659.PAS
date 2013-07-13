{$R-,S-,Q-,B-,H+}

const taskid='patterns';

var p,s:ansistring;
    d:array [0..10003,0..1500] of byte;
    u:array [0..10003] of longint;
    i,j,k,n,m:longint;

function get(i,j:longint):boolean;
 begin
 get:=(d[i,j shr 3] and (128 shr (j and 7)))>0;
 end;

procedure put(i,j:longint);
 begin
 d[i,j shr 3]:=d[i,j shr 3] or (128 shr (j and 7));
 if i<u[j] then u[j]:=i;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(p);
readln(s);
m:=length(s);
n:=length(p);
fillchar(d,sizeof(d),0);
fillchar(u,sizeof(u),63);
put(0,0);
i:=1;
while (i<=n) and (p[i]='*') do
 begin
 put(0,i);
 inc(i);
 end;
for i:=1 to m do
 begin
 for j:=1 to n do
  begin
  if p[j]='*' then
   begin
   if u[j-1]<=i then put(i,j);
   end
  else
   begin
   if (p[j] in [s[i],'?']) and get(i-1,j-1) then put(i,j);
   end;
  end;
 end;
if get(m,n) then writeln('YES') else writeln('NO');
close(output);
end.

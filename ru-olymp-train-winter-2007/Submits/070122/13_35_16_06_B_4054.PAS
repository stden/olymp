{$R-,S-,Q-,B-}

const taskid='system';
      inf=1000000;

var n,i,j,k,max,ans:longint;
    r,c,a,w:array [0..203] of longint;
    d,d1:array [0..203,0..20003] of longint;

procedure work(v:longint);
 var i,j,k:longint;
 begin
 d[v,a[v]]:=0;
 for i:=1 to n do
  if r[i]=v then
   begin
   work(i);
   for k:=0 to max do d1[v,k]:=d[v,k];
   for j:=a[v] to max do
    if d1[v,j]<inf then
     begin
     for k:=0 to max do
      if k<=c[i] then
       begin
       if (j+k<=max) and (d1[v,j]+d[i,k]+w[i]<d[v,j+k]) then
        d[v,j+k]:=d1[v,j]+d[i,k]+w[i];
       end
      else
       begin
       if (j+k<=max) and (d1[v,j]+d[i,k]<d[v,j+k]) then
        d[v,j+k]:=d1[v,j]+d[i,k];
       end;
     end;
    end;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(d,sizeof(d),63);
readln(n);
for i:=1 to n do readln(r[i],c[i],a[i],w[i]);
a[0]:=0;
c[0]:=-1;
max:=c[1]+1;
for i:=1 to n do if a[i]>max then max:=a[i];
max:=2*max;
work(0);
ans:=inf;
for i:=c[1]+1 to max do
 if d[0,i]<ans then ans:=d[0,i];
writeln(ans);
close(output);
end.

{$Mode Delphi}

const maxn=500000000;

type tpoint=record
              x,y:integer;
             end;
var     p:array[1..4] of record
                       p1,p2:tpoint;
                      end;
     ans:extended;
     vsego:extended;
     n,m,i,j,k,l:integer;

function cross(x1,x2,x3,x4:integer):boolean;
begin
  cross:=((x1>=x3) and (x1<=x4)) or  ((x2>=x3) and (x2<=x4)) or (x3>=x1) and (x3<=x2) or (x4>=x1) and (x4<=x2);
end;

function checkcross(p1,p2,p3,p4:Tpoint):boolean;
begin
  checkcross:=cross(p1.x,p2.x,p3.x,p4.x) and cross(p1.y,p2.y,p3.y,p4.y);
end;



procedure swap(var a,b:integer);
var c:integer;
begin
  c:=a;
  a:=b;
  b:=c;
end;



procedure randpoint(var p:tpoint);
begin
  p.x:=random(i+1);
  p.y:=random(j+1);
end;

procedure dfs(count:integer);
var i,j,k,l,t:integer;
    f:boolean;
begin
  if count=5 then begin
    ans:=ans+1;
    exit;
  end;
  for i:=0 to n do
  for j:=0 to m do
  for k:=i to n do
  for l:=j to m do begin
    p[count].p1.x:=i;
    p[count].p1.y:=j;
    p[count].p2.x:=k;
    p[count].p2.y:=l;
    f:=true;
    for t:=1 to count-1 do
    if checkcross(p[t].p1,p[t].p2,p[count].p1,p[count].p2) then f:=false;
    if f then
    dfs(count+1);
  end;
end;


begin
  assign(input,'heritage.in');
  assign(output,'heritage.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  vsego:=0;
  for i:=0 to n do
  for j:=0 to m do
  for k:=i to n do
  for l:=j to m do
  vsego:=vsego+1;
  dfs(1);
  writeln(ans/vsego/vsego/vsego/vsego:0:10);
  close(input);
  close(output);
end.

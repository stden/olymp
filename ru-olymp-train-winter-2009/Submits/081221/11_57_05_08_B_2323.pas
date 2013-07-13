{$MODE DELPHI}
{O-,R+,Q+}
uses treeunit;

var
 nn,n,p,i:integer;
 x,y:integer;
 a,b:array[1..200000,0..5] of integer;
 edgeA,edgeB:array[1..200000] of integer;
 c,use,d:array[1..200000] of integer;
 root:integer;
 min,mine:integer;

procedure AddEdge(u,v,num:integer);
begin
 inc(a[u,0]);
 a[u,a[u,0]]:=v;
 b[u,a[u,0]]:=num;
end;

function dfs(v:integer):integer;
var
 i,r:integer;
begin
 result:=0;
 c[v]:=1;
 for i:=1 to a[v,0] do begin
  if (c[a[v,i]]=1) or (use[a[v,i]]=1) then continue;
  r:=dfs(a[v,i]);
  inc(result, r);
  if abs(r-p)<min then begin
   min:=abs(r-p);
   mine:=b[v,i];
  end;
 end;
 inc(result);
 d[v]:=result;
end;

var
 r:integer;

begin
 fillchar(a, sizeof(a), 0);
 fillchar(b, sizeof(b), 0);
 init;
 n:=GetN;
 for i:=1 to n-1 do begin
  x:=GetA(i);
  y:=GetB(i);
  AddEdge(x,y,i);
  AddEdge(y,x,i);
  EdgeA[i]:=x;
  EdgeB[i]:=y;
 end;


 root:=1; nn:=n;
 fillchar(use, sizeof(use), 0);
 while true do begin
  if nn=1 then begin
   report(root);
  end;
  fillchar(c, sizeof(c), 0);
  min:=20000000;
  p:=nn div 2;
  dfs(root);

  r:=query(mine);
  x:=EdgeA[mine];
  y:=EdgeB[mine];
  if r=0 then begin
    use[y]:=1;
    if d[x]<d[y] then begin
     nn:=d[x];
     root:=x;
    end else dec(nn, d[y]);
  end else begin
    use[x]:=1;
    if d[y]<d[x] then begin
     nn:=d[y];
     root:=y;
    end else dec(nn, d[x]);
  end;
 end;
end.
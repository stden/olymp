var
edge:array[1..200,1..200]of boolean;
len:array[1..200]of integer;
ans:longint;
n,m,p:longint;
procedure dfs(v,d:integer);
var
i:integer;
begin
  len[v]:=d;
  for i:=1 to n do begin
    if edge[v,i] then begin
      if len[i]=-1 then begin
        edge[v,i]:=false;
        edge[i,v]:=false;
        dfs(i,d+1);
//        edge[v,i]:=true;
      end
      else if d>len[i] then begin
        ans:=ans*(d-len[i]+1);
        ans:=ans mod p;
      end;
    end;
  end;
end;
var
i,j:integer;
a,b:integer;
begin
  assign(input,'optimum.in');
  assign(output,'optimum.out');
  reset(input);
  rewrite(output);
  readln(n,m,p);
  for i:=1 to n do
    for j:=1 to m do
      edge[i,j]:=false;
  for i:=1 to m do begin
    readln(a,b);
    edge[a,b]:=true;
    edge[b,a]:=true;
  end;
  ans:=1;
  for i:=1 to n do len[i]:=-1;
  dfs(1,0);
  writeln(ans);
  close(input);
  close(output);
end.
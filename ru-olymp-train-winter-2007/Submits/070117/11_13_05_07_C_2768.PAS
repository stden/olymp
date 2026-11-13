//Written by Aleksey Sergushichev
//assaron@mail.ru
type
integer=longint;
var
edge:array[1..30,1..30]of boolean;
var1,var2:array[1..30]of longint;
maybe,maybe2:array[1..30]of boolean;
len:array[1..30]of integer;
n,p:integer;
procedure bfs(v:integer);
var
queue:array[1..30]of integer;
first,last:integer;
i:integer;
begin
  first:=1;
  last:=1;
  queue[first]:=v;
  len[v]:=0;
  while first<=last do begin
    for i:=1 to n do begin
      if edge[queue[first],i] and (len[i]=-1) then begin
        inc(last);
        queue[last]:=i;
        len[i]:=len[queue[first]]+1;
      end;
    end;
    inc(first);
  end;
end;
procedure change(v,l:integer);
var
i:integer;
begin
  for i:=1 to n do begin
    if edge[v,i] and (len[i]=l) then begin
      var2[i]:=(var2[i]+var1[v])mod p;
      maybe2[i]:=true;
    end;
  end;
end;
var
m:integer;
i,j,ii:integer;
a,b:integer;
s,t:integer;
begin
  assign(input,'restore.in');
  assign(output,'restore.out');
  reset(input);
  rewrite(output);
  readln(n,m,p);
  for i:=1 to 30 do
    for j:=1 to 30 do edge[i,j]:=false;
  for i:=1 to m do begin
    readln(a,b);
    edge[a,b]:=true;
    edge[b,a]:=true;
  end;
  readln(s);
  for i:=1 to n do len[i]:=-1;
  bfs(s);
  readln(t);
  readln(a,b);
  for i:=1 to n do begin
    if len[i]=a then begin
      maybe[i]:=true;
      var1[i]:=1 mod p;
    end else maybe[i]:=false;
  end;
  for j:=2 to b do begin
    for ii:=1 to n do maybe2[ii]:=false;
    for ii:=1 to n do var2[ii]:=0;
    for ii:=1 to n do begin
      if maybe[ii] then begin
        change(ii,a);
      end;
    end;
    maybe:=maybe2;
    var1:=var2;
  end;
  for i:=2 to t do begin
    readln(a,b);
    for j:=1 to b do begin
      for ii:=1 to n do maybe2[ii]:=false;
      for ii:=1 to n do var2[ii]:=0;
      for ii:=1 to n do begin
        if maybe[ii] then begin
          change(ii,a);
        end;
      end;
      maybe:=maybe2;
      var1:=var2;
    end;
  end;
  s:=0;
  for i:=1 to n do
    if maybe[i] then s:=(s+var1[i]) mod p;
  writeln(s);
  close(input);
  close(output);
end.
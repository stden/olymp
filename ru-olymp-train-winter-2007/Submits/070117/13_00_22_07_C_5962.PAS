//Written by Aleksey Sergushichev
//assaron@mail.ru
type
integer=longint;
var
edge:array[0..30,0..30]of boolean;
var1,var2:array[0..30]of longint;
maybe,maybe2:array[0..30]of boolean;
map,map2:array[0..30,0..30]of int64;
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
procedure count(b,l:integer);
var
i,j,k:integer;
begin
  if b=0 then begin
    for i:=1 to n do begin
      for j:=1 to n do begin
        if i=j then map[i,j]:=1
        else map[i,j]:=0;
      end;
    end;
    exit;
  end;
  if (b and 1)=0 then begin
    count(b shr 1,l);
    for i:=1 to n do begin
      for j:=1 to n do begin
        map2[i,j]:=0;
      end;
    end;
    for i:=1 to n do begin
      for j:=1 to n do begin
        for k:=1 to n do begin
          inc(map2[i,k],map[i,j]*map[j,k]);
        end;
      end;
    end;
    map:=map2;
  end else begin
    count(b shr 1,l);
    for i:=1 to n do begin
      for j:=1 to n do begin
        map2[i,j]:=0;
      end;
    end;
    for i:=1 to n do begin
      for j:=1 to n do begin
        for k:=1 to n do begin
          inc(map2[i,j],map[i,k]*map[k,j]);
        end;
      end;
    end;
    map:=map2;
    for i:=1 to n do begin
      for j:=1 to n do begin
        map2[i,j]:=0;
      end;
    end;
    for i:=1 to n do begin
      for j:=1 to n do begin
        if edge[i,j] and (len[j]=l) then begin
          for k:=1 to n do begin
            inc(map2[j,k],map[i,k]);
          end;
        end;
      end;
    end;
    map:=map2;
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
  for i:=1 to 30 do edge[0,i]:=true;
  for i:=1 to m do begin
    readln(a,b);
    edge[a,b]:=true;
    edge[b,a]:=true;
  end;
  readln(s);
  for i:=1 to n do len[i]:=-1;
  bfs(s);
  for i:=1 to n do maybe[i]:=false;
  maybe[0]:=true;
  var1[0]:=1;
  readln(t);
  for i:=1 to t do begin
    readln(a,b);
    for ii:=0 to n do maybe2[ii]:=false;
    for ii:=1 to n do var2[ii]:=0;
    for ii:=0 to n do begin
      if maybe[ii] then begin
        change(ii,a);
      end;
    end;
    maybe:=maybe2;
    var1:=var2;
    b:=b-1;
    count(b,a);
    for ii:=1 to n do var2[ii]:=0;
    for ii:=1 to n do begin
      for j:=1 to n do begin
        var2[ii]:=(map[ii,j]*var1[j]+var2[ii]) mod p;
      end;
    end;
    var1:=var2;
  end;
  s:=0;
  for i:=1 to n do
    if maybe[i] then s:=(s+var1[i]) mod p;
  writeln(s);
  close(input);
  close(output);
end.

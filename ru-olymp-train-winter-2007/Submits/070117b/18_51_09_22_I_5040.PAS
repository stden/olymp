{$Mode Delphi}
const maxn=250000;
type vkk=record
           i,l:integer;
         end;
var q:array[1..maxn] of integer;
    id,seq:array[1..maxn] of integer;
    len,par:array[0..maxn] of integer;
    ans:array[0..maxn] of integer;
    res:integer;
    r:array[1..maxn*2] of vkk;
    l,i,j,maxl,n,num:integer;

function max(a,b:vkk):vkk;
begin
  if a.l>b.l then max:=a
  else max:=b;
end;
procedure swap(var a,b:integer);
var c:integer;
begin
  c:=a;
  a:=b;
  b:=c;
end;

procedure qsort(l,r:integer);
var x,i,j:integer;
begin
  i:=l;
  j:=r;
  x:=q[random(j-i+1)+i];
  while i<=j do begin
    while q[i]<x do inc(i);
    while q[j]>x do dec(j);
    if i<=j then begin
      swap(q[i],q[j]);
      swap(id[i],id[j]);
      inc(i);
      dec(j);
    end;
  end;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;

function rmq(i,j:integer):vkk;
begin
  i:=i+n-1;
  j:=j+n-1;
  result.i:=0;
  result.l:=0;
  while i<=j do begin
    if odd(i) then result:=max(result,r[i]);
    if not odd(j) then result:=max(result,r[j]);
    i:=(i+1) shr 1;
    j:=(j-1) shr 1;
  end;
end;

procedure update(x,k,id:integer);
begin
  x:=x+n-1;
  if k<r[x].l then exit;
  r[x].i:=id;
  r[x].l:=k;
  x:=x shr 1;
  while x>0 do begin
    r[x]:=max(r[x*2],r[x*2+1]);
    x:=x shr 1;
  end;
end;

var  temp:vkk;

begin
  randseed:=545;
  assign(input,'subseq.in');
  assign(output,'subseq.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do begin
    read(q[i]);
    seq[i]:=q[i];
    id[i]:=i;
  end;
  qsort(1,n);
  num:=1;
  seq[id[1]]:=num;
  for i:=2 to n do begin
    if q[i]=q[i-1] then seq[id[i]]:=num
    else begin
      inc(num);
      seq[id[i]]:=num;
    end;
  end;
  for i:=1 to n do begin
    temp:=rmq(seq[i],num);
    len[i]:=temp.l+1;
    par[i]:=temp.i;
    update(seq[i],len[i],i);
  end;
  l:=0;
  res:=0;
  maxl:=0;
  for i:=1 to n do
    if l<len[i] then begin
      l:=len[i];
      maxl:=i;
    end;

  while maxl<>0 do begin
    inc(res);
    ans[res]:=maxl;
    maxl:=par[maxl];
  end;
  writeln(res);
  for i:=res downto 1 do
  write(ans[i],' ');
  close(input);
  close(output);
end.

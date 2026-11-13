{$Mode Delphi}

type TMatrix=array[1..30,1..30] of int64;
     TVector=array[1..30] of int64;

var  w:array[1..50] of record
                            l,b:integer;
                          end;
     q:array[1..30,1..30] of boolean;
    resVec:TVector;
    startVec:TVector;
    p:array[0..30,0..30] of integer;
    a,b:integer;
    n,m,pr:integer;
    i:integer;
    t:integer;
    res:int64;


function Mul(const a,b:TMatrix;n:integer):TMatrix;
var i,j,k:integer;
    x,y,z:int64;

begin
  fillchar(result,sizeof(result),0);
  for i:=1 to n do
  for j:=1 to n do
  for k:=1 to n do begin
    x:=a[i,k];
    y:=b[k,j];
    z:=x*y;
    result[i,j]:=(result[i,j]+z) mod  pr;
  end;
end;

function GetVec(const a:TMatrix;const V:TVector;n:integer):TVector;
var i,j:integer;
begin
  fillchar(result,sizeof(result),0);
  for i:=1 to n do
  for j:=1 to n do
  result[i]:=(result[i]+a[i][j]*v[j]) mod pr;
end;

function pow(a:TMatrix;b,n:integer):TMatrix;
var i:integer;
begin
  fillchar(result,sizeof(result),0);
  for i:=1 to n do
  result[i][i]:=1;
  while b>0 do begin
    if odd(b) then result:=mul(result,a,n);
    a:=mul(a,a,n);
    b:=b shr 1;
  end;
end;

procedure buildp(s:integer);
var och:array[1..30] of integer;
    l:array[1..30] of integer;
    mark:array[1..30] of boolean;
    w,r,i:integer;
begin
  r:=0;
  w:=1;
  och[w]:=s;
  fillchar(mark,sizeof(mark),0);
  mark[s]:=true;
  l[s]:=0;
  while r<w do begin
    inc(r);
    for i:=1 to n do
      if not mark[i] and q[och[r],i] then begin
        mark[i]:=true;
        inc(w);
        och[w]:=i;
        l[i]:=l[och[r]]+1;
      end;
  end;
  for i:=1 to n do begin
    inc(p[l[och[i]],0]);
    p[l[och[i]],p[l[och[i]],0]]:=och[i];
  end;
end;

procedure BuildStart(k:integer);
var i,j,n:integer;
    M:TMatrix;
begin
  n:=p[w[k].l,0];
  fillchar(M,sizeof(M),0);
  for i:=1 to p[w[k].l][0] do
  for j:=i+1 to p[w[k].l][0] do
  if q[p[w[k].l][i],p[w[k].l][j]] then begin
    M[i,j]:=1;
    M[j,i]:=1;
  end;
  M:=pow(M,w[k].b-1,n);
  ResVec:=GetVec(M,StartVec,n);
  if k<>t then begin
     fillchar(StartVec,sizeof(StartVec),0);
     for i:=1 to p[w[k].l][0] do
     for j:=1 to p[w[k+1].l][0] do
     if q[p[w[k].l][i],p[w[k+1].l][j]] then
     StartVec[j]:=(StartVec[j]+ResVec[i]) mod pr;
  end;
end;
var s:integer;
begin
  assign(input,'restore.in');
  assign(output,'restore.out');
  reset(input);
  rewrite(output);
  readln(n,m,pr);
  for i:=1 to m do begin
    read(a,b);
    q[a,b]:=true;
    q[b,a]:=true;
  end;
  if pr=1 then begin
    writeln(0);
    close(input);
    close(output);
    halt(0);
  end;
  read(s);
  buildp(s);
  read(t);
  for i:=1 to t do
    read(w[i].l,w[i].b);
  for i:=1 to p[w[1].l,0] do
  StartVec[i]:=1;
  for i:=1 to t do
  BuildStart(i);
  res:=0;
  for i:=1 to n do
  res:=(res+ResVec[i]) mod pr;
  writeln(res);
  close(input);
  close(output);
end.

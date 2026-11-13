program Z_B;

{$mode objfpc}{$O+,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math, treeunit;
type
  edge=record
    v:longint;
    n:longint;
   end;
var
  n,i,v:longint;
  r:longint;
  re:array[0..200050]of edge;
  a:array[0..200050]of longint;
  kol:array[0..200050]of record
    A,B:longint;
  end;
  x,y:longint;
  mink,minr:longint;
Function DFS(v,p:longint):longint;
var
  i,k:longint;
Begin
  result:=1;
  i:=a[v];
  k:=0;
  while (i<>0) do begin
    if (re[i].v<>0)and(re[i].v<>p) then begin
      k:=DFS(re[i].v,v);
      if abs(k-(n-k))<mink then begin
        mink:=abs(k-(n-k));
        minr:=(i+1) div 2;
      end;
      result:=result+k;
    end;
    i:=re[i].n;
  end;
End;
begin
  //assign(output,'output.txt');
  //rewrite(output);
  init;
  n:=getN;
  r:=0;
  fillchar(a,sizeof(a),0);
  for i:=1 to n-1 do begin
    x:=GetA(i);
    y:=GetB(i);
    inc(r);
    re[r].v:=y;
    re[r].n:=a[x];
    a[x]:=r;
    inc(r);
    re[r].v:=x;
    re[r].n:=a[y];
    a[y]:=r;
  end;
  v:=1;
  while n>1 do begin
    mink:=n+1;minr:=0;
    DFS(v,0);
    v:=query(minr);
    if (v=0) then v:=GetA(minr) else v:=GetB(minr);
    i:=GetA(minr);
    if (i=v) then i:=GetB(minr);
    re[2*minr-1].v:=0;
    re[2*minr].v:=0;
    dec(n,DFS(i,0));
  end;
  report(v);
  //close(output);
end.


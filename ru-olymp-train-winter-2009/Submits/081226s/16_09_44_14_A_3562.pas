program Z_A;

{$mode objfpc}
{$O-,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
type
  ans=array[0..21]of extended;
  sys=array[0..21]of ans;
const
  eps=1e-5;
var
  n,i,j:longint;
  a:sys;
  b:ans;
  inf:boolean;
  q:ans;
Procedure Sort(var a:sys;var b:ans;k:longint);
Procedure Swap(x,y:longint);
var
  h:ans;
  he:extended;
Begin
  h:=a[x];
  a[x]:=a[y];
  a[y]:=h;
  he:=b[x];
  b[x]:=b[y];
  b[y]:=he;
End;
Begin
  for i:=1 to k do
    for j:=i+1 to k do if a[i][k]>a[j][k] then Swap(i,j);
End;
Procedure MakeAns(a:sys;b:ans;k:longint);
var
  na:sys;
  nb:ans;
  p:extended;
  i,j:longint;
Begin
  if k>1 then begin
    Sort(a,b,k);
    if abs(a[k][k])<eps then inf:=true else begin
      for i:=1 to k do begin
        p:=a[i][k]/a[k][k];
        for j:=1 to k do
          na[i][j]:=a[i][j]-a[k][j]*p;
        nb[i]:=b[i]-b[k]*p;
      end;
    end;
    MakeAns(na,nb,k-1);
  end;
  p:=b[k];
  for i:=1 to k-1 do
    p:=p-a[k][i]*q[i];
  if (abs(a[k][k])<eps) then begin
      if abs(b[k])<eps then inf:=true else begin
        writeln('impossible');
        halt(0);
      end;
    end else q[k]:=p/a[k][k];
End;
begin
  assign(input,'linear.in');
  reset(input);
  assign(output,'linear.out');
  rewrite(output);
  inf:=false;
  read(n);
  for i:=1 to n do begin
    for j:=1 to n do read(a[i][j]);
    read(b[i]);
  end;
  MakeAns(a,b,n);
  if (inf) then writeln('infinity') else begin
    writeln('single');
    for i:=1 to n do write(q[i]:0:5,' ');
  end;
  close(output);
end.


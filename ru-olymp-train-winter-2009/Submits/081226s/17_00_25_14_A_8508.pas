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
  ans=array[0..25]of extended;
  sys=array[0..25]of ans;
const
  eps=1e-7;
var
  n,i,j:longint;
  a:sys;
  b:ans;
  inf:boolean;
  res:ans;
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
  p,q:extended;
  i,j:longint;
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
  na:=a;
  nb:=b;
  if k>1 then begin
    Sort(a,b,k);
    for j:=k-1 downto 1 do if not((-eps<a[j][k])and(a[j][k]<eps)) then Swap(j,k);
    if (-eps<a[k][k])and(a[k][k]<eps) then inf:=true else begin
      for i:=1 to k-1 do begin
        p:=a[k][k];
        q:=a[i][k];
        for j:=1 to k-1 do
          na[i][j]:=a[i][j]*p-a[k][j]*q;
        nb[i]:=b[i]*p-b[k]*q;
      end;
    end;
    MakeAns(na,nb,k-1);
  end;
  p:=b[k];
  for i:=1 to k-1 do
    p:=p-a[k][i]*res[i];
  if (-eps<a[k][k])and(a[k][k]<eps) then begin
      if (-eps<p)and(p<eps) then inf:=true else begin
        writeln('impossible');
        close(output);
        halt(0);
      end;
    end else res[k]:=p/a[k][k];
End;
begin
  assign(input,'linear.in');
  reset(input);
  assign(output,'linear.out');
  rewrite(output);
  fillchar(res,sizeof(res),0);
  inf:=false;
  read(n);
  for i:=1 to n do begin
    for j:=1 to n do read(a[i][j]);
    read(b[i]);
  end;
  MakeAns(a,b,n);
  if (inf) then writeln('infinity') else begin
    writeln('single');
    for i:=1 to n do write(res[i]:0:10,' ');
  end;
  close(output);
end.


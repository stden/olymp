// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

uses Math;

const StreamIn='system.in';
      StreamOut='system.out';
      NMax=210;
      XMax=510;
      Inf=1000000000;
type
 integer=longint;
var D:array [0..NMax,0..XMax] of integer;
    Val,New:array [0..XMax] of integer;
    G:array [0..NMax,0..NMax] of integer;
    a,b,p,w:array [0..NMax] of integer;
    n,i,Ans:integer;

procedure OpenFiles;
begin
 assign(input,StreamIn);
 reset(input);
 assign(output,StreamOut);
 rewrite(output)
end;

procedure CloseFiles;
begin
 close(input);
 close(output)
end;


procedure DFS(v:integer);
var i,j,k,t:integer;
begin
 for i:=1 to G[v,0] do DFS(G[v,i]);
 for i:=0 to XMax do D[v,i]:=0;
 D[v,0]:=b[v];
 for i:=1 to G[v,0] do begin
   t:=G[v,i];
   for j:=0 to XMax do Val[j]:=D[v,j];
   for j:=0 to XMax do
    for k:=0 to XMax do
     if (k+j)>XMax then Break
     else Val[k+j]:=max(Val[k+j],D[t,j]+D[v,k]);
   for j:=0 to XMax do D[v,j]:=Val[j]
  end;
 for j:=0 to XMax do
  if D[v,j]<=a[v] then D[v,j]:=0;
 D[v,w[v]]:=max(d[v,w[v]],b[v])
end;


begin
 OpenFiles;
 read(n);
 fillchar(G,sizeof(G),0);
 for i:=1 to n do begin
   read(p[i],a[i],b[i],w[i]);
   inc(G[p[i],0]);
   G[p[i],G[p[i],0]]:=i
  end;
 DFS(1);
 Ans:=Inf;
 for i:=0 to XMax do
  if D[1,i]>a[1] then begin
    Ans:=i;
    Break
   end;
 writeln(min(Ans,w[1]));
 CloseFiles
end.

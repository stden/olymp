// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

uses Math;

const StreamIn='system.in';
      StreamOut='system.out';
      NMax=210;
      XMax=1000;
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
 for i:=0 to XMax do Val[i]:=Inf;
 Val[min(b[v],XMax)]:=0;
 for i:=1 to G[v,0] do begin
   t:=G[v,i];
   for j:=0 to XMax do New[j]:=Val[j];
   for j:=0 to XMax do
    if D[t,j]<>Inf then
     for k:=0 to XMax do
      if Val[k]<>Inf then New[min(XMax,k+j)]:=
      min(New[min(XMax,k+j)],Val[k]+D[t,j]);
   Val:=New
  end;
 for i:=0 to XMax do D[v,i]:=Inf;
 for i:=0 to XMax do
  if Val[i]<>Inf then begin
    if i>a[v] then D[v,i]:=min(D[v,i],Val[i]);
    D[v,i]:=min(D[v,i],Val[i]+w[v])
   end
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
 if a[1]<XMax then begin
   DFS(1);
   Ans:=inf;
   for i:=0 to XMax do Ans:=Min(Ans,D[1,i]);
   writeln(Ans)
  end
 else writeln(w[1]);
 CloseFiles
end.

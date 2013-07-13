// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='optimum.in';
      StreamOut='optimum.out';
type
 integer=longint;

var G:array [0..210,0..210] of integer;
    i,j,a,b,n,m,p:integer;
    Mark:array [0..210] of integer;
    Ok:boolean;

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
var i:integer;
begin
 Mark[v]:=1;
 for i:=1 to n do
  if (G[v,i]=1) and (Mark[i]=0) then DFS(i)
end;


begin
 OpenFiles;
 read(n,m,p);
 fillchar(G,sizeof(G),0);
 for i:=1 to m do begin
   read(a,b);
   G[a,b]:=1;
   G[b,a]:=1
  end;
 fillchar(Mark,sizeof(Mark),0);
 for i:=1 to n do
  if Mark[i]=0 then DFS(i);
 Ok:=True;
 for i:=1 to n do Ok:=Ok and (Mark[i]<>0);
 if not Ok then writeln(0)
 else
  if m=(n-1) then writeln('1')
  else writeln(m mod p);
 CloseFiles
end.

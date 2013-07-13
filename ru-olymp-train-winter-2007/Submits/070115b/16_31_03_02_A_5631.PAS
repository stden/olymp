// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='bridges.in';
      StreamOut='bridges.out';
      VMax=21000;
      EMax=210000;
      Change=50;
type
 IntList=array of integer;
var G,H:array [0..VMax] of Intlist;
    Va,Vb:array [0..EMax] of integer;
    Mark,S:array [0..VMax] of integer;
    Y:array [0..EMax] of boolean;
    n,m,i,Col:integer;


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

procedure Add(a,b:integer);
begin
 inc(G[a,0]);
 if G[a,0] mod Change=0 then
  setlength(G[a],G[a,0]+1);
 G[a,G[a,0]]:=b
end;

procedure Add1(a,b:integer);
begin
 inc(H[a,0]);
 if H[a,0] mod Change=0 then
  setlength(H[a],H[a,0]+1);
 H[a,H[a,0]]:=b
end;


procedure DFS(u:integer);
var i,v:integer;
begin
 Mark[u]:=1;
 inc(S[0]);
 S[S[0]]:=u;
 for i:=1 to G[u,0] do begin
   v:=Va[G[u,i]]+Vb[G[u,i]]-u;
   if not Y[G[u,i]] then begin
     Add1(v,G[u,i]);
     Y[G[u,i]]:=True
    end;
   if Mark[v]=0 then DFS(v)
  end
end;

procedure DFS1(u:integer);
var i,v:integer;
begin
 Mark[u]:=Col;
 for i:=1 to H[u,0] do begin
   v:=Va[H[u,i]]+Vb[H[u,i]]-u;
   if Mark[v]=0 then DFS1(v)
  end
end;

begin
 OpenFiles;
 read(n,m);
 for i:=1 to n do begin
   setlength(G[i],Change);
   G[i,0]:=0;
   setlength(H[i],Change);
   H[i,0]:=0
  end;
 for i:=1 to m do begin
   read(Va[i],Vb[i]);
   Add(Va[i],i);
   Add(Vb[i],i)
  end;
 fillchar(Mark,sizeof(Mark),0);
 fillchar(Y,sizeof(Y),False);
 S[0]:=0;
 for i:=1 to n do
  if Mark[i]=0 then DFS(i);
 fillchar(Mark,sizeof(Mark),0);
 Col:=0;
 for i:=1 to n do
  if Mark[S[i]]=0 then begin
    inc(Col);
    DFS1(S[i])
   end;
 Col:=0;
 for i:=1 to m do
  if Mark[Va[i]]<>Mark[Vb[i]] then inc(Col);
 writeln(Col);
 for i:=1 to m do
  if Mark[Va[i]]<>Mark[Vb[i]] then writeln(i);
 CloseFiles
end.

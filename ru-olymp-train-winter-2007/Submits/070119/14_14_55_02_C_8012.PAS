// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

uses Math;

const StreamIn='republic.in';
      StreamOut='republic.out';
      NMax=210000;
      Infinity=-1;
type
 integer=longint;
 IntVect=array [0..NMax] of integer;
 IntList=array of integer;
 Graph=array [0..NMax] of IntList;
var G,H,F,W:Graph;
    Va,Vb,List,Elem,q1,q2,Mark,Use,New,Deg1,Deg2,A,B,Sa,Sb:IntVect;
    n,m,ENum,Comp:integer;

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

procedure AddEdge(var G:Graph; Vert,Edge:integer);
begin
 inc(G[Vert,0]);
 if length(G[Vert])=G[Vert,0] then
  setlength(G[Vert],2*length(G[Vert]));
 G[Vert,G[Vert,0]]:=Edge
end;

procedure LoadGraph;
var i:integer;
begin
 read(n,m);
 for i:=1 to n do begin
   setlength(G[i],1);
   G[i,0]:=0;
   setlength(H[i],1);
   H[i,0]:=0
  end;
 for i:=1 to m do begin
   read(Va[i],Vb[i]);
   AddEdge(G,Va[i],i);
   AddEdge(H,Vb[i],i)
  end
end;

procedure Dfs1(Vert:integer);
var i,t:integer;
begin
 Mark[Vert]:=1;
 for i:=1 to G[Vert,0] do begin
   t:=Va[G[Vert,i]]+Vb[G[Vert,i]]-Vert;
   if Mark[t]=0 then Dfs1(t)
  end;
 inc(List[0]);
 List[List[0]]:=Vert
end;

procedure Dfs2(Vert:integer);
var i,t:integer;
begin
 Mark[Vert]:=Comp;
 for i:=1 to H[Vert,0] do begin
   t:=Va[H[Vert,i]]+Vb[H[Vert,i]]-Vert;
   if Mark[t]=0 then Dfs2(t)
  end
end;

procedure Dfs3(Vert:integer);
var i:integer;
begin
 Use[Vert]:=1;
 inc(New[0]);
 New[New[0]]:=Vert;
 for i:=1 to F[Vert,0] do
  if Use[F[Vert,i]]=0 then Dfs3(F[Vert,i]);
 for i:=1 to W[Vert,0] do
  if Use[W[Vert,i]]=0 then Dfs3(W[Vert,i])
end;


function Scc:integer;
var i:integer;
begin
 fillchar(Mark,sizeof(Mark),0);
 List[0]:=0;
 for i:=1 to n do
  if Mark[i]=0 then Dfs1(i);
 fillchar(Mark,sizeof(Mark),0);
 Result:=0;
 for i:=List[0] downto 1 do
  if Mark[List[i]]=0 then begin
    inc(Result);
    Dfs2(List[i])
   end
end;

procedure Solve;
var i,j,k,t,v1,v2,se,v:integer;
begin
 fillchar(Mark,sizeof(Mark),0);
 List[0]:=0;
 for i:=1 to n do
  if Mark[i]=0 then Dfs1(i);
 fillchar(Mark,sizeof(Mark),0);
 Comp:=0;
 for i:=List[0] downto 1 do
  if Mark[List[i]]=0 then begin
    inc(Comp);
    Dfs2(List[i])
   end;
 fillchar(Deg1,sizeof(Deg1),0);
 fillchar(Deg2,sizeof(Deg2),0);
 for i:=1 to Comp do begin
   setlength(F[i],1);
   F[i,0]:=0;
   setlength(W[i],1);
   W[i,0]:=0
  end;
 for i:=1 to n do begin
   for j:=1 to G[i,0] do begin
     t:=Va[G[i,j]]+Vb[G[i,j]]-i;
     if Mark[t]<>Mark[i] then begin
       inc(Deg1[Mark[i]]);
       inc(Deg2[Mark[t]]);
       AddEdge(F,Mark[i],Mark[t]);
       AddEdge(W,Mark[t],Mark[i]);
      end;
    end;
   Elem[Mark[i]]:=i
  end;
 fillchar(Use,sizeof(Use),0);
 k:=0;
 for i:=1 to Comp do
  if Use[i]=0 then begin
    New[0]:=0;
    Dfs3(i);
    inc(k);
    for j:=1 to New[0] do begin
      if Deg1[New[j]]=0 then A[k]:=New[j];
      if Deg2[New[j]]=0 then B[k]:=New[j]
     end
   end;
 ENum:=0;
 for i:=1 to k-1 do begin
   inc(ENum);
   Sa[ENum]:=Elem[A[i]];
   inc(Deg1[A[i]]);
   Sb[ENum]:=Elem[B[i+1]];
   inc(Deg2[B[i+1]])
  end;
 A[0]:=0;
 B[0]:=0;
 for i:=1 to Comp do begin
   if Deg1[i]=0 then begin
     inc(A[0]);
     A[A[0]]:=i
    end;
   if Deg2[i]=0 then begin
     inc(B[0]);
     B[B[0]]:=i
    end
  end;
 for i:=1 to n do begin
   q1[i]:=G[i,0];
   q2[i]:=H[i,0]
  end;
 se:=ENum;
 randomize;
 repeat
   for i:=1 to B[0] do begin
     v1:=random(B[0])+1;
     v2:=random(B[0])+1;
     k:=B[v1];
     B[v1]:=B[v2];
     B[v2]:=k
    end;
   for i:=1 to A[0] do begin
     inc(ENum);
     Sa[ENum]:=Elem[A[i]];
     Sb[ENum]:=Elem[B[Min(B[0],i)]]
    end;
   if B[0]>A[0] then
    for i:=A[0]+1 to B[0] do begin
      inc(ENum);
      Sa[ENum]:=Elem[A[1]];
      Sb[ENum]:=Elem[B[i]]
     end;
   for i:=1 to ENum do begin
     Va[m+i]:=Sa[i];
     Vb[m+i]:=Sb[i];
     AddEdge(G,Sa[i],m+i);
     AddEdge(H,Sb[i],m+i)
    end;
   v:=Scc;
   if v>1 then begin
     for i:=1 to n do begin
       G[i,0]:=q1[i];
       H[i,0]:=q2[i]
      end;
     ENum:=se
    end
 until v=1;
 writeln(ENum);
 for i:=1 to ENum do
  writeln(Sa[i],' ',Sb[i])
end;

begin
 OpenFiles;
 LoadGraph;
 Solve;
 CloseFiles
end.

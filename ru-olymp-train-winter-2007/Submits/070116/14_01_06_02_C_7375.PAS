// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O2+,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='input.txt';
      StreamOut='output.txt';
      Infinity=-1;
      NMax=110000;
type
 integer=longint;
 IntVect=array [0..NMax] of integer;

var Deg,Head,Last,Next,Key,List:IntVect;
    Edge1,Edge2:array [0..2*NMax] of integer;
    n,k,V5,m:integer;

const VMax=55000;
      EMax=110000;
      Change=100;

type
 IntList=array of integer;

var G,H:array [0..VMax] of Intlist;
    Va,Vb:array [0..EMax] of integer;
    Mark,S:array [0..VMax] of integer;
    Y:array [0..EMax] of boolean;
    i,Col:integer;

procedure Add0(a,b:integer);
begin
 inc(G[a,0]);
 if G[a,0] mod Change=0 then
  setlength(G[a],G[a,0]+Change);
 G[a,G[a,0]]:=b
end;

procedure Add1(a,b:integer);
begin
 inc(H[a,0]);
 if H[a,0] mod Change=0 then
  setlength(H[a],H[a,0]+Change);
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

function Check(n,m:integer):boolean;
begin
 for i:=1 to n do begin
   setlength(G[i],Change);
   G[i,0]:=0;
   setlength(H[i],Change);
   H[i,0]:=0
  end;
 for i:=1 to m do begin
   Va[i]:=Edge1[i];
   Vb[i]:=Edge2[i];
   Add0(Va[i],i);
   Add0(Vb[i],i)
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
 Result:=Col=1
end;


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
 inc(k);
 Key[k]:=b;
 Next[k]:=Infinity;
 if Head[a]=Infinity then Head[a]:=k
 else Next[Last[a]]:=k;
 Last[a]:=k
end;

procedure LoadTree;
var i,v1,v2:integer;
begin
 read(n);
 fillchar(Deg,sizeof(Deg),0);
 for i:=1 to n do Head[i]:=Infinity;
 k:=0;
 for i:=1 to n-1 do begin
   read(v1,v2);
   Add(v1,v2);
   Add(v2,v1);
   inc(Deg[v1]);
   inc(Deg[v2])
  end
end;

procedure DFS2(Vert,Prev:integer);
var i:integer;
begin
 i:=Head[Vert];
 while i<>Infinity do begin
   if Key[i]<>Prev then DFS2(Key[i],Vert);
   i:=Next[i]
  end;
 if Deg[Vert]=1 then begin
   inc(List[0]);
   List[List[0]]:=Vert
  end
end;

procedure GetPerm(var A:IntVect; n:integer);
var i,k,v1,v2:integer;
begin
 for i:=1 to n do begin
   v1:=random(n)+1;
   v2:=random(n)+1;
   k:=A[v1];
   A[v1]:=A[v2];
   A[v2]:=k
  end
end;

procedure Solve;
var i,j,mm:integer;
    Ok:boolean;
begin
 randomize;
 i:=1;
 while (i<=n) and (Deg[i]=1) do inc(i);
 if i>n then begin
   if n=1 then writeln(0)
   else begin
     writeln(1);
     writeln(1,' ',2)
    end
  end
 else begin
   List[0]:=0;
   DFS2(i,Infinity);
   repeat
    GetPerm(List,List[0]);
    Ok:=False;
    mm:=0;
    for i:=1 to List[0] do
     if (i mod 2=1) and ((i+1)<=List[0])
     then begin
       inc(mm);
       Edge1[mm]:=List[i];
       Edge2[mm]:=List[i+1]
      end;
    if List[0] mod 2=1 then begin
      inc(mm);
      Edge1[mm]:=List[1];
      Edge2[mm]:=List[List[0]]
     end;
    for i:=1 to n do begin
      j:=Head[i];
      while j<>-1 do begin
        if Key[j]>i then begin
          inc(mm);
          Edge1[mm]:=i;
          Edge2[mm]:=Key[j]
         end;
        j:=Next[j]
       end
     end;
    m:=mm;
    Ok:=Check(n,mm);
    if Ok then begin
      writeln((List[0]+1) div 2);
      for i:=1 to List[0] do
       if (i mod 2=1) and ((i+1)<=List[0])
       then writeln(List[i],' ',List[i+1]);
      if List[0] mod 2=1 then writeln(List[1],' ',List[List[0]])
     end
   until Ok
  end
end;

begin
 OpenFiles;
 LoadTree;
 Solve;
 CloseFiles
end.

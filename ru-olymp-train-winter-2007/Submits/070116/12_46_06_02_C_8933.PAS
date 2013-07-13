// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='biconn.in';
      StreamOut='biconn.out';
      Infinity=-1;
      NMax=110000;
type
 integer=longint;
 IntVect=array [0..NMax] of integer;
var Deg,Head,Last,Next,Key,List:IntVect;
    n,k:integer;

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

procedure DFS(Vert,Prev:integer);
var i:integer;
begin
 i:=Head[Vert];
 while i<>Infinity do begin
   if Key[i]<>Prev then DFS(Key[i],Vert);
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
var i:integer;
begin
 randseed:=746461177;
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
   DFS(i,Infinity);
   GetPerm(List,List[0]);
   writeln((List[0]+1) div 2);
   for i:=1 to List[0] do
    if (i mod 2=1) and ((i+1)<=List[0])
    then writeln(List[i],' ',List[i+1]);
   if List[0] mod 2=1 then writeln(List[1],' ',List[List[0]])
  end
end;

begin
 OpenFiles;
 LoadTree;
 Solve;
 CloseFiles
end.

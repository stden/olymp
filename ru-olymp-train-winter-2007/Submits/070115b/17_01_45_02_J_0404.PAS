// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='path.in';
      StreamOut='path.out';
      NMax=31000;
      MMax=410000;
      Change=50;
type
 IntList=array of integer;
var G:array [0..NMax] of IntList;
    Va,Vb,Ew:array [0..MMax] of integer;
    Val,Heap,Pos:array [0..NMax] of integer;
    n,i,j,v,u,m:integer;


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
  setlength(G[a],G[a,0]+Change);
 G[a,G[a,0]]:=b
end;

procedure Swap(var a,b:integer);
var q:integer;
begin
 q:=a;
 a:=b;
 b:=q
end;

procedure ModeA(a:integer);
begin
 if a>1 then
  if Val[Heap[a div 2]]>Val[Heap[a]] then begin
    Pos[Heap[a div 2]]:=a;
    Pos[Heap[a]]:=a div 2;
    Swap(Heap[a],Heap[a div 2]);
    ModeA(a div 2)
   end
end;

procedure ModeB(a:integer);
var v:integer;
begin
 v:=a;
 if (2*a<=Heap[0]) and (Val[Heap[2*a]]<Val[Heap[v]]) then v:=2*a;
 if ((2*a+1)<=Heap[0]) and (Val[Heap[2*a+1]]<Val[Heap[v]]) then v:=2*a+1;
 if a<>v then begin
   Pos[Heap[a]]:=v;
   Pos[Heap[v]]:=a;
   Swap(Heap[a],Heap[v]);
   ModeB(v)
  end
end;


procedure AddHeap(a:integer);
begin
 inc(Heap[0]);
 Heap[Heap[0]]:=a;
 Pos[a]:=Heap[0];
 ModeA(Heap[0])
end;

procedure DelHeap(a:integer);
begin
 Pos[Heap[Heap[0]]]:=a;
 Heap[a]:=Heap[Heap[0]];
 dec(Heap[0]);
 ModeA(a);
 ModeB(a)
end;

begin
 OpenFiles;
 read(n,m);
 for i:=1 to n do begin
   setlength(G[i],Change);
   G[i,0]:=0
  end;
 for i:=1 to m do begin
   read(Va[i],Vb[i],Ew[i]);
   Add(Va[i],i);
   Add(Vb[i],i)
  end;
 for i:=1 to n do Val[i]:=1000000000;
 Val[1]:=0;
 for i:=1 to n do AddHeap(i);
 for i:=1 to n do begin
   v:=Heap[1];
   DelHeap(1);
   for j:=1 to G[v,0] do begin
     u:=Va[G[v,j]]+Vb[G[v,j]]-v;
     if Val[u]>(Val[v]+Ew[G[v,j]])
     then Val[u]:=Val[v]+Ew[G[v,j]]
    end
  end;
 for i:=1 to n do write(Val[i],' ');
 CloseFiles
end.

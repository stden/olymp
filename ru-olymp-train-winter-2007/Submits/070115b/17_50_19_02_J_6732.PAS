// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,o2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='path.in';
      StreamOut='path.out';
      NMax=31000;
      MMax=410000;
      Change=10;
type
 integer=longint;
var G,last:array [0..NMax] of integer;
    Va,Vb,Ew:array [0..MMax] of integer;
    Next,Key:array [0..2*MMax] of integer;
    Val,Heap,Pos:array [0..NMax] of integer;
    n,k,i,j,v,u,m:integer;


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
 if G[a]<>-1 then Next[Last[a]]:=k
 else G[a]:=k;
 Last[a]:=k;
 Next[k]:=-1
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
 k:=0;
 for i:=1 to n do G[i]:=-1;
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
   j:=G[v];
   while j<>-1 do begin
     u:=Va[Key[j]]+Vb[Key[j]]-v;
     if Val[u]>(Val[v]+Ew[Key[j]])
     then begin
       DelHeap(Pos[u]);
       Val[u]:=Val[v]+Ew[Key[j]];
       AddHeap(u)
      end;
     j:=Next[j]
    end
  end;
 for i:=1 to n do write(Val[i],' ');
 CloseFiles
end.

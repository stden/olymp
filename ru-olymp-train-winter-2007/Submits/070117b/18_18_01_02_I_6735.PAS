// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='subseq.in';
      StreamOut='subseq.out';
      NMax=1210000;
      Infinity=-1;
type
 integer=longint;
 IntVect=array [0..NMax] of integer;
var RR,QQ,A,S,D,Prev,Val:IntVect;
    n,i,l,v,x,Max,El:integer;

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


procedure Sort(l,r:integer);
var i,j,q,k:integer;
begin
 i:=l; j:=r; q:=A[S[l+random(r-l+1)]];
 repeat
  while A[S[i]]<q do inc(i);
  while A[S[j]]>q do dec(j);
  if i<=j then begin
    k:=S[i];
    S[i]:=S[j];
    S[j]:=k;
    inc(i); dec(j)
   end
 until i>j;
 if i<r then Sort(i,r);
 if l<j then Sort(l,j)
end;

procedure Built(v,l,r:integer);
begin
 if l=r then begin
   RR[v]:=Infinity;
   QQ[v]:=v
  end
 else begin
   Built(2*v,l,(l+r) div 2);
   Built(2*v+1,(l+r) div 2+1,r);
   RR[v]:=Infinity;
   QQ[v]:=2*v
  end
end;


procedure Best(v,l,r,i,j:integer);
begin
 if (l<=j) and (r>=i) then
  if (i<=l) and (r<=j) then begin
    if Max<RR[v] then begin
      Max:=RR[v];
      El:=QQ[v]
     end
   end
  else begin
    Best(2*v,l,(l+r) div 2,i,j);
    Best(2*v+1,(l+r) div 2+1,r,i,j)
   end
end;


procedure Add(v,l,r,i,j:integer);
begin
 if (l>i) or (r<i) then Exit;
 if (l=r) and (l=i) then begin
   if RR[v]<(Max+1) then begin
     RR[v]:=Max+1;
     QQ[v]:=j
    end
  end
 else begin
   Add(2*v,l,(l+r) div 2,i,j);
   Add(2*v+1,(l+r) div 2+1,r,i,j);
   if RR[v]<RR[2*v] then begin
     RR[v]:=RR[2*v];
     QQ[v]:=QQ[2*v]
    end;
   if RR[v]<RR[2*v+1] then begin
     RR[v]:=RR[2*v+1];
     QQ[v]:=QQ[2*v+1]
    end
  end
end;

procedure Save(v:integer);
begin
 if Prev[v]<>Infinity then Save(Prev[v]);
 writeln(v)
end;

begin
 OpenFiles;
 read(n);
 for i:=1 to n do begin
   read(A[i]);
   S[i]:=i
  end;
 randomize;
 Sort(1,n);
 for i:=1 to n do D[i]:=Infinity;
 Built(1,1,n);
 for i:=1 to n do begin
   l:=0; v:=n;
   while (l+1)<v do begin
     x:=(l+v) div 2;
     if A[S[x]]<A[i] then l:=x else v:=x
    end;
   El:=Infinity;
   Max:=Infinity;
   Best(1,1,n,v,n);
   if Max=Infinity then begin
     Max:=0;
     Prev[i]:=Infinity;
     Val[i]:=1
    end
   else begin
     Prev[i]:=El;
     Val[i]:=Max+1;
    end;
   Add(1,1,n,v,i)
  end;
 El:=1;
 Max:=Val[1];
 for i:=1 to n do
  if Val[i]>Max then begin
    Max:=Val[i];
    El:=i
   end;
 writeln(Val[El]);
 Save(El);
 CloseFiles
end.

// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

uses Math;

const StreamIn='partitions.in';
      StreamOut='partitions.out';
      NMax=210;
      Inf=-1;
type
 integer=longint;
 IntSet=array [0..NMax] of integer;
 IntSetOfSet=array [0..NMax] of IntSet;
var G,F:IntSetOfSet;
    S,V,R:IntSet;
    i,j,t,n,k,nk:integer;

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

function Union(A,B:IntSet):IntSet;
var l,r:integer;
begin
 Result[0]:=0;
 l:=1; r:=1;
 while (l<=A[0]) or (r<=B[0]) do begin
   inc(Result[0]);
   if (l>A[0]) or ((r<=B[0]) and (A[l]>B[r])) then begin
     Result[Result[0]]:=B[r];
     inc(r)
    end
   else begin
     Result[Result[0]]:=A[l];
     inc(l)
    end
  end
end;

function Next(A,B:IntSet):IntSet;
var i,j:integer;
begin
 Result[0]:=0;
 if (B[0]>0) and (B[B[0]]>A[A[0]]) then begin
   while (B[0]>1) and (B[B[0]-1]>A[i]) do dec(B[0]);
   Result:=A;
   inc(Result[0]);
   Result[Result[0]]:=B[B[0]];
   Exit
  end;
 for i:=A[0] downto 1 do
  if (B[0]>0) and (B[B[0]]>A[i])
  then begin
    while (B[0]>1) and (B[B[0]-1]>A[i]) do dec(B[0]);
    for j:=1 to i-1 do Result[j]:=A[j];
    Result[i]:=B[B[0]];
    Result[0]:=i;
    Exit
   end
  else begin
    inc(B[0]);
    B[B[0]]:=A[i]
   end
end;

procedure Save(Q:IntSet);
begin
 inc(nk);
 F[nk]:=Q
end;

begin
 OpenFiles;
 while True do begin
   readln(n,k);
   if n=0 then Break;
   for i:=1 to k do begin
     G[i,0]:=0;
     while not eoln do begin
       inc(G[i,0]);
       read(G[i,G[i,0]])
      end;
     readln
    end;
   nk:=0;
   S[0]:=0;
   for i:=k downto 1 do begin
     V:=Next(G[i],S);
     S:=Union(S,G[i]);
     if V[0]>0 then
      if V[1]=S[1] then begin
        for j:=1 to i-1 do Save(G[j]);
        Save(V);
        t:=1;
        for i:=1 to S[0] do begin
          while (t<=V[0]) and (V[t]<S[i]) do inc(t);
          if (t>V[0]) or (V[t]>S[i]) then begin
            R[0]:=1;
            R[1]:=S[i];
            Save(R)
           end
         end;
        Break
       end
    end;
   if nk=0 then begin
     writeln(n,' ',n);
     for i:=1 to n do writeln(i)
    end
   else begin
     writeln(n,' ',nk);
     for i:=1 to nk do begin
       for j:=1 to F[i,0] do write(F[i,j],' ');
       writeln
      end
    end;
   writeln
  end;
 CloseFiles
end.

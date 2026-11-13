// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='map.in';
      StreamOut='map.out';
      NMax=250;
      Infinity=-1;
type
 integer=longint;
 IntVect=array [0..NMax] of integer;
 BoolVect=array [0..NMax] of boolean;
 Tree=array [0..NMax] of BoolVect;
 Graph=array [0..NMax] of IntVect;
var A,B,C,D:Tree;
    G:Graph;
    Mate,Count1,Count2,Depth1,Depth2,PrevAt,Ans:IntVect;
    Mark:BoolVect;
    n,m:integer;

function Max(const a,b:integer):integer;
begin
 if a>b then Result:=a
 else Result:=b
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

procedure LoadTree(var A:Tree; var n:integer);
var v1,v2,i:integer;
begin
 read(n);
 fillchar(A,sizeof(A),False);
 for i:=1 to n-1 do begin
   read(v1,v2);
   A[v1,v2]:=True;
   A[v2,v1]:=True
  end
end;

procedure Calc(Vert,Prev,n:integer; const A:Tree; var Count,Depth:IntVect);
var i:integer;
begin
 Count[Vert]:=1;
 Depth[Vert]:=0;
 for i:=1 to n do
  if (i<>Prev) and A[Vert,i] then begin
    Calc(i,Vert,n,A,Count,Depth);
    inc(Count[Vert],Count[i]);
    Depth[Vert]:=Max(Depth[Vert],Depth[i]+1)
   end;
end;

procedure Orient(Vert,Prev:integer);
var i:integer;
begin
 for i:=1 to m do
  if (i<>Prev) and A[Vert,i] then begin
    Orient(i,Vert);
    C[Vert,i]:=True
   end
end;

function MateDFS(Vert:integer):boolean;
var i:integer;
begin
 Result:=False;
 if not Mark[Vert] then begin
   Mark[Vert]:=True;
   for i:=1 to n do
    if G[Vert,i]=1 then
     if Mate[i]=0 then begin
       Mate[i]:=Vert;
       G[Vert,i]:=2;
       Result:=True;
       Exit
      end
     else
      if MateDFS(Mate[i]) then begin
        G[Mate[i],i]:=1;
        Mate[i]:=Vert;
        G[Vert,i]:=1;
        Result:=True;
        Exit
       end
  end
end;

procedure Estimate(Vert,Prev:integer);
var i,j,k:integer;
    Ok:boolean;
begin
 PrevAt[Vert]:=Prev;
 for i:=1 to n do
  if (i<>Prev) and B[Vert,i] then Estimate(i,Vert);
 for j:=1 to m do
  if (Depth2[j]<=Depth1[Vert]) and (Count2[j]<=Count1[Vert])
  then begin
    fillchar(G,sizeof(G),0);
    for i:=1 to n do
     if (i<>Prev) and B[Vert,i] then
      for k:=1 to m do
       if C[j,k] then
        if D[i,k] then G[k,i]:=1;
    fillchar(Mate,sizeof(Mate),0);
    Ok:=True;
    for i:=1 to m do
     if C[j,i] then begin
       fillchar(Mark,sizeof(Mark),False);
       if not MateDFS(i) then begin
         Ok:=False;
         Break
        end
      end;
    D[Vert,j]:=Ok
   end
end;

procedure Save(Vert,Prev,Root:integer);
var i,k:integer;
    Go:IntVect;
begin
 Ans[Root]:=Vert;
 fillchar(G,sizeof(G),0);
 for i:=1 to n do
  if (i<>Prev) and B[Vert,i] then
   for k:=1 to m do
    if C[Root,k] then
     if D[i,k] then G[k,i]:=1;
 fillchar(Mate,sizeof(Mate),0);
 for i:=1 to m do
  if C[Root,i] then begin
    fillchar(Mark,sizeof(Mark),False);
    MateDFS(i)
   end;
 Go:=Mate;
 for i:=1 to n do
  if Go[i]<>0 then Save(i,Vert,Go[i])
end;


procedure Solve;
var i,j,k:integer;
begin
 Calc(1,Infinity,n,B,Count1,Depth1);
 for i:=1 to m do begin
   fillchar(C,sizeof(C),False);
   Orient(i,Infinity);
   Calc(i,Infinity,m,A,Count2,Depth2);
   fillchar(D,sizeof(D),False);
   Estimate(1,Infinity);
   for j:=1 to n do
    if D[j,i] then begin
      writeln('YES');
      Save(j,PrevAt[j],i);
      for k:=1 to m do write(Ans[k],' ');
      Exit
     end
  end;
 writeln('NO')
end;

begin
 OpenFiles;
 LoadTree(A,m);
 LoadTree(B,n);
 if n>NMax then writeln('NO')
 else Solve;
 CloseFiles
end.

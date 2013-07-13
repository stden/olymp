// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='restore.in';
      StreamOut='restore.out';
      NMax=55;
      Infinity=-1;
type
 integer=longint;
 IntVect=array [0..NMax] of integer;
 IntMtrx=array [0..NMax] of IntVect;
var G,R,F:IntMtrx;
    A,B,Dist,Queue,Mark,Val,NewVal,List:IntVect;
    n,p,SVert,NRec,Ql,Qr:integer;

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

procedure LoadData;
var i,m,v1,v2:integer;
begin
 read(n,m,p);
 fillchar(G,sizeof(G),0);
 for i:=1 to m do begin
   read(v1,v2);
   G[v1,v2]:=1;
   G[v2,v1]:=1
  end;
 read(SVert);
 read(NRec);
 for i:=1 to NRec do
  read(A[i],B[i])
end;

procedure AddQueue(const Vert:integer);
begin
 Queue[Qr]:=Vert;
 inc(Qr)
end;

procedure TakeQueue(var Vert:integer);
begin
 Vert:=Queue[Ql];
 inc(Ql)
end;

function Mul(A,B:IntMtrx):IntMtrx;
var i,j,k:integer;
begin
 fillchar(Result,sizeof(Result),0);
 for i:=1 to List[0] do
  for j:=1 to List[0] do
   for k:=1 to List[0] do
    Result[i,j]:=(int64(Result[i,j])+int64(A[i,k])*int64(B[k,j])) mod p
end;

procedure Solve;
var i,j,k,v,t,Vert,Ans:integer;
begin
 Ql:=1;
 Qr:=1;
 for i:=1 to n do Dist[i]:=Infinity;
 Dist[SVert]:=0;
 AddQueue(SVert);
 while Ql<Qr do begin
   TakeQueue(Vert);
   for i:=1 to n do
    if (G[Vert,i]<>0) and (Dist[i]=Infinity)
    then begin
      Dist[i]:=Dist[Vert]+1;
      AddQueue(i)
     end
  end;
 for i:=1 to n do
  if Dist[i]=A[1] then Val[i]:=1 else Val[i]:=0;
 for i:=1 to NRec do begin
   fillchar(Mark,sizeof(Mark),0);
   fillchar(NewVal,sizeof(NewVal),0);
   for j:=1 to n do
    if (Mark[j]=0) and (Dist[j]=A[i]) then begin
      List[0]:=1;
      List[1]:=j;
      Ql:=1;
      Qr:=1;
      Mark[j]:=1;
      AddQueue(j);
      while Ql<Qr do begin
        TakeQueue(Vert);
        for k:=1 to n do
         if (G[Vert,k]<>0) and (Mark[k]=0) and (Dist[k]=A[i])
         then begin
           inc(List[0]);
           List[List[0]]:=k;
           Mark[k]:=1;
           AddQueue(k)
          end
       end;
      if B[i]>1 then begin
        fillchar(R,sizeof(R),0);
        for k:=1 to List[0] do
         for v:=1 to List[0] do R[k,v]:=G[List[k],List[v]];
        fillchar(F,sizeof(F),0);
        for k:=1 to List[0] do F[k,k]:=1;
        t:=B[i]-1;
        while t>0 do begin
          if t mod 2=1 then F:=Mul(F,R);
          R:=Mul(R,R);
          t:=t div 2
         end;
        for k:=1 to List[0] do
         for v:=1 to List[0] do begin
           t:=(int64(Val[List[k]])*int64(F[k,v])) mod p;
           NewVal[List[v]]:=(int64(NewVal[List[v]])+t) mod p
          end
       end
      else
       for k:=1 to List[0] do
        NewVal[List[k]]:=(NewVal[List[k]]+Val[List[k]]) mod p
     end;
   Val:=NewVal;
   if i<NRec then begin
     fillchar(NewVal,sizeof(NewVal),0);
     for j:=1 to n do
      for k:=1 to n do
       if (G[j,k]<>0) and (Dist[k]=A[i+1])
       then NewVal[k]:=(NewVal[k]+Val[j]) mod p;
     Val:=NewVal
    end
  end;
 Ans:=0;
 for i:=1 to n do Ans:=(Ans+Val[i]) mod p;
 writeln(Ans)
end;


begin
 OpenFiles;
 LoadData;
 Solve;
 CloseFiles
end.

// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='pairs.in';
      StreamOut='pairs.out';
      VMax=2100;
      EMax=25000;
type
 integer=longint;
 Edge=record
   Vx,Vy,Flow,Capac,Rever:integer
  end;
 EdgeSet=array [0..EMax] of Edge;
 EdgeMark=array [0..EMax] of integer;
 IntList=array of integer;
 IntVect=array [0..VMax] of integer;
 Graph=array [0..VMax] of IntList;
var G:Graph;
    E:EdgeSet;
    Va,Vb:EdgeMark;
    Deg,EdgeS,EdgeT,Mark,Queue:IntVect;
    m,ENum,VertS,VertT,Ql,Qr,Mate:integer;

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

procedure AddEdge(X,Y,ECapac,ERever:integer);
begin
 inc(ENum);
 with E[ENum] do begin
   Vx:=X;
   Vy:=Y;
   Capac:=ECapac;
   Rever:=ERever;
   Flow:=0
  end;
 inc(G[X,0]);
 G[X,G[X,0]]:=ENum
end;

procedure LoadGraph;
var i,n1,n2:integer;
begin
 read(n1,n2,m);
 fillchar(Deg,sizeof(Deg),0);
 for i:=1 to m do begin
   read(Va[i],Vb[i]);
   inc(Deg[Va[i]]);
   inc(Deg[n1+Vb[i]])
  end;
 VertS:=n1+n2+1;
 VertT:=n1+n2+2;
 for i:=1 to n1+n2 do begin
   setlength(G[i],2*Deg[i]+3);
   G[i,0]:=0
  end;
 setlength(G[VertS],2*n1+1);
 G[VertS,0]:=0;
 setlength(G[VertT],2*n2+1);
 G[VertT,0]:=0;
 ENum:=0;
 for i:=1 to m do begin
   AddEdge(Va[i],n1+Vb[i],1,ENum+2);
   AddEdge(n1+Vb[i],Va[i],0,ENum)
  end;
 for i:=1 to n1 do begin
   AddEdge(VertS,i,1,ENum+2);
   EdgeS[i]:=ENum;
   AddEdge(i,VertS,0,ENum)
  end;
 for i:=n1+1 to n1+n2 do begin
   AddEdge(i,VertT,1,ENum+2);
   EdgeT[i]:=ENum;
   AddEdge(VertT,i,0,ENum)
  end
end;

procedure AddQueue(Vert:integer);
begin
 Queue[Qr]:=Vert;
 inc(Qr)
end;

procedure TakeQueue(var Vert:integer);
begin
 Vert:=Queue[Ql];
 inc(Ql)
end;

function BFS(Bad1,Bad2:integer):boolean;
var t,i,Vert:integer;
begin
 fillchar(Mark,sizeof(Mark),0);
 Ql:=1;
 Qr:=1;
 Mark[VertS]:=1;
 AddQueue(VertS);
 while (Ql<Qr) and (Mark[VertT]=0) do begin
   TakeQueue(Vert);
   for i:=1 to G[Vert,0] do begin
     t:=G[Vert,i];
     if (Mark[E[t].Vy]=0) and
        (t<>Bad1) and (E[t].Rever<>Bad1) and
        (t<>Bad2) and (E[t].Rever<>Bad2)
     then
      if (E[t].Capac-E[t].Flow)>0 then begin
        Mark[E[t].Vy]:=t;
        AddQueue(E[t].Vy)
       end
    end
  end;
 Result:=False;
 if Mark[VertT]<>0 then begin
   Result:=True;
   Vert:=VertT;
   while Vert<>VertS do begin
     inc(E[Mark[Vert]].Flow);
     E[E[Mark[Vert]].Rever].Flow:=-E[Mark[Vert]].Flow;
     Vert:=E[Mark[Vert]].Vx
    end
  end;
end;

procedure Solve;
var i,j,t,Ans:integer;
    Ok:boolean;
begin
 Mate:=0;
 while BFS(0,0) do inc(Mate);
 Ans:=0;
 for i:=1 to ENum do
  if (E[i].Capac=1) and (E[i].Vx<>VertS) and (E[i].Vy<>VertT) then begin
    t:=Mate;
    if E[i].Flow>0 then begin
      Ok:=True;
      E[EdgeS[E[i].Vx]].Flow:=0;
      E[E[EdgeS[E[i].Vx]].Rever].Flow:=0;
      E[EdgeT[E[i].Vy]].Flow:=0;
      E[E[EdgeT[E[i].Vy]].Rever].Flow:=0;
      dec(t)
     end
    else Ok:=False;
    E[i].Flow:=0;
    E[E[i].Rever].Flow:=0;
    for j:=i+1 to ENum do
     if (E[j].Capac=1) and (E[j].Vx<>VertS) and (E[j].Vy<>VertT) then
      if Ok or (E[j].Flow>0) then begin
        if E[j].Flow>0 then begin
          E[EdgeS[E[j].Vx]].Flow:=0;
          E[E[EdgeS[E[j].Vx]].Rever].Flow:=0;
          E[EdgeT[E[j].Vy]].Flow:=0;
          E[E[EdgeT[E[j].Vy]].Rever].Flow:=0;
          dec(t)
         end;
        E[j].Flow:=0;
        E[E[j].Rever].Flow:=0;
        if BFS(i,j) then begin
          inc(t);
          if BFS(i,j) then inc(t)
         end;
        if t<Mate then begin
          inc(Ans);
          if BFS(i,0) then inc(t)
         end
       end;
   if BFS(0,0) then inc(t)
  end;
 writeln(Ans)
end;

begin
 OpenFiles;
 LoadGraph;
 Solve;
 CloseFiles
end.

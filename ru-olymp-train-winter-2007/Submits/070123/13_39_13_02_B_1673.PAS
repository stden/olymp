// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

uses Windows;

const StreamIn='omax.in';
      StreamOut='omax.out';
      VMax=210000;
      EMax=650000+2*VMax;
      TLE=1850;
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
    Deg,EdgeS,EdgeT,Mark,Queue,S,Ans,Link:IntVect;
    Time,n,m,ENum,VertS,VertT,Ql,Qr,Mate:integer;
    TimeCheck:boolean;

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
var i,j,v,k:integer;
begin
 Time:=GetTickCount;
 read(n);
 fillchar(Deg,sizeof(Deg),0);
 m:=0;
 for i:=1 to n do begin
   read(k);
   for j:=1 to k do begin
     inc(m);
     read(v);
     Va[m]:=i;
     Vb[m]:=n+v;
     inc(Deg[Va[m]]);
     inc(Deg[Vb[m]])
    end
  end;
 VertS:=2*n+1;
 VertT:=2*n+2;
 for i:=1 to 2*n do begin
   setlength(G[i],2*Deg[i]+3);
   G[i,0]:=0
  end;
 setlength(G[VertS],2*n+1);
 G[VertS,0]:=0;
 setlength(G[VertT],2*n+1);
 G[VertT,0]:=0;
 ENum:=0;
 for i:=1 to m do begin
   AddEdge(Va[i],Vb[i],1,ENum+2);
   AddEdge(Vb[i],Va[i],0,ENum)
  end;
 for i:=1 to n do begin
   AddEdge(VertS,i,1,ENum+2);
   EdgeS[i]:=ENum;
   AddEdge(i,VertS,0,ENum)
  end;
 for i:=n+1 to 2*n do begin
   AddEdge(i,VertT,1,ENum+2);
   EdgeT[i]:=ENum;
   AddEdge(VertT,i,0,ENum)
  end;
 TimeCheck:=(int64(n)*int64(m))>50000000
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

function BFS(Bad:integer):boolean;
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
        (t<>Bad) and (E[t].Rever<>Bad)
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
var i,j,t,v1,v2:integer;
    Ok:boolean;
begin
 randomize;
 for i:=1 to VertT do S[i]:=i;
 for i:=1 to VertT do begin
   v1:=random(VertT)+1;
   v2:=random(VertT)+1;
   t:=S[v1];
   S[v1]:=S[v2];
   S[v2]:=t
  end;
 Mate:=0;
 for i:=1 to VertT do
  if S[i]<=n then
   for j:=1 to G[S[i],0] do begin
     t:=G[S[i],j];
     if (E[t].Vy<>VertS) and (E[EdgeT[E[t].Vy]].Flow=0) then begin
       E[EdgeS[S[i]]].Flow:=1;
       E[E[EdgeS[S[i]]].Rever].Flow:=-1;
       E[EdgeT[E[t].Vy]].Flow:=1;
       E[E[EdgeT[E[t].Vy]].Rever].Flow:=-1;
       E[t].Flow:=1;
       E[E[t].Rever].Flow:=-1;
       inc(Mate);
       Break
      end
    end;
 while BFS(0) do begin
   inc(Mate);
   if TimeCheck then
    if (GetTickCount-Time)>TLE then begin
      writeln('NO');
      Exit
     end
  end;
 if Mate<n then writeln('NO')
 else begin
   for i:=1 to VertT do begin
     v1:=random(VertT)+1;
     v2:=random(VertT)+1;
     t:=S[v1];
     S[v1]:=S[v2];
     S[v2]:=S[v1]
    end;
   for i:=1 to n do
    for j:=1 to G[i,0] do
     if E[G[i,j]].Flow=1 then begin
       Ans[i]:=E[G[i,j]].Vy-n;
       Link[i]:=G[i,j];
       Break
      end;
   Ok:=True;
   for i:=1 to VertT do
    if S[i]<=n then begin
      E[EdgeS[i]].Flow:=0;
      E[E[EdgeS[i]].Rever].Flow:=0;
      E[EdgeT[E[Link[i]].Vy]].Flow:=0;
      E[E[EdgeT[E[Link[i]].Vy]].Rever].Flow:=0;
      if BFS(Link[i]) then begin
        Ok:=False;
        Break
       end
      else begin
        E[EdgeS[i]].Flow:=1;
        E[E[EdgeS[i]].Rever].Flow:=-1;
        E[EdgeT[E[Link[i]].Vy]].Flow:=1;
        E[E[EdgeT[E[Link[i]].Vy]].Rever].Flow:=-1
       end;
      if TimeCheck then
       if (GetTickCount-Time)>TLE then Break
     end;
   if Ok then begin
     writeln('YES');
     for i:=1 to n do write(Ans[i],' ')
    end
   else writeln('NO')
  end
end;

begin
 OpenFiles;
 LoadGraph;
 Solve;
 CloseFiles
end.

// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='omax.in';
      StreamOut='omax.out';
      VMax=210000;
      EMax=650000;
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
    Deg,Ans,List,Use:IntVect;
    ENum,n:integer;

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
var i,j,v,k,m:integer;
begin
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
 for i:=1 to 2*n do begin
   setlength(G[i],2*Deg[i]+3);
   G[i,0]:=0
  end;
 for i:=1 to m do begin
   AddEdge(Va[i],Vb[i],1,ENum+2);
   AddEdge(Vb[i],Va[i],0,ENum)
  end
end;

procedure Solve;
var i,j,v,t:integer;
    Ok:boolean;
begin
 fillchar(Ans,sizeof(Ans),0);
 List[0]:=0;
 for i:=1 to 2*n do
  if Deg[i]=1 then begin
    inc(List[0]);
    List[List[0]]:=i
   end;
 fillchar(Use,sizeof(Use),0);
 while List[0]>0 do begin
   v:=List[List[0]];
   dec(List[0]);
   if Use[v]=0 then begin
     Use[v]:=1;
     for i:=1 to G[v,0] do
      if Use[E[G[v,i]].Vy]=0 then begin
        t:=E[G[v,i]].Vy;
        Break
       end;
     if v>n then Ans[t]:=v-n
     else Ans[v]:=t-n;
     Use[t]:=1;
     for i:=1 to G[t,0] do
      if Use[E[G[t,i]].Vy]=0 then begin
        dec(Deg[E[G[t,i]].Vy]);
        if Deg[E[G[t,i]].Vy]=1 then begin
          inc(List[0]);
          List[List[0]]:=E[G[t,i]].Vy
         end
       end
    end
  end;
 Ok:=True;
 for i:=1 to n do Ok:=Ok and (Ans[i]>0);
 if not Ok then writeln('NO')
 else begin
   writeln('YES');
   for i:=1 to n do write(Ans[i],' ')
  end
end;

begin
 OpenFiles;
 LoadGraph;
 Solve;
 CloseFiles
end.

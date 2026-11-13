Uses treeunit;

Type Integer=LongInt;
     TVertex=record
      num,en:Integer;
      its:Boolean;
     end;
Var g:Array[1..200000,1..5]of TVertex;
    c:Array[1..200000]of Integer;
    ans,max,tec,tuse,n,v1,v2,i,j,x,tv:Integer;
    fl:Boolean;
    use:Array[1..200000]of Integer;
Procedure DFS1(v:Integer);
Var i:Integer;
Begin
  use[v]:=tuse;
  if tec>max then max:=tec;
  for i:=1 to c[v] do if use[g[v,i].en]<>tuse then begin
    Inc(tec);DFS1(g[v,i].en);
    Dec(tec);
  end;
End;
Procedure DFS2(v:Integer);
Begin
  use[v]:=tuse;
  if tec=max then begin
    ans:=v;exit;
  end;
  for i:=1 to c[v] do if use[g[v,i].en]<>tuse then begin
    Inc(tec);DFS2(g[v,i].en);if ans<>0 then exit;
    Dec(tec);
  end;
End;

Function shaman(v:Integer):Integer;
Begin
  max:=-1;Inc(tuse);
  tec:=0;DFS1(v);max:=max div 2;
  tec:=0;ans:=0;
  Inc(tuse);DFS2(v);
  shaman:=ans;
End;

Begin

  Assign(output,'output.txt');
  ReWrite(output);
  Init;tuse:=0;
  n:=GetN;
  randomize;
  for i:=1 to n-1 do begin
    v1:=getA(i);v2:=getB(i);
    Inc(c[v1]);Inc(c[v2]);
    g[v1,c[v1]].en:=v2;
    g[v1,c[v1]].its:=true;
    g[v1,c[v1]].num:=i;
    g[v2,c[v2]].en:=v1;
    g[v2,c[v2]].its:=false;
    g[v2,c[v2]].num:=i;
  end;
  tv:=random(n)+1;
  while true do
    while c[tv]>0 do begin
      fl:=query(g[tv,c[tv]].num)=0;
      if (fl xor g[tv,c[tv]].its) then begin
        x:=g[tv,c[tv]].en;
        for i:=1 to c[x] do if g[x,i].en=tv then j:=i;
        for i:=j to c[x]-1 do g[x,i]:=g[x,i+1];
        Dec(c[x]);tv:=shaman(x);break;
      end else Dec(c[tv]);
      if c[tv]=0 then report(tv);
    end;
End.
{$H+,$I+,$Q+,$R+}
Const inf=1000000000;
Type integer=longint;
     TCheck=array[0..7]of Integer;

Var g:Array[1..50,1..50]of Integer;
    price,disc:Array[1..50,0..7] of Integer;
    nCurIt,mx,my,nmin,v1,v2,x,y,i,j,n,m,k,st:Integer;
    it:Array[1..50]of Integer;
    d:Array[1..50,0..128] of Integer;
    use:Array[1..50,0..128]of Boolean;
    need:Integer;
    CurIt:Array[0..7] of Integer;
    take:Array[0..7]of Boolean;
    check:TCheck;
    cost,sp:Array[0..128]of Integer;

Function min(a,b:Integer):Integer;
Begin
  if a<b then min:=a else min:=b;
End;

Procedure swap(var a,b:Integer);
Var c:Integer;
Begin
  c:=a;a:=b;b:=c;
End;

Function opt(var c:TCheck;v:Integer):Integer;
Var i,j,l,r,tec,tdisc,rez:Integer;
Begin
  rez:=inf;
  if c[0]=0 then begin
    opt:=0;exit;
  end;
  while true do begin
    tec:=0;tdisc:=100;
    for i:=1 to c[0] do begin
      Inc(tec,price[v,c[i]]*tdisc);
      Dec(tdisc,disc[v,c[i]]);
    end;
    if tec<rez then rez:=tec;

    i:=c[0];
    while (i>1) and (c[i]<c[i-1]) do Dec(i);
    if i=1 then break;
    for j:=c[0] downto i do if c[j]>c[i-1] then begin
      Swap(c[j],c[i-1]);break;
    end;
    l:=i;r:=c[0];
    while l<r do begin
      Swap(c[l],c[r]);Inc(l);Dec(r);
    end;
  end;

  opt:=rez;
End;

Begin
  Assign(input,'armor.in');
  Assign(output,'armor.out');
  Reset(input);ReWrite(output);
  ReadLn(n,m,k,st);
	fillchar(it,sizeof(it),0);
	for i:=1 to n do
    for j:=0 to k-1 do begin
      Read(x,y);x:=x div 100;
      if x<>0 then begin
        it[i]:=it[i] or (1 shl j);
        price[i,j]:=x;
        disc[i,j]:=y;
      end;
    end;

  for i:=1 to n do
    for j:=1 to n do if i<>j then g[i,j]:=inf else g[i,j]:=0;
  for i:=1 to m do begin
    Read(v1,v2,x);
    g[v1,v2]:=min(g[v1,v2],x);
    g[v2,v1]:=g[v1,v2];
  end;
  for i:=1 to n do
    for j:=0 to (1 shl k)-1 do d[i,j]:=inf;
  fillchar(use,sizeof(use),false);
  d[st,0]:=0;

  while true do begin
    nmin:=inf;mx:=-1;my:=-1;
    for i:=1 to n do
      for j:=0 to (1 shl k)-1 do
        if (not use[i,j]) and (d[i,j]<nmin) then begin
          nmin:=d[i,j];mx:=i;my:=j;
        end;
    if mx=-1 then break;
    if (mx=st) and (my=(1 shl k)-1) then begin
      Write(nmin);halt;
    end;
    need:=(not my) and (it[mx]);

    nCurIt:=0;
		fillchar(sp,sizeof(sp),0);
		for i:=0 to k-1 do
      if (need and (1 shl i))<>0 then begin
        Inc(nCurIt);
        CurIt[nCurIt]:=i;
      end;
    fillchar(take,sizeof(take),false);
    while true do begin
      check[0]:=0;Inc(sp[0]);
      for i:=1 to nCurIt do if take[i] then begin
        Inc(check[0]);check[check[0]]:=CurIt[i];
        sp[sp[0]]:=sp[sp[0]] or (1 shl curit[i]);
      end;
      cost[sp[0]]:=opt(check,mx);

      i:=nCurIt;
      while (i>0) and (take[i]) do Dec(i);
      if i=0 then break;
      for j:=i to nCurIt do take[j]:=not take[j];
    end;

    for i:=1 to n do if g[mx,i]<>inf then
      for j:=1 to sp[0] do begin
        x:=g[mx,i]+nmin+cost[j];
        if d[i,my or sp[j]]>x then d[i,my or sp[j]]:=x;
      end;
    use[mx,my]:=true;
  end;
  Write(-1);
End.
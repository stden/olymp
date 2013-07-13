var n,i,cb,cw,j,o:longint;
    xb,yb,nb,xw,yw,nw,x,y:array[1..300000]of longint;
    ans:array[1..300000]of record
                             a,b,c:longint;
                           end;

procedure addtri(a,b,c:longint);
begin
  inc(o);
  ans[o].a:=a;
  ans[o].b:=b;
  ans[o].c:=c;
end;

function vect(x1,y1,x2,y2:int64):longint;
begin
  vect:=0;
  if x1*y2-x2*y1>0 then
    vect:=1;
  if x1*y2-x2*y1<0 then
    vect:=-1;
end;

function cross(x1,y1,x2,y2,x3,y3,x4,y4:longint):boolean;
var v1,v2,v3,v4:longint;
begin
  v1:=vect(x3-x1,y3-y1,x3-x2,y3-y2);
  v2:=vect(x4-x1,y4-y1,x4-x2,y4-y2);
  v3:=vect(x1-x3,y1-y3,x1-x4,y1-y4);
  v4:=vect(x2-x3,y2-y3,x2-x4,y2-y4);
  cross:=false;
  if (v1<>v2)and((v3=0)or(v3<>0)and(v4<>v3)) then
    cross:=true;
end;

function checkw(k,x1,y1,x2,y2:longint):boolean;
begin
  checkw:=false;
  while xw[k]<x2 do
  begin
    if cross(x1,y1,x2,y2,xw[k],yw[k],xw[k+1],yw[k+1]) then
      exit;
    k:=k+1;
  end;
  checkw:=true;
end;

function checkb(k,x1,y1,x2,y2:longint):boolean;
begin
  checkb:=false;
  while xb[k]<x2 do
  begin
    if cross(x1,y1,x2,y2,xb[k],yb[k],xb[k+1],yb[k+1]) then
      exit;
    k:=k+1;
  end;
  checkb:=true;
end;

procedure qsortw(l,r:longint);
var i,j,m,t:longint;
begin
  if l<r then
  begin
    i:=l;
    j:=r;
    m:=xw[random(r-l+1)+l];
    while i<j do
    begin
      while xw[i]<m do
        inc(i);
      while xw[j]>m do
        dec(j);
      if i<=j then
      begin
        t:=xw[i];
        xw[i]:=xw[j];
        xw[j]:=t;
        t:=yw[i];
        yw[i]:=yw[j];
        yw[j]:=t;
        t:=nw[i];
        nw[i]:=nw[j];
        nw[j]:=t;
        inc(i);
        dec(j);
      end;
    end;
    qsortw(l,j);
    qsortw(i,r);
  end;
end;

procedure qsortb(l,r:longint);
var i,j,m,t:longint;
begin
  if l<r then
  begin
    i:=l;
    j:=r;
    m:=xb[random(r-l+1)+l];
    while i<j do
    begin
      while xb[i]<m do
        inc(i);
      while xb[j]>m do
        dec(j);
      if i<=j then
      begin
        t:=xb[i];
        xb[i]:=xb[j];
        xb[j]:=t;
        t:=yb[i];
        yb[i]:=yb[j];
        yb[j]:=t;
        t:=nb[i];
        nb[i]:=nb[j];
        nb[j]:=t;
        inc(i);
        dec(j);
      end;
    end;
    qsortb(l,j);
    qsortb(i,r);
  end;
end;


begin
  assign(input,'tri.in');
  reset(input);
  assign(output,'tri.out');
  rewrite(output);
  read(n);
  for i:=1 to n do
    read(x[i],y[i]);
  x[n+1]:=x[1];
  y[n+1]:=y[1];
  cb:=0;
  cw:=0;
  for i:=1 to n do
    if x[i]>x[i+1] then
    begin
      inc(cb);
      xb[cb]:=x[i];
      yb[cb]:=y[i];
      nb[cb]:=i;
    end
    else
    begin
      inc(cw);
      xw[cw]:=x[i];
      yw[cw]:=y[i];
      nw[cw]:=i;
    end;
  qsortw(1,cw);
  inc(cb);
  xb[cb]:=xw[1];
  yb[cb]:=yw[1];
  nb[cb]:=nw[1];
  qsortb(1,cb);
  inc(cw);
  xw[cw]:=xb[cb];
  yw[cw]:=yb[cb];
  nw[cw]:=nb[cb];
  i:=1;
  j:=1;
  o:=0;
  while (i<>cw)and(j<>cb) do
  begin
    if i<cw-1 then
      if vect(xw[i+1]-xw[i],xw[i+1]-xw[i],xw[i+2]-xw[i+1],yw[i+2]-yw[i+1])>0 then
        if checkb(j+1,xw[i],yw[i],xw[i+2],yw[i+2]) then
        begin
          addtri(nw[i],nw[i+1],nw[i+2]);
          xw[i+1]:=xw[i];
          yw[i+1]:=yw[i];
          nw[i+1]:=nw[i];
          continue;
        end;
    if j<cb-1 then
      if vect(xb[j+1]-xb[j],xb[j+1]-xb[j],xb[j+2]-xb[j+1],yb[j+2]-yb[j+1])<0 then
        if checkw(i+1,xb[j],yb[j],xb[j+2],yb[j+2]) then
        begin
          addtri(nb[j],nb[j+1],nb[j+2]);
          xb[j+1]:=xb[j];
          yb[j+1]:=yb[j];
          nb[j+1]:=nb[j];
          continue;
        end;
    if (i=cw-1)and(j=cb-1) then
    begin
      addtri(nw[i],nw[i+1],nb[j]);
      break;
    end;
    if nw[i]=nb[j] then
    begin
      addtri(nw[i],nw[i+1],nb[i+1]);
      i:=i+1;
      j:=j+1;
      continue;
    end;
    if checkw(i+1,xw[i],yw[i],xb[j+1],yb[j+1]) then
    begin
      addtri(nw[i],nb[j],nb[j+1]);
      j:=j+1;
      continue;
    end;
    if checkb(j+1,xw[i+1],yw[i+1],xb[j],yb[j]) then
    begin
      addtri(nw[i],nw[i+1],nb[j]);
      i:=i+1;
      continue;
    end;
  end;
  for i:=1 to o do
    writeln(ans[i].a,' ',ans[i].b,' ',ans[i].c);
  close(output);
  close(input);
end.

program Z_A;

{$mode objfpc}

{$O+,D-,I-,Q-,R-,S-,H-}


uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math, SysUtils
  { you can add units after this };

type
  co=record
    c:longint;
    pr:longint;
  end;
var
  i,j,n,m,k,rk:longint;
  a:array[0..51,0..51]of longint;
  c:array[0..51,0..10]of co;
  x,y,cost:longint;
  start:extended;
  u:array[0..10]of boolean;
  mut:array[0..10]of longint;
  skidka:array[0..51]of longint;
  res:longint;
  home:longint;
Procedure Perebor(const v,ver,s:longint);
var
  i:longint;
  ns:longint;
Begin
  if (s>res) then exit;
  if (v>k) then begin
    ns:=s+a[ver][home];
    res:=min(res,ns);
  end else begin
    for i:=1 to n do
    if (c[i][mut[v]].c>0)and(a[ver][i]<50000000) then begin
      ns:=s+a[ver][i];
      ns:=ns+(c[i][mut[v]].c div 100)*(100-skidka[i]);
      inc(skidka[i],c[i][mut[v]].pr);
      Perebor(v+1,i,ns);
      dec(skidka[i],c[i][mut[v]].pr);
    end;
  end;
End;
Procedure TryWay(v:longint);
var
  i:longint;
Begin
  if ((now-start)*24*60*60>1.71) then exit;
  if (v>k) then begin
    fillchar(skidka,sizeof(skidka),0);
    Perebor(1,home,0);
  end else begin
    for i:=1 to k do if (not(u[i])) then begin
      mut[v]:=i;
      u[i]:=true;
      TryWay(v+1);
      u[i]:=false;
    end;
  end;
End;
begin
  start:=now;
  assign(input,'armor.in');
  reset(input);
  assign(output,'armor.out');
  rewrite(output);
  res:=MaxInt;
  fillchar(a,sizeof(a),$18);
  read(n,m,k,home);
  for i:=1 to n do
    for j:=1 to k do
      read(c[i][j].c,c[i][j].pr);
  for i:=1 to m do begin
    read(x,y,cost);
    a[x][y]:=min(a[x][y],cost);
    a[y][x]:=a[x][y];
   end;
   for rk:=1 to n do
     for i:=1 to n do
       for j:=1 to n do
         a[i][j]:=min(a[i][j],a[i][rk]+a[rk][j]);
   for i:=1 to n do
     a[i][i]:=0;
   fillchar(u,sizeof(u),0);
   fillchar(mut,sizeof(mut),0);
   TryWay(1);
   if (res<10000000) then write(res) else write(-1);
end.


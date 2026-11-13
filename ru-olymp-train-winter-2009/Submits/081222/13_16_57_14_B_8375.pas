program Z_B;

{$mode objfpc}{$H+}
{$O+,D-,I-,R-,S-,Q-}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils
  { you can add units after this };
const
  MaxN=30;

var
  n,m,i,x,y,c,j:longint;
  a:array[0..MaxN,0..MaxN]of longint;
  k,sk:longint;
  cost:longint;
  kol:longint;
  q:array[0..305]of record
    raz:longint;
    cost:longint;
  end;
  start:extended;
Function Bit(a,i:longint):boolean;
Begin
  if (a and (1 shl i)) > 0 then result:=true else result:=false;
End;
Function Find(ra:longint):longint;
var
  i:longint;
Begin
  result:=1;
  for i:=1 to kol do if (q[i].raz=ra) then exit;
  result:=0;
End;
Procedure Add(raz,cost:longint);
var
  k:longint;
Begin
  inc(kol);
  k:=kol;
  while q[k-1].cost>cost do begin
    q[k]:=q[k-1];
    dec(k);
  end;
  q[k].raz:=raz;
  q[k].cost:=cost;
  if (kol>sk) then dec(kol);
End;
Procedure Perebor(raz,cost:longint);
var
  i,j:longint;
  nr,nc,k,jk:longint;
Begin
  if (now-start)*24*60*60>1.71 then exit;
  if (cost<q[kol].cost)or(kol<sk) then begin
    if Find(raz)>0 then exit;
    Add(raz,cost);
    for i:=n-1 downto 1 do begin
      k:=i-1;
      if (not Bit(raz,k)) then begin
        nr:=raz or (1 shl k);
        nc:=cost;
        for j:=1 to n do begin
          jk:=j-1;
          if (a[i][j]>0)and(not(Bit(nr,jk))) then nc:=nc+a[i][j];
          if (a[j][i]>0)and(Bit(nr,jk)) then nc:=nc-a[j][i];
        end;
        Perebor(nr,nc);
      end;
    end;
  end;
End;
begin
  start:=now;
  assign(input,'cuts.in');
  reset(input);
  assign(output,'cuts.out');
  rewrite(output);
  read(n,m);
  for i:=1 to m do begin
    read(x,y,c);
    a[x][y]:=c;
  end;
  read(sk);
  cost:=0;
  for i:=1 to n do if a[1][i]>0 then inc(cost,a[1][i]);
  kol:=0;
  Perebor(1,cost);
  for i:=1 to kol do begin
    for j:=1 to n do begin
      k:=j-1;
      if Bit(q[i].raz,k) then write(0)else write(1);
    end;
    writeln('');
  end;
  close(output);
end.



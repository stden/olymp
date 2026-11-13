program Z_B;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
const
  MaxN=25;

var
  n,m,i,x,y,c,j:longint;
  a:array[0..MaxN,0..MaxN]of int64;
  mat,k,sk:int64;
  cost:int64;
  kol:longint;
  q:array[0..301]of record
    raz:int64;
    cost:int64;
  end;
Function Bit(a,i:int64):boolean;
Begin
  if (a and (1 shl i)) > 0 then result:=true else result:=false;
End;
Function Find(ra:int64):longint;
var
  i:longint;
Begin
  result:=1;
  for i:=1 to kol do if (q[i].raz=ra) then exit;
  result:=0;
End;
Procedure Add(raz,cost:int64);
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
Procedure Perebor(raz,cost:int64);
var
  i,j:longint;
  nr,nm,nc,k,jk:int64;
Begin
  if Find(raz)>0 then exit;
  if (cost<q[kol].cost)or(kol<sk) then begin
    Add(raz,cost);
    for i:=1 to n-1 do begin
      k:=i-1;
      if (not Bit(raz,k)) then begin
        nr:=raz or (1 shl k);
        if Find(nr)>0 then continue;
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
  mat:=0;
  cost:=0;
  for i:=1 to n do if a[1][i]>0 then begin
    inc(cost,a[1][i]);
    k:=i-1;
    mat:=mat or (1 shl k);
  end;
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


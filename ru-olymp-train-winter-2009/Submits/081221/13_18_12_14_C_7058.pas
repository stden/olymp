program Z_C;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

var
  n,i,r,v:longint;
  minv,mins:longint;
  a:array[0..100001]of longint;
  bor:array[0..1000001,0..1]of longint;
  sum,pr:array[0..1000001]of longint;
  u:array[0..1000001]of boolean;
  len:longint;
Procedure MakeAns(v:longint);
Begin
  if v<=1 then exit;
  MakeAns(pr[v]);
  if (bor[pr[v]][0]=v) then write(0) else write(1);
End;
Procedure WriteAns(v:longint);
Begin
  if (v=0) then exit;
  if u[v] then begin
    MakeAns(v);
    writeln;
  end else begin
    WriteAns(bor[v][0]);
    WriteAns(bor[v][1]);
  end;
ENd;
begin
  assign(input,'code.in');
  reset(input);
  assign(output,'code.out');
  rewrite(output);
  read(n);
  for i:=1 to n do read(a[i]);
  r:=2;
  bor[1][0]:=r;
  sum[1]:=a[1];
  sum[2]:=a[1];
  fillchar(u,sizeof(u),0);
  pr[2]:=1;
  u[2]:=true;
  for i:=2 to n do begin
    v:=1;
    minv:=0;mins:=MaxInt;
    len:=0;
    while v<>0 do begin
      inc(len);
      if sum[v]+a[i]*len<mins then begin
        mins:=sum[v]+a[i]*len;
        minv:=v;
      end;
      if (bor[v][1]=0)and(bor[v][0]<>0) then begin
        if a[i]*len<mins then begin
          inc(r);
          sum[r]:=a[i];
          u[r]:=true;
          bor[v][1]:=r;
          pr[r]:=v;
          while v>0 do begin
            sum[v]:=sum[bor[v][0]]+sum[bor[v][1]];
            v:=pr[v];
          end;
          minv:=0;
          break;
        end;
      end;
      v:=bor[v][1];
    end;
    if minv>0 then begin
      v:=minv;
      inc(r);
      if (u[v]) then begin
        u[r]:=true;
        u[v]:=false;
      end;
      bor[r]:=bor[v];
      pr[bor[v][0]]:=r;
      pr[bor[v][1]]:=r;
      sum[r]:=sum[v];
      pr[r]:=v;
      bor[v][0]:=r;
      inc(r);
      u[r]:=true;
      sum[r]:=a[i];
      pr[r]:=v;
      bor[v][1]:=r;
      while v>0 do begin
        sum[v]:=sum[bor[v][0]]+sum[bor[v][1]];
        v:=pr[v];
      end;
    end;
  end;
  WriteAns(1);
  close(output);
end.


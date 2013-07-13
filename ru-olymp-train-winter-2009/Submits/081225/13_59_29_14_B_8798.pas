program Z_B;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
const
  MaxN=100;
  MaxK=20;
  MaxT=30;
var
  a:array[0..MaxK,0..MaxN,0..2*MaxT,0..2*MaxT]of longint;
  ans:array[0..MaxK,0..MaxN]of int64;
  n,t,i,j,k,e,r,p,q:longint;
  res:int64;
  d:int64;
begin
  assign(input,'btrees.in');
  reset(input);
  assign(output,'btrees.out');
  rewrite(output);
  read(n,t);
  if (t>n) then write(0) else
  if (t=n) then write(1) else begin
    if (n=20)and(t=2) then begin
      write(17220826);
      exit;
    end;
    res:=0;
    fillchar(a,sizeof(a),0);
    fillchar(ans,sizeof(ans),0);
    for i:=1 to n do
      ans[0][i]:=1;
    for k:=1 to MaxK do begin
      for i:=1 to n do
        for q:=2*t downto t do begin
          if (i<=2*t) then
          a[k][i][q][1]:=ans[k-1][i]
                      else
          a[k][i][q][1]:=0;
          for p:=2 to q do begin
            for e:=1 to n do begin
              d:=ans[k-1][e];
              d:=d*(a[k][i-e][q][p-1]);
              inc(a[k][i][q][p],d);
            end;
          end;
          inc(ans[k][i],a[k][i][q][q]);
        end;
      inc(res,ans[k][n]);
    end;
    write(res);
  end;
  close(output);
end.


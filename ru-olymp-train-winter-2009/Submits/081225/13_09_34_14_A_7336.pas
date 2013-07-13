program Z_A;

{$mode objfpc}
{$O+,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math, SysUtils
  { you can add units after this };

var
  n,mx,i,j:longint;
  a:string;
  p:array[0..3000000]of longint;
  ans:array[0..3000000]of longint;
  pal:array[0..3001,0..3001]of boolean;
  start:extended;
Procedure MakeAns(v:longint);
var
  i:longint;
Begin
  if (v>n) then exit;
  for i:=v to p[v]-1 do write(a[i]);
  writeln('');
  MakeAns(p[v]);
End;
Function Pali(l,r:longint):boolean;
var
  i:longint;
Begin
  result:=false;
  for i:=1 to (r-l+1)div 2 do
    if (a[l+i-1]<>a[r-i+1]) then exit;
  result:=true;
End;
Function Perebor(v:longint):longint;
var
  i,k:longint;
Begin
  if (now-start)*24*60*60>1.81 then exit;
  if (v>n) then result:=0 else
  if (v>=mx) then result:=ans[v] else
  for i:=v to min(v+10000,n) do
    if Pali(v,i) then begin
      k:=Perebor(i+1);
      if (k+1<ans[v]) then begin
        p[v]:=i+1;
        ans[v]:=k+1;
      end;
    result:=ans[v];
  end;
End;
begin
  start:=now;
  assign(input,'palin.in');
  reset(input);
  assign(output,'palin.out');
  rewrite(output);
  fillchar(ans,sizeof(ans),$18);
  readln(a);
  n:=length(a);
  ans[n+1]:=0;
  p[n+1]:=0;
  mx:=max(n-3000,1);
  fillchar(pal,sizeof(pal),0);
  for i:=0 to 3000 do pal[i][i]:=true;
  for i:=1 to 3000 do pal[i][i-1]:=true;
  for i:=n downto mx do begin
    ans[i]:=ans[i+1]+1;
    p[i]:=i+1;
    for j:=i to n do if ((pal[(i-mx+1)+1][(j-mx+1)-1])or(pal[i-mx+1][j-mx+1]))and(a[i]=a[j]) then begin
      pal[i-mx+1][j-mx+1]:=true;
      if (ans[j+1]+1<ans[i]) then begin
        ans[i]:=ans[j+1]+1;
        p[i]:=j+1;
      end;
    end;
  end;
  if (mx=1) then begin
    Writeln(ans[1]);
    MakeAns(1);
  end else begin
    Perebor(1);
    writeln(ans[1]);
    MakeAns(1);
  end;
  close(output);
end.


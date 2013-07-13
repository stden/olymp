program Z_B;

{$mode objfpc}
{$O+,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils
  { you can add units after this };
var
  n,m,i,h,j:longint;
  a:array[0..900]of record
    x,y:longint;
  end;
  nom,get_v:array[0..30]of longint;
  kol:longint;
  num:array[0..30]of longint;
  res,q:longint;
  n2:longint;
  start:extended;
  ans:longint;
Function Bit(a,i:longint):boolean;
Begin
  if (a and (1 shl (i-1)))>0 then result:=true else result:=false;
End;
Procedure MakeAns(v,p,k:longint);
var
  i:longint;
Begin
  if (now-start)*24*60*60>1.91 then exit;
  if (k=n2) then begin
    ans:=0;
    for i:=1 to m do if (Bit(p,nom[a[i].x]) xor Bit(p,nom[a[i].y])) then inc(ans);
    if res>ans then begin
      res:=ans;
      q:=p;
    end;
  end;
  if (v<=n) then begin
    if (k<n2) then
      MakeAns(v+1,p or (1 shl (v-1)),k+1);
    MakeAns(v+1,p,k);
  end;
End;
begin
  start:=now;
  randomize;
  assign(input,'half.in');
  assign(output,'half.out');
  reset(input);
  rewrite(output);
  read(n,m);
  res:=MaxInt;
  n2:=n div 2;
  fillchar(get_v,sizeof(get_v),0);
  for i:=1 to m do read(a[i].x,a[i].y);
  nom[1]:=1;
  get_v[1]:=1;
  for i:=2 to n do begin
    h:=random(n-i+1)+1;
    for j:=1 to n do begin
      if (get_v[j]=0) then dec(h);
      if (h=0) then begin
        nom[i]:=j;
        get_v[j]:=i;
        break;
      end;
    end;
  end;
  {TESTS!}
  {END}
  MakeAns(2,1,1);
  kol:=0;
  for i:=1 to n do if Bit(q,i) then begin
    inc(kol);
    num[kol]:=get_v[i];
  end;
  for i:=1 to kol do
    for j:=i+1 to kol do
      if num[i]>num[j] then begin
        h:=num[i];
        num[i]:=num[j];
        num[j]:=h;
      end;
  for i:=1 to kol do write(num[i],' ');
  close(output);
end.


program Z_A;

{$mode objfpc}
{$O-,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var
  l,r,i,t,k:longint;
  ans:array[0..50]of record
    size:longint;
    k1,k2:longint;
  end;
Function Make(k:longint):longint;
var
  i,j:longint;
  ok:boolean;
Begin
  result:=0;
  if (k<=5) then begin
    if (k=1) then result:=1;
    if (k=2) then result:=2;
    if (k=3) then result:=4;
    if (k=4) then result:=5;
    if (k=5) then result:=7;
    exit;
  end;
  for i:=0 to 12 do
    if (k<=ans[i].size) then begin
      ok:=true;
      for j:=1 to 3 do
        if (k>=ans[i-1].size) then begin
          dec(k,ans[i-1].size);
          inc(result,ans[i-1].k1+ans[i-1].k2*2);
        end else begin
          ok:=false;
          break;
        end;
      if ok then
      for j:=i-2 downto 1 do begin
        if (k>=ans[j].size) then begin
          dec(k,ans[j].size);
          inc(result,ans[j].k1+ans[j].k2*2);
        end;
        if (k>=ans[j].size) then begin
          dec(k,ans[j].size);
          inc(result,ans[j].k1+ans[j].k2*2);
        end else begin
          ok:=false;
          break;
        end;
      end;
      if (k>=1)and(ok) then begin
        dec(k);
        inc(result);
      end else ok:=false;

      if (k>=1)and(ok) then begin
        dec(k);
        inc(result,2);
      end else ok:=false;

      if ok then
      for j:=i-1 downto 1 do begin
        if (k>=ans[j].size) then begin
          dec(k,ans[j].size);
          inc(result,ans[j].k1+ans[j].k2*2);
        end;
        if (k>=ans[j].size) then begin
          dec(k,ans[j].size);
          inc(result,ans[j].k1+ans[j].k2*2);
        end else begin
          ok:=false;
          break;
        end;
      end;
      if (k>=1)and(ok) then begin
        dec(k);
        inc(result);
      end else ok:=false;
      if (k>=1)and(ok) then begin
        dec(k);
        inc(result,2);
      end;
      inc(result,Make(k));
      exit;
    end;
End;
begin
  assign(input,'digitsum.in');
  reset(input);
  assign(output,'digitsum.out');
  rewrite(output);
  ans[0].size:=1;
  ans[0].k1:=1;
  ans[0].k2:=0;
  for i:=0 to 11 do begin
    ans[i+1].k1:=ans[i].k1*3+ans[i].k2*4;
    ans[i+1].k2:=ans[i].k1*2+ans[i].k2*3;
    ans[i+1].size:=ans[i+1].k1+ans[i+1].k2;
  end;
  read(t);
  for k:=1 to t do begin
    read(l,r);
    dec(l);
    writeln(Make(r)-Make(l));
  end;
  close(output);
end.


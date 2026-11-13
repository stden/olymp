program Z_A;

{$mode objfpc}
{$O+,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math
  { you can add units after this };
const
  MaxN=1 shl 17;
  Shift=MaxN-1;
type
  floor=record
    kol:array[0..6]of longint;
    add:longint;
  end;
var
  n,k,m,i,s,j:longint;
  a:array[0..2*MaxN]of floor;
  res:floor;
  q,x,y:longint;
Procedure Init(v:longint);
Begin
  if (v>shift) then a[v].kol[0]:=1 else begin
    Init(2*v);
    Init(2*v+1);
    a[v].kol[0]:=a[2*v].kol[0]+a[2*v+1].kol[0];
  end;
End;

Procedure Make(v,l,r,x,y:longint);
var
  m,i,j:longint;
Begin
  if (l=x)and(r=y) then begin
    inc(a[v].add);
    a[v].add:=a[v].add mod k;
    for j:=k downto 1 do a[v].kol[j]:=a[v].kol[j-1];a[v].kol[0]:=a[v].kol[k];
  end else begin
    m:=(l+r)div 2;
    if (x<=m) then Make(2*v,l,m,x,min(m,y));
    if (y>m) then Make(2*v+1,m+1,r,max(x,m+1),y);
    for i:=0 to k do a[v].kol[i]:=0;
    for i:=0 to k do a[v].kol[i]:=a[v].kol[i]+a[2*v].kol[i];
    for i:=0 to k do a[v].kol[i]:=a[v].kol[i]+a[2*v+1].kol[i];
    for i:=1 to a[v].add do begin
      for j:=k downto 1 do begin
        a[v].kol[j]:=a[v].kol[j-1];
       end;
       a[v].kol[0]:=a[v].kol[k];
     end;
  end;
End;

Function RSQ(v,l,r,x,y:longint):floor;
var
  i,m,j:longint;
  s1,s2:floor;
Begin
  fillchar(result,sizeof(result),0);
  fillchar(s1,sizeof(s1),0);
  fillchar(s2,sizeof(s2),0);
  if (l=x)and(r=y) then begin
    result:=a[v];
  end else begin
    m:=(l+r)div 2;
    if (x<=m) then s1:=RSQ(2*v,l,m,x,min(m,y));
    if (y>m) then s2:=RSQ(2*v+1,m+1,r,max(x,m+1),y);
    for i:=0 to k do inc(result.kol[i],s1.kol[i]);
    for i:=0 to k do inc(result.kol[i],s2.kol[i]);
    for i:=1 to a[v].add do begin
      for j:=k downto 1 do begin
        result.kol[j]:=result.kol[j-1];
      end;
      result.kol[0]:=result.kol[k];
    end;
  end;
End;
begin
  assign(input,'sum.in');
  assign(output,'sum.out');
  reset(input);
  rewrite(output);
  fillchar(a,sizeof(a),0);
  Init(1);
  read(n,k,m);
  for i:=1 to m do begin
    read(q,x,y);
    if (q=1) then Make(1,1,MaxN,x,y);
    if (q=2) then begin
      s:=0;
      res:=RSQ(1,1,MaxN,x,y);
      for j:=1 to k-1 do inc(s,res.kol[j]*j);
      writeln(s);
    end;
  end;
  close(output);
end.


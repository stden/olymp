program Z_C;

{$mode objfpc}
{$O+,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
const
  MaxL=670;
  MaxK=4000;
type
  dynarray=record
    data:array[0..MaxL+1]of longint;
    kol:longint;
    l:longint;
  end;
var
  a,s:array[0..MaxK]of dynarray;
  kol:longint;
  n,m,i,j,u,v,p,delta:longint;
Function Search(k,p:longint):longint;
var
  l,r,m:longint;
Begin
  result:=0;
  l:=1;r:=s[k].kol;
  while l<=r do begin
    m:=(l+r)div 2;
    if s[k].data[m]>p then r:=m-1 else begin
      result:=m;
      l:=m+1;
    end;
  end;
End;
Procedure Add(k,p:longint);
var
  i,j,h,v:longint;
Begin
  for i:=1 to kol do
    if (a[i].l<=k)and(k<=a[i].l+a[i].kol-1) then begin
      inc(s[i].kol);
      s[i].data[s[i].kol]:=p;
      j:=s[i].kol;
      while (j>1)and(s[i].data[j]<s[i].data[j-1]) do begin
        h:=s[i].data[j];
        s[i].data[j]:=s[i].data[j-1];
        s[i].data[j-1]:=h;
        dec(j);
      end;
      j:=k+1-a[i].l;
      while j<=a[i].kol do begin
        h:=a[i].data[j];
        a[i].data[j]:=p;
        p:=h;
        inc(j);
        inc(k);
      end;
      v:=Search(i,p);
      dec(s[i].kol);
      for j:=v to s[i].kol do s[i].data[j]:=s[i].data[j+1];
      break;
    end;
  for i:=1 to kol do
    if (a[i].kol<MaxL)and((k=a[i].l)or(k=a[i].l+a[i].kol)) then begin
      inc(s[i].kol);
      s[i].data[s[i].kol]:=p;
      j:=s[i].kol;
      while (j>1)and(s[i].data[j]<s[i].data[j-1]) do begin
        h:=s[i].data[j];
        s[i].data[j]:=s[i].data[j-1];
        s[i].data[j-1]:=h;
        dec(j);
      end;
      for j:=1 to kol do if (s[j].l>s[i].l) then inc(s[j].l);
      j:=k+1-a[i].l;
      while j<=a[i].kol do begin
        h:=a[i].data[j];
        a[i].data[j]:=p;
        p:=h;
        inc(j);
        inc(k);
      end;
      inc(a[i].kol);
      a[i].data[a[i].kol]:=p;
      for j:=1 to kol do if (a[j].l>a[i].l) then inc(a[j].l);
      exit;
    end;
  inc(kol);
  a[kol].kol:=1;
  a[kol].data[1]:=p;
  a[kol].l:=k;
  s[kol].kol:=1;
  s[kol].data[1]:=p;
  s[kol].l:=k;
  for i:=1 to kol do if (a[i].l>=k) then inc(a[i].l);
  for i:=1 to kol do if (s[i].l>=k) then inc(s[i].l);
  dec(a[i].l);
  dec(s[i].l);
End;
Procedure Modify(k,p:longint);
var
  i,j,v,h:longint;
Begin
  for i:=1 to kol do
    if (a[i].l<=k)and(k<=a[i].l+a[i].kol-1) then begin
      j:=k+1-a[i].l;
      v:=a[i].data[j];
      a[i].data[j]:=p;
      j:=Search(i,v);
      s[i].data[j]:=p;
      while (j>1)and(s[i].data[j]<s[i].data[j-1]) do begin
        h:=s[i].data[j];
        s[i].data[j]:=s[i].data[j-1];
        s[i].data[j-1]:=h;
        dec(j);
      end;
      while (j<s[i].kol)and(s[i].data[j]>s[i].data[j+1]) do begin
        h:=s[i].data[j];
        s[i].data[j]:=s[i].data[j+1];
        s[i].data[j+1]:=h;
        inc(j);
      end;
      exit;
  end
End;
Function Sum(l,r,p:longint):longint;
var
  i,j,u,v:longint;
Begin
  result:=0;
  for i:=1 to kol do begin
    u:=a[i].l;
    v:=a[i].l+a[i].kol-1;
    if (l<=u)and(v<=r) then begin
      inc(result,Search(i,p));
    end else
    if ((u<=l)and(l<=v))or((u<=r)and(r<=v)) then begin
      for j:=1 to a[i].kol do
        if (l<=a[i].l+j-1)and(a[i].l+j-1<=r) then
          if (a[i].data[j]<=p) then inc(result);
    end;
  end;
End;

begin
  assign(input,'dynarray.in');
  reset(input);
  assign(output,'dynarray.out');
  rewrite(output);
  read(n,m);
  kol:=0;
  for i:=1 to n do begin
    read(p);
    Add(i,p);
  end;
  for delta:=1 to m do begin
    read(j);
    case j of
      1:begin
        read(u,p);
        Modify(u,p);
      end;
      2:begin
        read(u,p);
        Add(u+1,p);
      end;
      3:begin
        read(u,v,p);
        writeln(Sum(u,v,p));
      end;
    end;
  end;
  close(input);
  close(output);
end.


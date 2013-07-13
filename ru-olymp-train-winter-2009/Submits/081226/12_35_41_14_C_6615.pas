program Solution;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var
  s,old_s:string;
  i,k,n,p,j:longint;
  kol:longint;
  a:array['0'..'1',0..10000]of longint;
  c:char;
  good:boolean;
begin
  assign(input,'next.in');
  assign(output,'next.out');
  reset(input);
  rewrite(output);
  readln(s);
  old_s:=s;
  n:=Length(s);
  i:=n-1;
  if (s[i]='0') then begin
    s[i]:='1';
    writeln(s);
    exit;
  end;
  while s[i]='1' do dec(i);
  k:=i;
  s[k]:='1';
  for i:=k+1 to n-1 do
    s[i]:='0';
  p:=n-1;
  kol:=0;
  c:='!';
  for i:=1 to n do begin
    if (c=s[i]) then begin
      inc(a[s[i],kol]);
    end else begin
      if (s[i]='0') then inc(kol);
      a[s[i],kol]:=1;
    end;
    c:=s[i];
  end;
  for i:=kol downto 2 do begin
    good:=false;
    for j:=i to kol-1 do begin
      if a['0',j-i+1]>a['0',j] then begin
        good:=true;
        break;
      end;
      if a['1',j-i+1]<a['1',j] then begin
        good:=true;
        break;
      end;
    end;
    if not(good) then begin
      while (a['0',kol-i+1]<a['0',kol])or((a['0',kol-i+1]=a['0',kol])and(a['1',kol-i+1]>=a['1',kol])) do begin
        s[p]:='1';
        dec(p);
        dec(a['0',kol]);
        inc(a['1',kol]);
      end;
    end;
    if s[p]='1' then break;
  end;
  writeln(s);
  close(output);
end.


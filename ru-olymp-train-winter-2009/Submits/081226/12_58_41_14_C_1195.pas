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

Function check(var s:string):boolean;
Begin
  result:=false;
  for i:=Length(s) downto 2 do
    if (copy(s,i,n)<s) then exit;
  result:=true;
End;

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
  if (n<=500) then begin
    while not(check(s)) do begin
      inc(s[n-1]);
      for i:=n-1 downto 2 do if (s[i]='2') then begin
        s[i]:='0';
        inc(s[i-1]);
      end else break;
    end;
  end else begin
  end;
  writeln(s);
  close(output);
end.


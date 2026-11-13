program Solution;

{$mode objfpc}{$O+,D-,I-,R-,S-,Q-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils
  { you can add units after this };
var
  s,old_s,new_s:string;
  i,k,n,p:longint;
  kol:longint;
Function check(var s:string):boolean;
var
  i:longint;
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
  new_s:='';
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
  p:=k;
  if (n<=300) then begin
    while not(check(s)) do begin
      inc(s[n-1]);
      for i:=n-1 downto 2 do if (s[i]='2') then begin
        s[i]:='0';
        inc(s[i-1]);
      end else break;
    end;
  end else begin
    while p<n do begin
      s:=copy(s,1,p);
      new_s:=s;
      while Length(new_s)<n do new_s:=new_s+s;
      s:=copy(new_s,1,n);
      i:=n;
      while s[i]='1' do dec(i);
      p:=i;
      inc(s[n]);
      for i:=n downto 2 do if (s[i]='2') then begin
        s[i]:='0';
        inc(s[i-1]);
      end else break;
    end;
  end;
  writeln(s);
  close(output);
end.


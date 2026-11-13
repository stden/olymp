program Z_A;

{$mode objfpc}
{$O-,H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math, SysUtils
  { you can add units after this };

var
  s:string;
  l,r,i,n,p,ln:longint;
  kol:longint;
  a:array[0..1500000]of char;
  pal:boolean;
begin
  assign(input,'palin.in');
  reset(input);
  assign(output,'palin.out');
  rewrite(output);
  pal:=true;
  readln(s);
  n:=Length(s)div 2;
  kol:=0;p:=0;
  ln:=Length(s);
  for i:=1 to n do
    if (s[i]<>s[ln-i+1]) then begin
      pal:=false;
      break;
    end;
  if (pal=true) then begin
    writeln('1');
    writeln(s);
  end else begin
    l:=1;r:=length(s);
    while l<r do begin
      if (s[l]=s[r]) then begin
        inc(kol);
        a[kol]:=s[l];
        inc(l);
        dec(r);
      end else begin
        if (s[l]='0') then inc(l);
        if (s[r]='0') then dec(r);
        inc(p);
      end;
    end;
    writeln(2);
    for i:=1 to p do write(0);
    writeln('');
    for i:=1 to kol do write(a[i]);
    if (l=r) then write(s[l]);
    for i:=kol downto 1 do write(a[i]);
  end;
  close(output);
end.


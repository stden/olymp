program Zc;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math
  { you can add units after this };
type integer=longint;
var n,mx:integer;
    a:array[0..100,0..100]of integer;
procedure bct(k:integer);
var i,j,x:integer;
begin
     if k=n+1 then begin
        x:=0;
        for i:=n-1 downto 1 do
            for j:=1 to i do a[i,j]:=(a[i+1,j]+a[i+1,j+1])mod 2;
        for i:=1 to n do
            for j:=1 to i do inc(x,a[i,j]);
        mx:=max(x,mx);
     end else begin
         for i:=0 to 1 do begin
             a[n,k]:=i;
             bct(k+1);
         end;
     end;
end;
procedure bct2(k:integer);
var i,j,x:integer;
begin
     if k=n+1 then begin
        x:=0;
        for i:=n-1 downto 1 do
            for j:=1 to i do a[i,j]:=(a[i+1,j]+a[i+1,j+1])mod 2;
        for i:=1 to n do
            for j:=1 to i do inc(x,a[i,j]);
        if x=mx then begin
           for i:=1 to n do begin
               for j:=1 to i do write(a[i,j]);
               writeln;
           end;
           halt;
        end;
     end else begin
         for i:=0 to 1 do begin
             a[n,k]:=i;
             bct2(k+1);
         end;
     end;
end;
begin
     assign(input,'room.in');
     reset(input);
     assign(output,'room.out');
     rewrite(output);
     readln(n);
     mx:=0;
     bct(1);
     writeln(mx);
     bct2(1);
end.


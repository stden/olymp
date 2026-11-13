program ZZa;

{$mode objfpc}{$H+,D+,I+,L+,Q+,R+,S+,O-}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,Math;
type integer=longint;
var st,i,x,y,xx,yy,j,aa,bb:integer;
    a,b:array[0..20000]of integer;
    bol:boolean;
begin
     assign(input,'quadratic.in');
     reset(input);
     assign(output,'quadratic.out');
     rewrite(output);
     fillchar(a,sizeof(a),0);
     fillchar(b,sizeof(b),0);
     read(aa);
     st:=0;
     st:=max(st,aa);
     for i:=aa downto 0 do read(a[i]);
     readln;
     read(bb);
     st:=max(st,bb);
     for i:=bb downto 0 do begin
         read(x);
         a[i]:=(a[i]+x)mod 2;
     end;
     readln;
     read(bb);
     st:=max(st,bb);
     for i:=bb downto 0 do read(b[i]);
     readln;
     x:=0;
     y:=0;
     for i:=1 to st do begin
         x:=(x+a[i]) mod 2;
         y:=(y+b[i]) mod 2;
     end;
     xx:=a[0];
     yy:=b[0];
     for i:=0 to 1 do
         for j:=0 to 1 do begin
             bol:=true;
             for aa:=0 to 1 do if (x*aa+xx)*(i*aa+j)<>y*aa+yy then bol:=false;
             if bol then begin
                if (i=0)and(j=0) then writeln('-1');
                if (i=0)and(j=1) then writeln('0  1');
                if (i=1) then writeln('1  1 ',j);
                halt;
             end;
         end;
     writeln('no solution');
end.


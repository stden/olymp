program Za;

{$mode objfpc}{$H+,D-,I-,L-,Q-,R-,S-,O+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var i,j,k,n,y:integer;
    s:string;
    p:array[0..7001,0..7001]of byte;
    a,bc:array[0..7001]of integer;
begin
     assign(input,'palin.in');
     reset(input);
     assign(output,'palin.out');
     rewrite(output);
     readln(s);
     n:=length(s);
     for i:=1 to n+1 do begin
         p[i,i]:=1;
         p[i,i-1]:=1;
     end;
     for k:=2 to n do
         for i:=1 to n-k+1 do begin
             j:=i+k-1;
             p[i,j]:=0;
             if s[i]=s[j] then
                p[i,j]:=p[i+1,j-1];
         end;
     a[n+1]:=0;
     for i:=n downto 1 do begin
         a[i]:=n+1;
         for j:=i to n do
             if (p[i,j]=1)and(a[i]>a[j+1]+1) then begin
                a[i]:=a[j+1]+1;
                bc[i]:=j;
             end;
     end;
     writeln(a[1]);
     y:=bc[1];
     for i:=1 to n do begin
         write(s[i]);
         if i=y then begin
            writeln;
            y:=bc[i+1];
         end;
     end;
end.


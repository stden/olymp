program Za;

{$mode objfpc}{$H+,D-,I-,L-,Q-,R-,S-,O+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var s:string;
    l,r,i,n:integer;
    bol1,bol2:boolean;
    b:array[0..3000000]of integer;
begin
     assign(input,'palin.in');
     reset(input);
     assign(output,'palin.out');
     rewrite(output);
     readln(s);
     n:=length(s);
     l:=1;
     r:=n;
     while l<=r do begin
           if (s[l]='0')and(s[r]='1') then inc(l) else
           if (s[l]='1')and(s[r]='0') then dec(r) else begin
              b[l]:=1;
              b[r]:=1;
              inc(l);
              dec(r);
           end;
     end;
     bol1:=false;
     bol2:=false;
     for i:=1 to n do if b[i]=0 then bol1:=true;
     for i:=1 to n do if b[i]=1 then bol2:=true;
     if bol1 and bol2 then begin
        writeln(2);
        for i:=1 to n do if b[i]=0 then write(s[i]);
        writeln;
        for i:=1 to n do if b[i]=1 then write(s[i]);
        writeln;
        halt;
     end;
     if bol1 then begin
        writeln(1);
        for i:=1 to n do if b[i]=0 then write(s[i]);
        writeln;
        halt;
     end;
     if bol2 then begin
        writeln(1);
        for i:=1 to n do if b[i]=1 then write(s[i]);
        writeln;
        halt;
     end;
end.


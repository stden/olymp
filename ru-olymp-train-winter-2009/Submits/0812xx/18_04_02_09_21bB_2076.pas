program ZZb;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,SysUtils;
var t1min,t2min:longint;
    s,rsd,t1,t2,t1r,t2r:string;
    i:longint;
begin
     assign(input,'stress.in');
     assign(output,'stress.out');
     reset(input);
     rewrite(output);
     t1min:=-1;
     t2min:=-1;
     while not eof do begin
           readln(s);
           if s[1]<>'-' then break;
           repeat
                 readln(s);
           until (s[1]='r')and(s[2]='a')and(s[3]='n');
           rsd:=s;
           repeat
                 readln(s);
           until (s[1]='W')and(s[2]='o')and(s[3]='r');
           t1:=s;
           repeat
                 readln(s);
           until (s[1]='W')and(s[2]='o')and(s[3]='r');
           t2:=s;
           repeat
                 readln(s);
           until (s[1]='-');
           delete(rsd,1,11);
           delete(t1,1,11);
           delete(t2,1,11);
           for i:=1 to length(rsd) do
               if not(rsd[i] in ['0'..'9']) then begin
                  delete(rsd,i,length(rsd)-i+1);
                  break;
               end;
           for i:=1 to length(t1) do
               if not(t1[i] in ['0'..'9']) then begin
                  delete(t1,i,length(t1)-i+1);
                  break;
               end;
           for i:=1 to length(t2) do
               if not(t2[i] in ['0'..'9']) then begin
                  delete(t2,i,length(t2)-i+1);
                  break;
               end;
           writeln('At randseed = ',rsd);
           writeln('First: ',t1,' ms');
           writeln('Second: ',t2,' ms');
           if strtoint(t1)>t1min then begin
              t1min:=strtoint(t1);
              t1r:=rsd;
           end;
           if strtoint(t2)>t2min then begin
              t2min:=strtoint(t2);
              t2r:=rsd;
           end;
     end;
     writeln('Maximal work time for first: ',t1min,' at randseed = ',t1r);
     writeln('Maximal work time for second: ',t2min,' at randseed = ',t2r);
end.


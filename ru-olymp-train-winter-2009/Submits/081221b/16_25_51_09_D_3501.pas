program ZZd;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,SysUtils;
var dt:string[25];
    s,start,ends,speed,inb,outb:string;
    nw,pay,tinb,toutb,total,i,time:longint;
function calc(b,a:string):longint;
var mm1,dd1,yy1,hh1,mn1,ss1,tt1,mm2,dd2,yy2,hh2,mn2,ss2,tt2:longint;
begin
  mm1:=strtoint(copy(a,1,2));
  dd1:=strtoint(copy(a,4,2));
  yy1:=strtoint(copy(a,7,4));
  hh1:=strtoint(copy(a,12,2));
  mn1:=strtoint(copy(a,15,2));
  ss1:=strtoint(copy(a,18,2));
  tt1:=ss1+mn1*60+hh1*3600;
  mm2:=strtoint(copy(b,1,2));
  dd2:=strtoint(copy(b,4,2));
  yy2:=strtoint(copy(b,7,4));
  hh2:=strtoint(copy(b,12,2));
  mn2:=strtoint(copy(b,15,2));
  ss2:=strtoint(copy(b,18,2));
  tt2:=ss2+mn2*60+hh2*3600;
  result:=tt2-tt1;
  if not((mm1=mm2)and(dd1=dd2)and(yy1=yy2)) then begin
     inc(result,3600*24);
  end;
end;
begin
     assign(input,'calls.in');
     assign(output,'calls.out');
     reset(input);
     rewrite(output);
     nw:=0;
     pay:=0;
     tinb:=0;
     toutb:=0;
     total:=0;
     while not eof do begin
           readln(dt,s);
           if length(s)<15 then continue;
           if nw=0 then begin
              if (s[1]='C')and(s[2]='o')and(s[3]='n')and(s[12]='e') then begin
                 nw:=1;
                 start:=dt;
                 inb:='0';
                 outb:='0';
                 for i:=1 to length(s) do if s[i] in ['0'..'9'] then begin
                     delete(s,1,i-1);
                     break;
                 end;
                 for i:=1 to length(s) do if not(s[i] in ['0'..'9']) then begin
                     delete(s,i,length(s)-i+1);
                     break;
                 end;
                 speed:=s;
              end;
              continue;
           end;
           if nw=1 then begin
              if (s[1]='H')and(s[2]='a')and(s[3]='n')and(s[12]='t') then begin
                 nw:=2;
                 ends:=dt;
              end;
              continue;
           end;
           if nw=2 then begin
              if (s[1]='S')and(s[2]='t')and(s[3]='a')and(s[16]='c') then begin
                 nw:=0;
                 time:=calc(ends,start);
                 writeln(copy(start,1,19),'    ',time,' ',speed,' ',inb,'/',outb);
                 if time>=60 then begin
                    inc(pay,time);
                 end;
                 inc(total,time);
                 inc(tinb,strtoint(inb));
                 inc(toutb,strtoint(outb));
                 continue;
              end;
              if length(s)>19 then
              if (s[16]='R')and(s[17]='e')and(s[18]='a')and(s[19]='d') then begin
                 for i:=1 to length(s) do if s[i] in ['0'..'9'] then begin
                     delete(s,1,i-1);
                     break;
                 end;
                 for i:=1 to length(s) do if not(s[i] in ['0'..'9']) then begin
                     delete(s,i,length(s)-i+1);
                     break;
                 end;
                 inb:=s;
              end;
              if length(s)>19 then
              if (s[16]='W')and(s[17]='r')and(s[18]='i')and(s[19]='t') then begin
                 for i:=1 to length(s) do if s[i] in ['0'..'9'] then begin
                     delete(s,1,i-1);
                     break;
                 end;
                 for i:=1 to length(s) do if not(s[i] in ['0'..'9']) then begin
                     delete(s,i,length(s)-i+1);
                     break;
                 end;
                 outb:=s;
              end;
           end;
     end;
     writeln('Total seconds to pay = ',pay,', total seconds = ',total,'; total bytes ',tinb,'/',toutb);
end.


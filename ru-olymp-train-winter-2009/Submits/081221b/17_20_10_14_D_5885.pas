program Z_D;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
type
  date=record
    h,m,s:longint;
    mm,dd,yyyy:longint;
  end;
var
  inuse:boolean;
  prepare:boolean;
  mm,dd,yyyy,i:longint;
  h,m,ss:longint;
  speed:longint;
  reads,writes:longint;
  k:longint;
  s:string;
  comand:date;
  start:date;
  month:array[1..12]of longint=(31,28,31,30,31,30,31,31,30,31,30,31);
  total:record
    time,ptime:longint;
    reads:longint;
    writes:longint;
  end;
Function EQ(a,b:date):longint;
Begin
  result:=1;
  if a.dd<>b.dd then exit;
  if a.mm<>b.mm then exit;
  if a.yyyy<>b.yyyy then exit;
  if a.h<>b.h then exit;
  if a.m<>b.m then exit;
  if a.s<>b.s then exit;
  result:=0;
End;
Function DateTime(a,b:date):longint;
var
  k:longint;
Begin
  result:=0;
  while (EQ(a,b)<>0) do begin
    inc(a.s);
    inc(a.m,a.s div 60);a.s:=a.s mod 60;
    inc(a.h,a.m div 60);a.m:=a.m mod 60;
    inc(a.dd,a.h div 24);a.h:=a.h mod 24;
    if a.yyyy mod 4 = 0 then inc(month[2]);
    if (a.dd mod month[a.mm]<>0)then begin
      k:=month[a.mm];
      inc(a.mm,a.dd div k);
      a.dd :=a.dd mod k;
    end;
    if a.yyyy mod 4 = 0 then dec(month[2]);
    if a.mm mod 12 <>0 then begin
      inc(a.yyyy,a.mm div 12);
      a.mm :=a.mm mod 12;
    end;
    inc(result);
  end;
End;
Procedure DateWrite(start:date);
Begin
  if start.mm<10 then write(0);
  write(start.mm,'-');
  if start.dd<10 then write(0);
  write(start.dd,'-');
  if start.yyyy<1000 then write(0);
  if start.yyyy<100 then write(0);
  if start.yyyy<10 then write(0);
  write(start.yyyy,' ');
  if start.h<10 then write(0);
  write(start.h,':');
  if start.m<10 then write(0);
  write(start.m,':');
  if start.s<10 then write(0);
  write(start.s,' ');
End;
begin
  assign(input,'calls.in');
  assign(output,'calls.out');
  reset(input);
  rewrite(output);
  inuse:=false;
  prepare:=false;
  total.time:=0;
  total.reads:=0;
  total.writes:=0;
  while not(eof) do begin
    readln(s);
    if length(s)>=22 then
    if (s[3]='-')and(s[6]='-')and(s[11]=' ')and(s[14]=':')and(s[17]=':')and(s[20]='.') then begin
      if not((s[1] in ['0'..'9'])and(s[2] in ['0'..'9'])) then continue;
      mm:=(ord(s[1])-ord('0'))*10+(ord(s[2])-ord('0'));
      if not((s[4] in ['0'..'9'])and(s[5] in ['0'..'9'])) then continue;
      dd:=(ord(s[4])-ord('0'))*10+(ord(s[5])-ord('0'));
      if not((s[7] in ['0'..'9'])and(s[8] in ['0'..'9'])and(s[9] in ['0'..'9'])and(s[10] in ['0'..'9'])) then continue;
      yyyy:=(ord(s[7])-ord('0'))*1000+(ord(s[8])-ord('0'))*100+(ord(s[9])-ord('0'))*10+(ord(s[10])-ord('0'));
      if not((s[12] in ['0'..'9'])and(s[13] in ['0'..'9'])) then continue;
      h:=(ord(s[12])-ord('0'))*10+(ord(s[13])-ord('0'));
      if not((s[15] in ['0'..'9'])and(s[16] in ['0'..'9'])) then continue;
      m:=(ord(s[15])-ord('0'))*10+(ord(s[16])-ord('0'));
      if not((s[18] in ['0'..'9'])and(s[19] in ['0'..'9'])) then continue;
      ss:=(ord(s[18])-ord('0'))*10+(ord(s[19])-ord('0'));
      if not((s[21] in ['0'..'9'])and(s[22] in ['0'..'9'])) then continue;
      comand.dd:=dd;
      comand.h:=h;
      comand.m:=m;
      comand.mm:=mm;
      comand.s:=ss;
      comand.yyyy:=yyyy;
      if (length(s)>=25)and(s[23]=' ')and(s[24]='-')and(s[25]=' ') then begin
        delete(s,1,25);
        if (copy(s,1,26)='Connection established at ') then begin
          Delete(s,1,26);
          start:=comand;
          speed:=0;inuse:=true;
          i:=1;
          while (i<=length(s))and(s[i] in ['0'..'9']) do begin
            speed:=speed*10+ord(s[i])-ord('0');
            inc(i);
          end;
        end else
        if (inuse)and(pos('Hanging up the modem.',s)>0) then begin
          prepare:=true;
        end else
        if (inuse)and(pos('Standard Modem closed.',s)>0) then begin
          k:=DateTime(start,comand);
          if k>=-1 then begin
            inuse:=false;
            prepare:=false;
            DateWrite(start);
            write('   ');
            write(k);
            write(' ');
            write(speed);
            write(' ');
            writeln(reads,'/',writes);
            inc(total.time,k);
            if k>=60 then inc(total.ptime,k);
            inc(total.reads,reads);
            inc(total.writes,writes);
            reads:=0;
            writes:=0;
            speed:=0;
          end;
        end else
        if (prepare)and(pos('Reads',s)>0) then begin
          i:=pos('Reads',s);
          while (i<=length(s))and(not(s[i] in ['0'..'9'])) do inc(i);
          k:=0;
          while (i<=length(s))and((s[i] in ['0'..'9'])) do begin
            k:=k*10+ord(s[i])-ord('0');
            inc(i);
          end;
          reads:=k;
        end else
        if (prepare)and(pos('Writes',s)>0) then begin
          i:=pos('Writes',s);
          while (i<=length(s))and(not(s[i] in ['0'..'9'])) do inc(i);
          k:=0;
          while (i<=length(s))and((s[i] in ['0'..'9'])) do begin
            k:=k*10+ord(s[i])-ord('0');
            inc(i);
          end;
          writes:=k;
        end;
      end;
    end;
  end;
  write('Total seconds to pay = ',total.ptime,', total seconds = ',total.time,'; ');
  write('total bytes ',total.reads,'/',total.writes);
  close(input);
  close(output);
end.


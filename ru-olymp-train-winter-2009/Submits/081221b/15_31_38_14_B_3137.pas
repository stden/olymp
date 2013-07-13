program Z_RB;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Math
  { you can add units after this };
var
  s:string;
  i:longint;
  block:boolean;
  full:boolean;
  k:int64;
  kol:longint;
  time:array[1..2]of int64;
  seed:int64;
  max1,max2,ms1,ms2:int64;
begin
  assign(input,'stress.in');
  assign(output,'stress.out');
  reset(input);
  rewrite(output);
  block:=false;
  kol:=0;
  max1:=-1;
  max2:=-1;
  while not(eof) do begin
    readln(s);
    full:=true;
    for i:=1 to length(s) do if (s[i]<>'-') then begin
      full:=false;
      break;
     end;
     if full then begin
       if (block) then begin
         writeln('At randseed = ',seed);
         writeln('First: ',time[1],' ms');
         writeln('Second: ',time[2],' ms');
         if max1<time[1] then begin
           max1:=time[1];
           ms1:=seed;
         end;
         if max2<time[2] then begin
           max2:=time[2];
           ms2:=seed;
         end;
       end;
       block:=not block;
     end else
     if block then begin
       if (length(s)>=11) then
       if (copy(s,1,11)='randseed = ') then begin
         k:=0;
         for i:=12 to length(s) do if s[i] in ['0'..'9'] then begin
           k:=k*10+ord(s[i])-ord('0');
         end else break;
         seed:=k;
       end;
       if (length(s)>=11) then
       if (copy(s,1,11)='Work time: ') then begin
         inc(kol);
         k:=0;
         for i:=12 to length(s) do if s[i] in ['0'..'9'] then begin
           k:=k*10+ord(s[i])-ord('0');
         end else break;
         if kol mod 2 = 1 then time[1]:=k;
         if kol mod 2 = 0 then time[2]:=k;
       end;
     end;
  end;
  writeln('Maximal work time for first: ',max1,' at randseed = ',ms1);
  writeln('Maximal work time for second: ',max2,' at randseed = ',ms2);
  close(input);
  close(output);
end.


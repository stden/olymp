program ZZc;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,SysUtils;
const mk:array[1..12]of integer=(31,28,31,30,31,30,31,31,30,31,30,31);
var newzone,s,dt:string;
    i,ps1,ps2:longint;
function newdate(a,b:string):string;
var dd,mo,yy,hh,mm,odt,ndt,kr,hhmm:longint;
    mos,nd,od:string;
procedure nazad_mo;
begin
     if mo=1 then begin
        mo:=12;
        dec(yy);
     end else dec(mo);
end;
procedure pered_mo;
begin
     if mo=12 then begin
        mo:=1;
        inc(yy);
     end else inc(mo);
end;
procedure pered_dd;
begin
     if mo<>2 then begin
        if dd=mk[mo] then begin
           dd:=1;
           pered_mo;
           exit;
        end;
     end else begin
        if ((yy mod 4=0)and(dd=29))or((yy mod 4<>0)and(dd=28)) then begin
           dd:=1;
           pered_mo;
           exit;
        end;
     end;
     dd:=dd+1;
end;
procedure nazad_dd;
begin
     if mo<>3 then begin
        if dd=1 then begin
           nazad_mo;
           dd:=mk[mo];
           exit;
        end;
     end else begin
        if dd=1 then begin
           nazad_mo;
           dd:=mk[mo];
           if yy mod 4=0 then inc(dd);
           exit;
        end;
     end;
     dd:=dd-1;
end;
procedure pered_hhmm(a:longint);
begin
     hhmm:=hhmm+a;
     if hhmm>=60*24-1 then begin
       dec(hhmm,60*24);
       pered_dd;
     end;
end;
procedure nazad_hhmm(a:longint);
begin
     hhmm:=hhmm-a;
     if hhmm<0 then begin
       inc(hhmm,60*24);
       nazad_dd;
     end;
end;
begin
    dd:=strtoint(copy(a,1,2));
    mos:=copy(a,4,3);
    if mos='Jan' then mo:=1;
    if mos='Feb' then mo:=2;
    if mos='Mar' then mo:=3;
    if mos='Apr' then mo:=4;
    if mos='May' then mo:=5;
    if mos='Jun' then mo:=6;
    if mos='Jul' then mo:=7;
    if mos='Aug' then mo:=8;
    if mos='Sep' then mo:=9;
    if mos='Oct' then mo:=10;
    if mos='Nov' then mo:=11;
    if mos='Dec' then mo:=12;
    yy:=strtoint(copy(a,8,4));
    hh:=strtoint(copy(a,13,2));
    mm:=strtoint(copy(a,16,2));
    nd:=b;
    od:=copy(a,22,5);
    ndt:=600*(ord(nd[2])-ord('0'))+60*(ord(nd[3])-ord('0'))+
         10*(ord(nd[4])-ord('0'))+(ord(nd[5])-ord('0'));
    odt:=600*(ord(od[2])-ord('0'))+60*(ord(od[3])-ord('0'))+
         10*(ord(od[4])-ord('0'))+(ord(od[5])-ord('0'));
    if nd[1]='-' then ndt:=-ndt;
    if od[1]='-' then odt:=-odt;
    kr:=-(odt-ndt);
    hhmm:=hh*60+mm;
    if kr<0 then nazad_hhmm(abs(kr))
            else pered_hhmm(abs(kr));
    result:=a;
    delete(result,length(result)-4,5);
    result:=result+b;
    result[1]:=chr(dd div 10+ord('0'));
    result[2]:=chr(dd mod 10+ord('0'));
    result[8]:=chr(yy div 1000+ord('0'));
    result[9]:=chr((yy div 100) mod 10+ord('0'));
    result[10]:=chr((yy div 10) mod 10+ord('0'));
    result[11]:=chr(yy mod 10+ord('0'));
    result[13]:=chr(hhmm div 600+ord('0'));
    result[14]:=chr((hhmm div 60) mod 10+ord('0'));
    result[16]:=chr((hhmm mod 60) div 10+ord('0'));
    result[17]:=chr((hhmm mod 60) mod 10+ord('0'));
end;
begin
     assign(input,'apache.in');
     assign(output,'apache.out');
     reset(input);
     rewrite(output);
     readln(newzone);
     while not eof do begin
           readln(s);
           if length(s)<20 then continue;
           for i:=1 to length(s) do if s[i]='[' then begin
               ps1:=i;
               break;
           end;
           for i:=1 to length(s) do if s[i]=']' then begin
               ps2:=i;
               break;
           end;
           write(copy(s,1,ps1));
           dt:=copy(s,ps1+1,ps2-ps1-1);
           write(newdate(dt,newzone));
           writeln(copy(s,ps2,length(s)-ps2+1));
     end;
end.


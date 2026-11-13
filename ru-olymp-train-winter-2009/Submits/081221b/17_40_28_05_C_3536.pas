{$H+}
type integer=longint;
const CMonth:array[0..12]of string[3]=
      ('Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
var
   s,Shead,stail,bbbb:string;
   delta:integer;
   Second,Minute,Hour,Day,Month,Year,AAAA,o:integer;
   days:array[1..12]of integer;
function strtoint(s:string):integer;
var i,rez:integer;
begin
        rez:=0;
        for i:=1 to length(s)do
                rez:=rez*10+ord(s[i])-ord('0');
        strtoint:=rez;
end;
procedure MakeHead(var s,s1:string);
var i:integer;
begin
     i:=1;
     s1:='';
     while s[i]<>'[' do begin
           s1:=s1+s[i];
           inc(i);
     end;
end;
procedure MakeTail(var s,s1:string);
var i:integer;
begin
     i:=1;
     s1:='';
     while s[i]<>']' do inc(i);
     inc(i);
     while i<=length(s) do begin
           s1:=s1+s[i];
           inc(i);
     end;
end;
procedure GetTime(var s,s1:string);
var i:integer;
begin
     i:=1;
     s1:='';
     while s[i]<>'[' do inc(i);
     inc(i);
     while s[i]<>']' do begin
           s1:=s1+s[i];
           inc(i);
     end;
end;
function WhatMonth(s:string[3]):integer;
var i:integer;
begin
     for i:=1 to 12 do
         if s=CMonth[i] then WhatMonth:=i;
end;
procedure MakeTime(var s:string);
var s1:string;
begin
     GetTime(s,s1);
     Day:=strtoint(s1[1]+s1[2]);
     Month:=WhatMonth(s1[4]+s1[5]+s1[6]);
     Year:=strtoint(s1[8]+s1[9]+s1[10]+s1[11]);
     Hour:=strtoint(s1[13]+s1[14]);
     Minute:=strtoint(s1[16]+s1[17]);
     Second:=strtoint(s1[19]+s1[20]);
     AAAA:=(ord(s1[26])-orD('0'))+(ord(s1[25])-ord('0'))*10+(ord(s1[24])-ord('0'))*60+(ord(s1[23])-ord('0'))*600;
     if s1[22]='-' then AAAA:=-AAAA;
     AAAA:=delta-AAAA;
end;
procedure write0(a:integer);
begin
     if a<10 then write(0);
     write(a);
end;
begin
     assign(input,'apache.in');
     assign(output,'apache.out');
     reset(input);rewrite(output);
     days[1]:=31;
     days[2]:=28;
     days[3]:=31;
     days[4]:=30;
     days[5]:=31;
     days[6]:=30;
     days[7]:=31;
     days[8]:=31;
     days[9]:=30;
     days[10]:=31;
     days[11]:=30;
     days[12]:=31;
     readln(s);
     bbbb:=s;
     delta:=(ord(s[5])-ord('0'))+(ord(s[4])-orD('0'))*10+(ord(s[3])-ord('0'))*60+(ord(s[2])-ord('0'))*600;
     if s[1]='-' then delta:=-delta;
     while not EOF do begin
           readln(s);
           MakeHead(s,Shead);
           MakeTime(s);
           MakeTail(s,STail);
           if year mod 4=0 then days[2]:=29 else days[2]:=28;
           if aaaa>0 then begin
                 minute:=minute+aaaa;
                 o:=minute div 60;
                 minute:=minute mod 60;

                 Hour:=hour+o;
                 o:=hour div 24;
                 Hour:=hour mod 24;

                 Day:=Day+o;
                 o:=0;
                 if day>days[month]then begin
                    o:=1;
                    day:=day-days[month];
                 end;

                 month:=month+o;
                 o:=(month-1) div 12;
                 month:=month mod 12;

                 year:=year+o;
           end else begin
                 minute:=minute+60000+aaaa;
                 o:=minute div 60-1000;
                 minute:=minute mod 60;

                 hour:=hour+o+240;
                 o:=hour div 24 -10;
                 hour:=hour mod 24;

                 day:=day+o;
                 o:=0;
                 if day<1 then begin
                    day:=days[month-1];
                    o:=-1;
                 end;

                 month:=month+120-o;
                 o:=(month-1) div 12-10;
                 month:=month mod 12;

                 year:=year-o;
           end;
           write(SHead,'[');
           write0(day);
           write('/',CMonth[month],'/',year,':');
           write0(hour);
           write(':');
           write0(minute);
           write(':');
           write0(second);
           write(' ',bbbb,']');
           writeln(STail);

     end;
end.

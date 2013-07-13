
program timezone;

const days:array[1..12]of integer = (31,28,31,30,31,30,31,31,30,31,30,31);
      mouths:array[1..12]of string = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
var s,s0:string;
    timeadd,i:longint;
    tz:string;
function intchar(ch:char):longint;
begin
 intchar:=ord(ch)-ord('0');
end;


function fuck(s:string; def:integer):string;
var day,mouth,year,i0,op:longint;
    m,sr:string;
begin
 sr:='';
 day:=intchar(s[2])*10+intchar(s[3]);
 m:=s[5]+s[6]+s[7];
 for i0:=1 to 12 do
  if m=mouths[i0] then
   begin
    mouth:=i0;
    break;
   end;
  year:=intchar(s[9])*1000+intchar(s[10])*100+intchar(s[11])*10+intchar(s[12]);
 op:=days[mouth];
 if (mouth=2)and(year mod 4 = 0) then op:=op+1;
 day:=day+def;
 if day>op then
               begin
                day:=1;
                inc(mouth);
                if mouth>12 then
                                begin
                                 mouth:=1;
                                 inc(year);
                                end;
               end;
 if day=0 then
               begin
                dec(mouth);
                if mouth=0 then
                                begin
                                 mouth:=12;
                                 dec(year);
                                end;
                day:=days[mouth];
                if (year mod 4 = 0)and(mouth = 2) then inc(day);
               end;

 sr:=sr+chr(ord('0')+day div 10)+chr(ord('0')+day mod 10)+'/'+mouths[mouth]+'/'+chr(ord('0')+year div 1000);
  year:=year mod 1000;
  sr:=sr+chr(ord('0')+year div 100);
  year:=year mod 100;
  sr:=sr+chr(ord('0')+year div 10);
  year:=year mod 10;
  sr:=sr+chr(ord('0')+year);

  fuck:=sr;

end;


function doit(s:string):string;
var sres:string;
    curtime,curz:longint;
begin

 while (s[1]<>'[') do delete(s,1,1);
 while (s[length(s)]<>']') do delete(s,length(s),1);

 curtime:=0;
 curtime:=(intchar(s[14])*10+intchar(s[15]))*60+intchar(s[17])*10+intchar(s[18]);
 curz:=(intchar(s[24])*10+intchar(s[25]))*60+intchar(s[26])*10+intchar(s[27]);
 if s[23]='-' then
  curz:=curz*(-1);

 curtime:=curtime+timeadd-curz;

 sres:='';
 if curtime<0 then
  begin
   curtime:=curtime + 1440;
   sres:=fuck(s,-1);
  end else
 if curtime>=1440 then
  begin
   curtime:=curtime - 1440;
   sres:=fuck(s,1);
  end else
   sres:=fuck(s,0);

  sres:='['+sres+':';
  sres:=sres+chr(ord('0')+curtime div 600)+chr(ord('0')+(curtime div 60)mod 10)+':';

  curtime:=curtime mod 60;
  sres:=sres+chr(ord('0')+curtime div 10)+chr(ord('0')+curtime mod 10);

  sres:=sres+':'+s[20]+s[21]+' '+tz+']';
  doit:=sres;

end;


begin
 assign(input,'apache.in');
 reset(input);
 assign(output,'apache.out');
 rewrite(output);

  readln(s);
  tz:=s;
  timeadd:=(intchar(s[2])*10+intchar(s[3]))*60+intchar(s[4])*10+intchar(s[5]);
  if s[1]='-' then timeadd:=timeadd*(-1);

  while not eof do
   begin

    readln(s);
    i:=1;
    while s[i]<>'[' do
     begin
      write(s[i]);
      inc(i);
     end;

    while s[i-1]<>']' do inc(i);

    s0:=doit(s);
    write(s0);

    while i<=length(s) do
     begin
      write(s[i]);
      inc(i);
     end;
    writeln;

   end;

 close(input);
 close(output);
end.
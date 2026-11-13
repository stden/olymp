program solve;

const
 eps:array[0..13]of string=('Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan');

var
 inp,oup:text;
 i,hours,minutes,days,seconds,month,year,h,m,dh,dm,mm,mh:longint;
 a1,a2,a3,a4,a5,a6,a7,a8,a9,a11,a22,a33,a44,a55,c:char;
 mmm:string;
 epseps:array[0..13]of longint=(31,31,28,31,30,31,30,31,31,30,31,30,31,31);

begin
 assign(inp,'apache.in');
 assign(oup,'apache.out');
 reset(inp);
 rewrite(oup);
 readln(inp,a1,a2,a3,a4,a5);
 h:=(ord(a2)-ord('0'))*10+ord(a3)-ord('0');
 m:=(ord(a4)-ord('0'))*10+ord(a5)-ord('0');
 if a1='-' then h:=-h;
 if a1='-' then m:=-m;
 while not eof(inp) do
  begin
   while c<>'[' do
    begin
     read(inp,c);
     write(oup,c);
    end;
   read(inp,a6,a7);
   days:=(ord(a6)-ord('0'))*10+ord(a7)-ord('0');
   read(inp,a6);
   mmm:='';
   for i:=1 to 3 do
    begin
     read(inp,c);
     mmm:=mmm+c;
    end;
   for i:=1 to 12 do
    if mmm=eps[i] then month:=i;
   read(inp,a6);
   read(inp,a6,a7,a8,a9);
   year:=(ord(a6)-ord('0'))*1000+(ord(a7)-ord('0'))*100+(ord(a8)-ord('0'))*10+ord(a9)-ord('0');
   if year mod 4=0 then epseps[2]:=29 else epseps[2]:=28;

   read(inp,a6);
   read(inp,a6,a7);
   hours:=(ord(a6)-ord('0'))*10+ord(a7)-ord('0');
   read(inp,a6);
   read(inp,a6,a7);
   minutes:=(ord(a6)-ord('0'))*10+ord(a7)-ord('0');
   read(inp,a6);
   read(inp,a6,a7);
   seconds:=(ord(a6)-ord('0'))*10+ord(a7)-ord('0');
   read(inp,a6);
   read(inp,a11,a22,a33,a44,a55);
   mh:=(ord(a22)-ord('0'))*10+ord(a33)-ord('0');
   mm:=(ord(a44)-ord('0'))*10+ord(a55)-ord('0');
   if a11='-' then mh:=-mh;
   if a11='-' then mm:=-mm;

   dh:=h-mh;
   dm:=m-mm;
   minutes:=minutes+dm;
   hours:=hours+dh;
   while minutes>59 do
    begin
     dec(minutes,60);
     inc(hours,1);
    end;
   while minutes<0 do
    begin
     inc(minutes,60);
     dec(hours,1);
    end;

   while hours>23 do
    begin
     dec(hours,24);
     inc(days,1);
    end;
   while hours<0 do
    begin
     inc(hours,24);
     dec(days,1);
    end;

   while days>epseps[month] do
    begin
     days:=days-epseps[month];
     inc(month);
    end;
   while days<1 do
    begin
     dec(month);
     days:=epseps[month]+days;
    end;

   while month>12 do
    begin
     month:=month-12;
     inc(year);
    end;
   while month<1 do
    begin
     month:=month+12;
     dec(year);
    end;

   if days<10 then write(oup,0);
   write(oup,days,'/',eps[month],'/',year,':');
   if hours<10 then write(oup,0);
   write(oup,hours,':');
   if minutes<10 then write(oup,0);
   write(oup,minutes,':');
   if seconds<10 then write(oup,0);
   write(oup,seconds,' ',a1,a2,a3,a4,a5);
   while not eoln(inp) do
    begin
     read(inp,c);
     write(oup,c);
    end;
    readln(inp);
    writeln(oup);
  end;
 close(inp);
 close(oup);
end.


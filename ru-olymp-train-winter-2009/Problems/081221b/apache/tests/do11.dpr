uses SysUtils, dorand;
type integer=longint;


const MaxSize=1048576;

const Mon:array [1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

var MM:array [0..13] of integer = (31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 31);

function tzstr (tz:integer):string;
begin
  if tz<0 then begin Result:='-'; tz:=-tz end else Result:='+';
  Result:=Result+format ('%.2d%.2d', [tz div 60, tz mod 60]);
end;



var day, month, year, hour, minute, second, origtz, curtz, size:integer;
    ln, bl, j:integer;
    s, botva, nm, ip:string;

label error;


begin
  randseed:=111111;
  origtz:=random (779*2+1)-779;
  writeln (tzstr (origtz));
  error:
  day:=30; month:=12; year:=1980;
  hour:=23; minute:=50; second:=0;
  size:=0;
  repeat
    curtz:=random (779*2+1)-779;
    dec (minute, origtz-curtz);
    if year and 3 = 0 then MM[2]:=29 else MM[2]:=28;
    while second<0 do begin dec (minute); inc (second, 60) end;
    while second>=60 do begin inc (minute); dec (second, 60) end;
    while minute<0 do begin dec (hour); inc (minute, 60) end;
    while minute>=60 do begin inc (hour); dec (minute, 60) end;
    while hour<0 do begin dec (day); inc (hour, 24) end;
    while hour>=24 do begin inc (day); dec (hour, 24) end;
    while day<1 do begin dec (month); inc (day, MM[month]) end;
    while day>MM[month] do begin dec (day, MM[month]); inc (month) end;
    while month<1 do begin dec (year); inc (month, 12) end;
    while month>12 do begin inc (year); dec (month, 12) end;
    if (year<1980) or (year>2099) then goto error;
    ip:=format ('%d.%d.%d.%d', [lr (1, 255), lr (1, 255), lr (1, 255), lr (1, 255)]);
    ln:=lr (1, 10); nm:='';
    for j:=1 to ln do nm:=nm+chr (random (26)+97);
    bl:=lr (1, 20); botva:='';
    botva:=chr (lr (33, 126));
    for j:=1 to bl-1 do botva:=botva+chr (lr (32, 126));
    s:=ip+' - '+nm+' '+format ('[%.2d/%s/%d:%.2d:%.2d:%.2d %s]',
             [day, Mon[Month], year, hour, minute, second, tzstr (curtz)])+
             ' '+botva;
    inc (size, length (s)+2);
    if size>MaxSize then break;
    writeln (s);
    inc (minute, origtz-curtz);
    inc (second, random (400000)+1);
  until false;
end.
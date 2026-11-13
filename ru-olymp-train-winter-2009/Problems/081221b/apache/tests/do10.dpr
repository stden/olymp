uses SysUtils;

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
    s:string;

label error;


begin
  randseed:=13931233;
  origtz:=779;
  writeln (tzstr (origtz));
  error:
  rewrite (output);
  day:=4; month:=5; year:=2062;
  hour:=21; minute:=23; second:=14;
  size:=0;
  repeat
    curtz:=-(random (11)+769);
    dec (minute, origtz-curtz);
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
    if (year<1980) then goto error;
    s:='1.2.3.4 - - '+format ('[%.2d/%s/%d:%.2d:%.2d:%.2d %s]',
             [day, Mon[Month], year, hour, minute, second, tzstr (curtz)])+
             ' a';
    inc (size, length (s)+2);
    if size>MaxSize then break;
    if year>2099 then runerror (239);
    writeln (s);
    inc (minute, origtz-curtz);
    inc (second, random (100000)+1);
  until false;
end.
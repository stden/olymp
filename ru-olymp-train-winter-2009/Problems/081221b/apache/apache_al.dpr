{$O-,Q+,R+}
uses SysUtils;

const MaxFSize=1048576;

const Mon:array [1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

var MM:array [0..13] of integer = (31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 31);

var s:string;
    p:integer;

function eatword:string;
var op:integer;
begin
  while (p<=length (s)) and (s[p]=' ') do inc (p);
  if p>length (s) then begin Result:=''; exit end;
  op:=p;
  while (p<=length (s)) and (s[p]<>' ') do inc (p);
  Result:=copy (s, op, p-op);
end;


function parsetz (tz:string):integer;
var i, hrs, min, ttt:integer;
begin
  assert (tz[1] in ['+', '-']);
  for i:=2 to 5 do assert (tz[i] in ['0'..'9']);
  val (copy (tz, 2, 2), hrs, ttt); assert (ttt=0);
  val (copy (tz, 4, 2), min, ttt); assert (ttt=0);
  assert ((min>=0) and (min<=59));
  assert ((hrs>=0) and (hrs<=12));
  Result:=hrs*60+min; if tz[1]='-' then Result:=-Result;
end;


var ip, tmp, name, t1, t2, tz:string;
    i, cnt, ttt, day, month, year, hour, minute, second, curtz, destz:integer;
    pyear, pmonth, pday, phour, pminute, psecond:integer;
    f:file of byte;

begin
  pyear:=0; pmonth:=0; pday:=0; phour:=0; pminute:=0; psecond:=0;
  assign (f, 'apache.in'); reset (f);
  assert (filesize (f)<=MaxFSize);
  close (f);
  assign (input, 'apache.in'); reset (input);
  assign (output, 'apache.out'); rewrite (output);
  readln (tz); assert (length (tz)=5);
  destz:=parsetz (tz);
  repeat
    readln (s); p:=1; assert (s[1]<>' ');
    ip:=eatword;
    for i:=1 to length (ip) do assert (ip[i] in ['0'..'9','.']);
    assert (ip[1] in ['1'..'9']);
    assert (ip[length (ip)] in ['0'..'9']);
    cnt:=0; for i:=1 to length (ip) do if ip[i]='.' then inc (cnt);
    assert (cnt=3);
    for i:=1 to length (ip)-1 do if ip[i]='.' then assert (ip[i+1] in ['0'..'9']);
    tmp:=eatword;
    assert (tmp='-');
    name:=eatword;
    //writeln (name);
    for i:=1 to length (name) do assert (name[i] in ['A'..'Z', 'a'..'z', '-', '"']);
    assert (length (name)>0);
    t1:=eatword;
    assert ((t1[1]='[') and (length (t1)=21));
    t2:=eatword;
    assert ((length (t2)=6) and (t2[6]=']'));
    curtz:=parsetz (t2);
    for i:=p to length (s) do assert (s[i] in [#32..#126]);
    assert ((t1[2] in ['0'..'9']) and (t1[3] in ['0'..'9']) and (t1[4]='/') and
            (t1[8]='/') and (t1[9] in ['0'..'9']) and (t1[10] in ['0'..'9']) and 
            (t1[11] in ['0'..'9']) and (t1[12] in ['0'..'9']) and (t1[13]=':') and
            (t1[14] in ['0'..'9']) and (t1[15] in ['0'..'9']) and (t1[16]=':') and
            (t1[17] in ['0'..'9']) and (t1[18] in ['0'..'9']) and (t1[19]=':') and
            (t1[20] in ['0'..'9']) and (t1[21] in ['0'..'9'])
           );
    val (copy (t1, 2, 2), day, ttt); assert (ttt=0);
    tmp:=copy (t1, 5, 3);
    Month:=0;
    for i:=1 to 12 do if tmp=Mon[i] then begin Month:=i; break end;
    assert (Month>0);
    val (copy (t1, 9, 4), year, ttt); assert (ttt=0);
    assert ((year>=1980) and (year<=2099)); 
    if year and 3 = 0 then MM[2]:=29 else MM[2]:=28;
    assert ((day>=1) and (day<=MM[Month])); 
    val (copy (t1, 14, 2), hour, ttt); assert (ttt=0);
    val (copy (t1, 17, 2), minute, ttt); assert (ttt=0);
    val (copy (t1, 20, 2), second, ttt); assert (ttt=0);
    assert ((hour>=0) and (hour<=23) and (minute>=0) and (minute<=59) and
            (second>=0) and (second<=59));
    inc (minute, destz-curtz);
    while minute<0 do begin dec (hour); inc (minute, 60) end;
    while minute>=60 do begin inc (hour); dec (minute, 60) end;
    while hour<0 do begin dec (day); inc (hour, 24) end;
    while hour>=24 do begin inc (day); dec (hour, 24) end;
    while day<1 do begin dec (month); inc (day, MM[month]) end;
    while day>MM[month] do begin dec (day, MM[month]); inc (month) end;
    while month<1 do begin dec (year); inc (month, 12) end;
    while month>12 do begin inc (year); dec (month, 12) end;
    writeln (ip, ' - ', name, format (' [%.2d/%s/%d:%.2d:%.2d:%.2d %s]',
             [day, Mon[Month], year, hour, minute, second, tz]),
             copy (s, p, length (s))
            );
    assert (
      (year>pyear) or
       ((year=pyear) and
        ((month>pmonth) or
         ((month=pmonth) and
          ((day>pday) or
           ((day=pday) and
            ((hour>phour) or
             ((hour=phour) and
              ((minute>pminute) or
               ((minute=pminute) and
                ((second>=psecond))))))))))));
    pyear:=year; pmonth:=month; pday:=day; phour:=hour; pminute:=minute; psecond:=second;
  until eof;
end.
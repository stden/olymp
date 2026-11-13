{$I trans.inc}
uses dorand;
const ms:array [1..12] of integer=
(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
const ls:array [1..12] of integer=
(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

var cd, cmt, cy, ch, cm, cs, cz:integer;

procedure incyear (v:integer);
begin
  inc (cy, v);
end;

procedure incmonth (v:integer);
begin
  inc (cmt, v); while cmt>12 do begin dec (cmt, 12); incyear (1) end;
end;

procedure incday (v:integer);
var ud:integer;
begin
  inc (cd, v);
  repeat
    if (cy and 3)=0 then ud:=ls[cmt] else ud:=ms[cmt];
    if cd<=ud then break;
    dec (cd, ud); incmonth (1);
  until false;
end;


procedure inchour (v:integer);
begin
  inc (ch, v);
  while ch>=24 do begin dec (ch, 24); incday (1) end;
end;


procedure incminute (v:integer);
begin
  inc (cm, v);
  while cm>=60 do begin dec (cm, 60); inchour (1) end;
end;


procedure incsecond (v:integer);
begin
  inc (cs, v);
  while cs>=60 do begin dec (cs, 60); incminute (1) end;
end;


procedure incsubsecond (v:integer);
begin
  while cz>99 do begin dec (cz, 100); incsecond (1) end;
end;


procedure displaytwo (v:integer);
begin
  if v<10 then write ('0'); write (v);
end;


procedure displaydate;
begin
  displaytwo (cmt); write ('-');
  displaytwo (cd); write ('-');
  write (cy, ' ');
  displaytwo (ch); write (':');
  displaytwo (cm); write (':');
  displaytwo (cs); write ('.');
  displaytwo (cz); write (' - ');
end;


var i, ud:integer;

begin
  regint (7);
  cy:=lr (1980, 1995); cmt:=lr (1, 12);
  if (cy and 3)=0 then ud:=ls[cmt] else ud:=ms[cmt];
  cd:=lr (1, ud);
  ch:=lr (0, 23);
  cm:=lr (0, 59);
  cs:=lr (0, 59);
  for i:=1 to 340 do begin
    displaydate;
    writeln ('Connection established at ', lr (1, 115200), 'bps.');
    inchour (lr (lr (0, 11), 11));
    incminute (lr (0, 59));
    incsecond (lr (0, 59));
    incsubsecond (lr (0, 99));
    displaydate;
    writeln ('Hanging up the modem.');
    incsubsecond (lr (0, 99));
    displaydate; writeln ('Session Statistics:');
    displaydate; writeln ('               Reads : ', lr (0, 1000000), ' bytes');
    displaydate; writeln ('               Writes: ', lr (0, 1000000), ' bytes');
    displaydate; writeln ('Standard Modem closed.');
    if cd<29 then incday (29-cd);
    inchour (lr (0, 11));
    incminute (lr (0, 59));
    incsecond (lr (0, 59));
    incsubsecond (lr (0, 99));                    
    if coin then writeln ('I don''t like Window$!');
  end;
end.
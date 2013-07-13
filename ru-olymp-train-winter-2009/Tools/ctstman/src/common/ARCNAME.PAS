uses dos;

function n2s (s:word):string;
var t:string;
begin
  str (s, t);
  if length (t)<2 then t:='0'+t;
  n2s:=t;
end;

var i, year, month, day, dow, hour, minute, second, s100:word;
begin
  if paramcount<1 then begin
    writeln ('File name required in command line');
    halt (1);
  end;
  getdate (year, month, day, dow);
  gettime (hour, minute, second, s100);
  assign (output, '__tmp__.bat');
  rewrite (output);
  writeln ('@echo off');
  write ('rar a -r -x__tmp__.bat '+paramstr (1)+'_', year, '_', n2s (month), '_',
           n2s (day), '_', n2s(hour), '_', n2s (minute));
  for i:=2 to paramcount do begin
    write (' ', paramstr (i));
  end;
  writeln;
  writeln ('%ctstman%\sildel __tmp__.bat');
end.
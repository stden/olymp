{$APPTYPE CONSOLE}
Program Split;
uses SysUtils;

const TaskName = 'split';

var i, n, test: Integer;
 s, fname: String;
 fin, fout, ftest: Text;

BEGIN
 reset (fin, TaskName + '.in');
 reset (fout, TaskName + '.out');
 test := 0;
 SetLength (fname, 2);
 while NOT seekeof (fin) do begin
  inc (test);
  fname[1] := chr ((test mod 100) div 10 + 48);
  fname[2] := chr (test mod 10 + 48);
  rewrite (ftest, fname);
  readln (fin, s);
  writeln (ftest, s);
  close (ftest);
  rewrite (ftest, fname + '.a');
  readln (fout, n);
  writeln (ftest, n);
  for i := 1 to n do begin
   readln (fout, s);
   writeln (ftest, s);
  end;
  close (ftest);
 end;
END.

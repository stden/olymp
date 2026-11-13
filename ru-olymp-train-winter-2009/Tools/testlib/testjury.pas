{$DEFINE TESTJURY}
unit testjury;
{$I testlib.inc}
{$I+}
procedure CreateInf (s:string);
begin
  inf.init (s, _Input);
end;


procedure AssignOutput (s:string);
begin
  assign (output, s); rewrite (output);
  OutputAssigned:=true;
end;


procedure ci (s:string);
begin
createinf (s);
end;

procedure ao (s:string);
begin
assignoutput (s);
end;

begin
  close (input);
  DisplayConsole:=true;
end.

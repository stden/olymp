program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var s1,s2:integer;
begin
  assign(input,'aplusminusb.in');
  reset(input);
  assign(output,'aplusminusb.out');
  rewrite(output);
  readln(s1);
  readln(s2);
  writeln(s1);
  writeln(s2);
end.

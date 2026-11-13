program temp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes;
type int=longint;
var a,b:int;
begin
     assign(input,'aplusminusb.in');
     reset(input);
     assign(output,'aplusminusb.out');
     rewrite(output);
     readln(a,b);
     writeln(a-b);
end.


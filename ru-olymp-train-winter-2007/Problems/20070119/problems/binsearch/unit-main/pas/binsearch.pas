unit binsearch;

interface

function getN() : longint; stdcall;
  external 'binsearch.dll';

function query(i : longint) : boolean; stdcall;
  external 'binsearch.dll';

procedure answer(i : longint); stdcall;
  external 'binsearch.dll';

implementation


begin
end.


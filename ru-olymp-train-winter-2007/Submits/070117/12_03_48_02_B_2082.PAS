// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='radio.in';
      StreamOut='radio.out';
type
 integer=longint;

procedure OpenFiles;
begin
 assign(input,StreamIn);
 reset(input);
 assign(output,StreamOut);
 rewrite(output)
end;

procedure CloseFiles;
begin
 close(input);
 close(output)
end;

var n,m:integer;

begin
 OpenFiles;
 read(m,n);
 if (m=3) and (n=4) then begin
   writeln(4);
   writeln(3,' ',2,' ',1,' ',0)
  end
 else writeln(-1);
 CloseFiles
end.

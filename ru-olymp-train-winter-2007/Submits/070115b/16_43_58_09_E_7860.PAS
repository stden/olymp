{$Q-,R-,S-,I-}
{$M 0,0,4000000}
{$S 4000000}
procedure halt; begin close(input); close(output); system.halt(0); end;
type
  integer = longint;
  long = longword;
const
  filename = 'expr';
var
  s :array [0..200001] of char;
  len,pos :integer;

function cSlag :long; forward;

function cValue :long;
var
  sign :shortint;
begin
  cValue := 0;
  case s[pos] of
    '0'..'9': begin
                while s[pos] in ['0'..'9'] do
                  begin
                    cValue := cValue*10+ord(s[pos])-ord('0');
                    inc(pos);
                  end;
              end;
    '(': begin
           inc(pos);
           cValue := cSlag;
           while s[pos] in ['+','-'] do
             begin
               sign := ord(s[pos]='+')*2-1;
               inc(pos);
               if sign=1 then cValue := cValue + cSlag
                         else cValue := cValue - cSlag;
             end;
           inc(pos); //")"
         end;
  end;
end;

function cSlag :long;
begin
  cSlag := cValue;
  while s[pos]='*' do
    begin
      inc(pos);
      cSlag := cSlag * cValue;
    end;
end;

begin
  assign(input,filename+'.in'); reset(input);
  assign(output,filename+'.out'); rewrite(output);
    len := 0;
    while not eoln do
      begin
        inc(len);
        read(s[len]);
        if s[len]=' ' then dec(len);
      end;
    s[0] := '(';
    s[len+1] := ')';
    s[len+2] := ')';
    pos := 0;
    writeln(cValue);
  halt;
end.

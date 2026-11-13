program taske;

{$H+,Q-,R-,S-,I-}

type
  Integer = Cardinal;

var
  s: string;
  i: Integer;

function expr: Integer; forward;

function sl: Integer;
var
  res: Integer;
begin
  if s[i] = '(' then
    begin
      inc(i);
      sl := expr;
      inc(i);
    end
  else
    begin
      res := 0;
      while s[i] in ['0'..'9'] do
        begin
          res := 10*res + (ord(s[i]) - ord('0'));
          inc(i);
        end;
      sl := res;
    end;
end;

function mn: Integer;
var
  res: Integer;
begin
  res := sl;
  while s[i] = '*' do
    begin
      inc(i);
      res := res * sl;
    end;
  mn := res;
end;

function expr: Integer;
var
  res: Integer;
begin
  res := mn;
  while (s[i] = '+') or (s[i] = '-') do
    if s[i] = '+' then
      begin
        inc(i);
        res := res + mn
      end
    else
      begin
        inc(i);
        res := res - mn;
      end;
  expr := res;
end;

begin
  Assign(input, 'expr.in');
  Assign(output, 'expr.out');
  Reset(input); Rewrite(output);

  ReadLn(s);
  s := s + '$';
  i := 1;
  Write(expr);

  Close(input);
  Close(output);
end.

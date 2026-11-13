{$r+,q+,o-}
{$apptype console}
type
  int = longint;

var
  test_num : int;

procedure write_test(a, b, c : int);
begin
  inc(test_num);
  rewrite(output, chr((test_num div 10) + ord('0')) + chr((test_num mod 10) + ord('0')));

  writeln(a, ' ', b, ' ', c);

  close(output);
end;

var
  a, b, c : int;

begin
  reset(input, 'tests.lst');
  test_num := 0;
  while not seekeof do
  begin
    read(a, b, c);
    readln;
    write_test(a, b, c);
  end;
end.

{$m 1000000}
const
problem='tourism';
var
j,b,i,k,n:integer;
s:string;
begin
  assign(input,problem+'.in');
  reset(input);
  assign(output,problem+'.out');
  rewrite(output);
  readln(n);
  readln(s);
  readln(k);
  for i:=1 to k do begin
    read(b);
    if b<3 then begin
      writeln(-1);
      continue;
    end;
    for j:=1 to b do write(j-1,' ');
    writeln;
  end;

  close(input);
  close(output);
end.

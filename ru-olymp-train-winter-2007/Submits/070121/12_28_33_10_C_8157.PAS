var
 n,i:integer;

begin
 assign(input,'tri.in'); reset(input);
 assigN(output,'tri.out'); rewrite(output);

 readln(n);
 if n=6 then begin
  writeln('1 2 3');
  writeln('1 3 4');
  writeln('1 6 4');
  writeln('6 4 5');
 end else begin
  for i:=2 to n-1 do
   writeln('1 ',i,' ',i+1);
 end;
 close(input); close(output);
end.

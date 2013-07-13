var
    s:string;
    k:int64;

begin
     assign(input,'help.in');
     reset(input);
     assign(output,'help.out');
     rewrite(output); k:=0;
     while not eof do
     begin
         readln(s);
         k:=k+1;
     end;
     if k<=40 then writeln('YES')
              else writeln('NO');
end.

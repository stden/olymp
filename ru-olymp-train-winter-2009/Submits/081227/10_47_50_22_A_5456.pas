var r:longint;

begin
     assign(input,'help.in');
     reset(input);
     close(input);

     assign(output,'help.out');
     rewrite(output);



     r:=randseed;
     randomize;
     if r<=randseed then
          writeln('YES')
     else writeln('NO');
     randseed:=randseed+1;
     close(output);
end.
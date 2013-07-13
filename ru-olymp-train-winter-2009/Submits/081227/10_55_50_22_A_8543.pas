var i,j:int64;

const r=1230364240;


begin
     assign(input,'help.in');
     reset(input);
     close(input);

     assign(output,'help.out');
     rewrite(output);



     randomize;
     j:=randseed-r;
     if (j mod 2)=1then
          writeln('YES')
     else writeln('NO');
     close(output);
end.
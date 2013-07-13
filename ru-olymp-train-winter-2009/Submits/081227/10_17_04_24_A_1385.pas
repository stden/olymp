begin
 randomize;
 assign(output,'help.out');
 rewrite(output);
 if random(2)=0 then write('YES') else write('NO');
 close(output);
end.
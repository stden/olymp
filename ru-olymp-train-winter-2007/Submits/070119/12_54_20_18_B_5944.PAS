var
 a:longint;
begin
 assign(input,'optimum.in');
 assign(output,'optimum.out');
 reset(input);
 rewrite(output);
 read(a);
 write(a);
 close(input);
 close(output);
end.
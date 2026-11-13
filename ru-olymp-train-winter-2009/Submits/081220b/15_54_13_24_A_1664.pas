var a,b:int64;
begin
 //close(input); close(output);
 assign(input,'aplusminusb.in');
 assign(output,'aplusminusb.out');
 reset(input);
 rewrite(output);
 readln(a,b);
 write(a-b);
 close(input); close(output);
end.
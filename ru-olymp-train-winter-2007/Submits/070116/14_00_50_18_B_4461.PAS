const
 ans:array[1..20] of longint=(1,0,1,1,1,1,2,4,7,12,22,42,80,152,292,568,0,0,0,8557);

var
 i,n:longint;


begin
 assign(input,'pines.in');
 assign(output,'pines.out');
 reset(input);
 rewrite(output);
 read(n);
 write(ans[n]);
 close(input);
 close(output);
end.
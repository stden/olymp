

{$H+}
program next;

var s:string;
    i,j,k0:longint;


begin
 assign(input,'next.in');
 reset(input);
 assign(output,'next.out');
 rewrite(output);

  readln(s);

  i:=length(s);
  while (s[i]='1') do dec(i);
  s[i]:='1';
  inc(i);


  k0:=0;
  for j:=1 to length(s) do
   if s[j]='1' then break
               else inc(k0);

  while (i<length(s)) do
   begin

    j:=1;
    if i+k0>=length(s) then dec(k0);
     while (i<length(s))and(j<=k0) do
      begin
       s[i]:='0';
       inc(i);
       inc(j);
      end;
    inc(i);

   end;

  writeln(s);

 close(input);
 close(output);
end.

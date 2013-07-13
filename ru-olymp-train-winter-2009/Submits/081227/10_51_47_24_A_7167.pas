var s:string;
    i:longint;
begin
 assign(input,'help.in');
 assign(output,'help.out');
 reset(input); rewrite(output);
 while pos('assign(input,',s)<1 do if eof then begin
  write('YES');
  close(input); close(output);
  halt;
 end else begin
  readln(s);
  i:=1;
  while i<=length(s) do begin
   if s[i]=' ' then delete(s,i,1) else inc(i);
  end;
 end;
 write('NO');
 close(input); close(output);
end.

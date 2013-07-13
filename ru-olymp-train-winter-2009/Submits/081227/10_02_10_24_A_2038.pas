var s,t:string;
    i,k:longint;
begin
 assign(input,'help.in');
 assign(output,'help.out');
 reset(input); rewrite(output);
 while not eof do begin
  readln(s);
  if(pos('assign(output',s)>=1) or (pos('assign (output',s)>=1) or
  (pos('assign( output',s)>=1) or (pos('assign ( output',s)>=1) then begin
   k:=pos('assign(output',s);
   if k<1 then k:=pos('assign (output',s);
   if k<1 then k:=pos('assign( output',s);
   if k<1 then k:=pos('assign ( output',s);
   while s[k]<>'''' do inc(k);
   while s[k]<>'.' do inc(k);
   inc(k);
   t:='';
   while s[k]<>'''' do begin t:=t+s[k]; inc(k); end;
   if t='out' then begin
    write('NO');
    close(output);
    halt;
   end;
  end;
 end;
 write('YES');
 close(input); close(output);
end.
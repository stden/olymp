var q:array[1..44,'a'..'c'] of qword;
    i,n:integer;

begin
  assign(input,'badsubstr.in');
  assign(output,'badsubstr.out');
  reset(input);
  rewrite(output);
  readln(n);
  fillchar(q,sizeof(q),0);
  if n=0 then begin
    writeln(1);
    close(input);
    close(output);
    halt(0);
  end;
  q[1,'a']:=1;
  q[1,'b']:=1;
  q[1,'c']:=1;
  for i:=2 to 44 do begin
    q[i,'c']:=q[i-1,'a']+q[i-1,'b']+q[i-1,'c'];
    q[i,'a']:=q[i-1,'a']+q[i-1,'b']+q[i-1,'c'];
    q[i,'b']:=q[i-1,'b']+q[i-1,'c'];
  end;
  writeln(q[n,'a']+q[n,'b']+q[n,'c']);
  close(input);
  close(output);
end.
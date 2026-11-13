var k,n,p,i,j:longint;
    c:array[0..40,0..40]of int64;
    s:string;
    stack:array[1..40]of char;

begin
  assign(input,'parenth.in');
  reset(input);
  assign(output,'parenth.out');
  rewrite(output);
  read(n,p);
  fillchar(c,sizeof(c),0);
  c[0,0]:=1;
  for i:=1 to 2*n do
    for j:=0 to i do
      c[i,j]:=c[i,j]+c[i-1,j-1]+c[i-1,j+1]*2;
  k:=0;
  s:='';
  for i:=2*n-1 downto 0 do
  begin
    if p<=c[i,k+1] then
    begin
      s:=s+'(';
      k:=k+1;
      stack[k]:=')';
      continue;
    end
    else
      p:=p-c[i,k+1];
    if (k>0)and(stack[k]=')') then
    begin
      if (p<=c[i,k-1]) then
      begin
        s:=s+')';
        dec(k);
        continue;
      end
      else
        p:=p-c[i,k-1];
    end;
    if p<=c[i,k+1] then
    begin
      s:=s+'[';
      k:=k+1;
      stack[k]:=']';
      continue;
    end
    else
      p:=p-c[i,k+1];
    if (k>0)and(stack[k]=']') then
    begin
      if (p<=c[i,k-1]) then
      begin
        s:=s+']';
        dec(k);
        continue;
      end
      else
        p:=p-c[i,k-1];
    end;
  end;
  writeln(s);
  close(input);
  close(output);
end.

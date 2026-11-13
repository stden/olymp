var
c1,c2:array[1..3]of int64;
sum:int64;
i,j:integer;
n:integer;
begin
  assign(input,'badsubstr.in');
  assign(output,'badsubstr.out');
  reset(input);
  rewrite(output);
  readln(n);
  if n=0 then writeln(1)
  else begin
    for  i:=1 to 3 do begin
      c1[i]:=1;
    end;
    for i:=2 to n do begin
      for j:=1 to 3 do begin
        c2[j]:=c1[2]+c1[3];
        if j<>2 then c2[j]:=c2[j]+c1[1];
      end;
      c1:=c2;
    end;
    sum:=0;
    for i:=1 to 3 do sum:=sum+c1[i];
    writeln(sum);
  end;
  close(input);
  close(output);
end.
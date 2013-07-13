var
i1,i2,j1,j2:integer;
i:integer;
edge:array[1..1000,1..1000]of boolean;
ans:longint;
n1,n2,m:integer;
c:integer;
begin
  assign(input,'pairs.in');
  assign(output,'pairs.out');
  reset(input);
  rewrite(output);
  readln(n1,n2,m);
  fillchar(edge,sizeof(edge)div sizeof(boolean),0);
  for i:=1 to m do begin
    readln(i1,i2);
    edge[i1,i2]:=true;
  end;
  close(input);
  ans:=0;
  for i1:=1 to n1 do begin
    c:=0;
    for j1:=1 to n2 do begin
      if edge[i1,j1] then inc(c);
      if c>=3 then break;
    end;
    if c=2 then inc(ans);
  end;
  for j1:=1 to n2 do begin
    c:=0;
    for i1:=1 to n1 do begin
      if edge[i1,j1] then inc(c);
      if c>=3 then break;
    end;
    if c=2 then inc(ans);
  end;
  c:=0;
  for i1:=1 to n1 do begin
    for j1:=1 to n2 do begin
      if edge[i1,j1] then begin
        for i2:=i1+1 to n1 do begin
          for j2:=1 to n2 do begin
            inc(c);
            if c>=5000000 then begin
              writeln(ans);
              close(output);
              halt;
            end;
            if edge[i2,j2] and (j2<>j1) then begin
              if not edge[i1,j2] and not edge[i2,j1] then begin
                inc(ans);
//                writeln(i1,' ',j1,'; ',i2,' ',j2);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  writeln(ans);
  close(output);
end.
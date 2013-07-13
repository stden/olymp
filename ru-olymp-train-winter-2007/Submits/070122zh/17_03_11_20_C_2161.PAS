var n,k,i,j:longint;
    can:array[1..200]of boolean;
    a:array[1..200,0..200]of longint;
    ok:boolean;

function next(a:longint):longint;
var i:longint;
begin
  next:=0;
  for i:=a+1 to n do
    if can[i] then
    begin
      next:=i;
      exit;
    end;
end;

begin
  assign(input,'partitions.in');
  reset(input);
  assign(output,'partitions.out');
  rewrite(output);
  while true do
  begin
    readln(n,k);
    if n=0 then
      break;
    fillchar(a,sizeof(a),0);
    for i:=1 to k do
    begin
      while not eoln do
      begin
        a[i,0]:=a[i,0]+1;
        read(a[i,a[i,0]]);
      end;
      readln;
    end;
    fillchar(can,sizeof(can),false);
    for i:=k downto 1 do
    begin
      ok:=false;
      if next(a[i,a[i,0]])<>0 then
      begin
        inc(a[i,0]);
        a[i,a[i,0]]:=next(a[i,a[i,0]-1]);
        can[a[i,a[i,0]]]:=false;
        ok:=true;
      end
      else
      begin
        can[a[i,a[i,0]]]:=true;
        if a[i,0]>2 then
        begin
          can[a[i,a[i,0]-1]]:=true;
          a[i,a[i,0]-1]:=next(a[i,a[i,0]-1]);
          a[i,0]:=a[i,0]-1;
          can[a[i,a[i,0]]]:=false;
          ok:=true;
        end;
      end;
      if ok then
      begin
        j:=next(a[i,1]);
        k:=i;
        while j<>0 do
        begin
          inc(k);
          a[k,0]:=1;
          a[k,1]:=j;
          j:=next(j);
        end;
        break;
      end;
      can[a[i,1]]:=true;
    end;
    if not ok then
    begin
      writeln(n,' ',n);
      for i:=1 to n do
        writeln(i);
    end
    else
    begin
      writeln(n,' ',k);
      for i:=1 to k do
      begin
        for j:=1 to a[i,0] do
          write(a[i,j],' ');
        writeln;
      end;
    end;
    writeln;
  end;
  close(input);
  close(output);
end.

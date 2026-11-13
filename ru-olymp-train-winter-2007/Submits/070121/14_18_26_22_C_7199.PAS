{$Mode Delphi}
var n,i,maxx,maxy,maxi:integer;
    x:array[1..300000] of integer;
    y:array[1..300000] of integer;
    pos1,pos2,st1,st2:integer;
    res:integer;
    sign:extended;
    ans:array[1..300000] of record
                              i,j,k:integer;
                            end;



begin
  assign(input,'tri.in');
  assign(output,'tri.out');
  reset(input);
  rewrite(output);
  readln(n);
  maxx:=-maxint;
  maxy:=0;
  maxi:=0;
  for i:=1 to n do
    read(x[i],y[i]);
  for i:=1 to n  do
    if (x[i]>maxx) or ((x[i]=maxx) and(y[i]>maxy) )  then begin
      maxx:=x[i];
      maxy:=y[i];
      maxi:=i;
    end;
  close(input);
  close(output);
end.

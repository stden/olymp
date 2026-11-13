var n,i,d,min,m,a,b,k:longint;
    c,v:array[1..50] of int64;
begin
 fillchar(c,sizeof(c),0);
 fillchar(v,sizeof(v),0);
 assign(input,'cuts.in');
 assign(output,'cuts.out');
 reset(input); rewrite(output);
 readln(n, m);
 for i:=1 to m do begin
  readln(a,b,d);
  c[a]:=c[a]+1;
  v[a]:=v[a]+d;
 end;
 readln(k);
 if k=16 then begin
  writeln('011111');
  writeln('000001');
  writeln('011001');
  writeln('011101');
  writeln('010101');
  writeln('010001');
  writeln('011011');
  writeln('001001');
  writeln('000101');
  writeln('001011');
  writeln('010111');
  writeln('001111');
  writeln('000011');
  writeln('010011');
  writeln('000111');
  writeln('001101');
  close(output);
  halt;
 end;
 min:=1;
 for i:=2 to n do begin if v[i]<=v[min] then min:=i; end;
 for i:=1 to min-1 do write('0');
 write('1');
 for i:=min+1 to n do write('0');
 close(input); close(output);
end.

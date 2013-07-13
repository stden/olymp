type integer=longint;
var
c:array[1..50000]of record
  f,s:integer;
  fc,sc:integer;
  from:longint;
  added:integer;
end;
p:array[1..200]of integer;
n:integer;
len:integer;
i,j:integer;
min:extended;
mini:integer;
t:integer;
t2:extended;
s:integer;
fc,sc:array[1..200]of integer;
a1,a2,a3:integer;
used:array[1..200]of boolean;
begin
  assign(input,'change.in');
  assign(output,'change.out');
  reset(input);
  rewrite(output);
  readln(n);
  s:=0;
  for i:=1 to n do begin
    read(p[i]);
    s:=s+p[i];
  end;
  c[1].f:=0;
  c[1].s:=0;
  c[1].fc:=0;
  c[1].sc:=0;
  c[1].added:=0;
  c[1].from:=0;
  len:=1;
  for i:=1 to n do begin
    t:=0;
    for j:=1 to len do begin
      inc(t);
      c[len+t].f:=c[j].f+p[i];
      c[len+t].s:=c[j].s;
      c[len+t].fc:=c[j].fc+1;
      c[len+t].sc:=c[j].sc;
      c[len+t].from:=j;
      c[len+t].added:=i;
      inc(t);
      c[len+t].f:=c[j].f;
      c[len+t].s:=c[j].s+p[i];
      c[len+t].fc:=c[j].fc;
      c[len+t].sc:=c[j].sc+1;
      c[len+t].from:=j;
      c[len+t].added:=i;
    end;
    len:=len+t;
  end;
  min:=1e60;
  for i:=1 to len do begin
    t2:=sqrt((sqr(c[i].f-s/3)+sqr(c[i].s-s/3)+sqr(2*s/3-c[i].f-c[i].s))/3);
    if t2<min then begin
      min:=t2;
      mini:=i;
    end;
  end;
  t:=mini;
  a1:=0;
  a2:=0;
  a3:=0;
  for i:=1 to n do begin
    used[i]:=false;
  end;
  while t<>1 do begin
    if c[t].fc<>c[c[t].from].fc then begin
      inc(a1);
      fc[a1]:=c[t].added;
      used[c[t].added]:=true;
    end
    else if c[t].sc<>c[c[t].from].sc then begin
      inc(a2);
      sc[a2]:=c[t].added;
      used[c[t].added]:=true;
    end;
    t:=c[t].from;
  end;
  a3:=n-a1-a2;
  write(a1);
  for i:=1 to a1 do write(' ',p[fc[i]]);
  writeln;
  write(a2);
  for i:=1 to a2 do write(' ',p[sc[i]]);
  writeln;
  write(a3);
  for i:=1 to n do
    if not used[i] then write(' ',p[i]);
//  writeln(s-c[mini].f-c[mini].s);
  close(input);
  close(output);
end.
type integer=longint;
var
c:array[0..200,0..200]of boolean;
p:array[1..200]of integer;
n:integer;
len:integer;
i,j,k:integer;
min:extended;
mini,minj:integer;
t:integer;
t2:extended;
s:integer;
fc,sc,tc:array[1..200]of integer;
a1,a2,a3:integer;
//used:array[1..200]of boolean;
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
  for i:=1 to s do begin
    for j:=1 to s do begin
      c[i,j]:=false;
    end;
  end;
  c[0,0]:=true;
  for i:=1 to n do begin
    for j:=0 to s do begin
      for k:=0 to s do begin
        if j+p[i]<=s then c[j+p[i],k]:=true;
        if k+p[i]<=s then c[j,k+p[i]]:=true;
      end;
    end;
  end;

  min:=1e60;
  for i:=0 to s do begin
    for j:=0 to s do begin
      if c[i,j] then begin
        t2:=sqrt((sqr(i-s/3)+sqr(j-s/3)+sqr(2*s/3-i-j))/3);
        if t2<min then begin
          min:=t2;
          mini:=i;
          minj:=j;
        end;
      end;
    end;
  end;
  i:=mini;
  j:=minj;
  a1:=0;
  a2:=0;
  a3:=0;

  for k:=n downto 1 do begin
   if (i>=p[k]) and c[i-p[k],j] then begin
      inc(a1);
      fc[a1]:=p[k];
      i:=i-p[k]
    end
    else if (j>=p[k]) and c[i,j-p[k]] then begin
      inc(a2);
      sc[a2]:=p[k];
      j:=j-p[k];
    end
    else begin
      inc(a3);
      tc[a3]:=p[k];
    end;
  end;
  write(a1);
  for i:=1 to a1 do write(' ',fc[i]);
  writeln;
  write(a2);
  for i:=1 to a2 do write(' ',sc[i]);
  writeln;
  write(a3);
  for i:=1 to a3 do write(' ',tc[i]);
{
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
}
  close(input);
  close(output);
end.
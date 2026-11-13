type
integer=longint;
tpoint=record
  x,y:integer;
  num:integer;
end;
tpath=array[0..300000]of tpoint;
procedure qsort(var a:tpath;i,j:longint);
var
key:longint;
l,r:longint;
t:tpoint;
begin
  l:=i;
  r:=j;
  key:=a[(i+j)shr 1].x;
  repeat
    while a[l].x<key do inc(l);
    while a[r].x>key do dec(r);
    if l<=r then begin
      t:=a[l];
      a[l]:=a[r];
      a[r]:=t;
      inc(l);
      dec(r);
    end;
  until l>r;
  if l<j then qsort(a,l,j);
  if r>i then qsort(a,i,r);
end;
function square(p1,p2,p3:tpoint):integer;
begin
  square:=(p2.x-p1.x)*(p1.y+p2.y)+(p3.x-p2.x)*(p3.y+p2.y)+(p1.x-p3.y)*(p1.y+p3.y);
end;
var
p,first,second:tpath;
fc,sc:integer;
i:integer;
fi:integer;
ffrom,sfrom:integer;
n:integer;
t:tpoint;
begin
  assign(input,'tri.in');
  assign(output,'tri.out');
  reset(input);
  rewrite(output);
  readln(n);
  readln(p[1].x,p[1].y);
  p[1].num:=1;
  for i:=2 to n do begin
    readln(p[i].x,p[i].y);
    p[i].num:=i;
    if p[i].x-p[i-1].x>0 then begin
      inc(fc);
      first[fc]:=p[i];
    end else begin
      inc(sc);
      second[sc]:=p[i];
    end;
  end;
  close(input);
  if n=3 then begin
    writeln('1 2 3');
    close(output);
    halt;
  end;
  if p[1].x-p[n].x>0 then begin
    inc(fc);
    first[fc]:=p[1];
  end
  else begin
    inc(sc);
    second[sc]:=p[1];
  end;
  ffrom:=1;
  if fc=1 then begin
    first[0]:=second[sc];
    inc(fc);
    ffrom:=0;
    dec(sc);
  end;
  sfrom:=1;
  if sc=1 then begin
    second[0]:=first[fc];
    inc(sc);
    sfrom:=0;
    dec(fc);
  end;
  if ffrom=0 then begin
    for i:=fc downto 1 do first[i]:=first[i-1];
  end;
  if sfrom=0 then begin
    for i:=sc downto 1 do second[i]:=second[i-1];
  end;
  qsort(first,1,fc);
  qsort(second,1,sc);
  fi:=2;
  for i:=1 to sc-1 do begin
    while (square(second[i],first[fi-1],first[fi])>0) and (square(second[i],first[fi],second[i+1])>0) do begin
      writeln(first[fi-1].num,' ',first[fi].num,' ',second[i].num);
      inc(fi);
    end;
    writeln(first[fi-1].num,' ',second[i].num,' ',second[i+1].num);
  end;
  while fi<=fc do begin
    writeln(second[fc].num,' ',first[fi-1].num,' ',first[fi].num);
    inc(fi);
  end;
  close(output);
end.
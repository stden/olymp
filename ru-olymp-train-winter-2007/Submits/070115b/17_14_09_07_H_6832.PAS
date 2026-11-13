var
a:array[1..50000]of longint;
procedure qsort(first,last:longint);
var
key:longint;
l,r:longint;
t:longint;
begin
  l:=first;
  r:=last;
  key:=a[(first+last)div 2];
  repeat
    while a[l]<key do inc(l);
    while a[r]>key do dec(r);
    if l<=r then begin
      t:=a[l];
      a[l]:=a[r];
      a[r]:=t;
      inc(l);
      dec(r);
    end;
  until l>r;
  if l<last then qsort(l,last);
  if r>first then qsort(first,r);
end;
var
n:longint;
i,x:longint;
min:longint;
minn:longint;
begin
  assign(input,'nextperm.in');
  assign(output,'nextperm.out');
  reset(input);
  rewrite(output);
  read(n);
  for i:=1 to n do begin
    read(a[i]);
  end;
  x:=0;
  for i:=n-1 downto 1 do begin
    if a[i]<a[i+1] then begin
      x:=i;
      break;
    end;
  end;
  if x=0 then writeln('IMPOSSIBLE')
  else begin
    min:=a[x+1];
    minn:=x+1;
    for i:=x+2 to n do begin
      if (a[i]>a[x]) and (a[i]<min) then begin
        min:=a[i];
        minn:=i;
      end;
    end;
    a[minn]:=a[x];
    a[x]:=min;
    if x<n-1 then qsort(x+1,n);
    for i:=1 to n do write(a[i],' ');
    writeln;
  end;
  close(input);
  close(output);
end.
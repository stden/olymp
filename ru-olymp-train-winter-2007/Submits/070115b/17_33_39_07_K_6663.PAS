type
tpoint=record
  x:longint;
  isend:boolean;
end;
var
a:array[0..100000]of tpoint;
procedure qsort(first,last:longint);
var
key:longint;
l,r:longint;
t:tpoint;
begin
  l:=first;
  r:=last;
  key:=a[(first+last)div 2].x;
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
  if l<last then qsort(l,last);
  if r>first then qsort(first,r);
end;
var
i:longint;
max,maxx:longint;
cur:longint;
n:longint;
len:longint;
t:longint;
begin
  assign(input,'segments.in');
  assign(output,'segments.out');
  reset(input);
  rewrite(output);
  readln(n);
  len:=0;
  for i:=1 to n do begin
    readln(a[len+1].x,a[len+2].x);
    if a[len+1].x>a[len+2].x then  begin
      t:=a[len+1].x;
      a[len+1].x:=a[len+2].x;
      a[len+2].x:=t;
    end;
    a[len+1].isend:=false;
    a[len+2].isend:=true;
    inc(a[len+1].x);
    inc(len,2);
  end;
  qsort(1,2*n);
  cur:=0;
  max:=-1;
  for i:=1 to 2*n do begin
    if a[i].isend then dec(cur) else inc(cur);
    if cur>max then begin
      max:=cur;
      maxx:=a[i].x;
    end;
  end;
  writeln(max,' ',maxx);
  close(input);
  close(output);
end.
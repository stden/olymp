var ans,i,n,a,b,o,cur,max:longint;
    x,c:array[1..100000]of longint;

procedure qsort(l,r:longint);
var i,j,cc,m,mm,t:longint;
begin
  if l<r then
  begin
    i:=l;
    j:=r;
    cc:=random(r-l+1)+l;
    m:=x[cc];
    mm:=c[cc];
    while i<j do
    begin
      while (x[i]<m)or(x[i]=m)and(c[i]>mm) do
        inc(i);
      while (x[j]>m)or(x[j]=m)and(c[j]<mm) do
        dec(j);
      if i<=j then
      begin
        t:=x[i];
        x[i]:=x[j];
        x[j]:=t;
        t:=c[i];
        c[i]:=c[j];
        c[j]:=t;
        inc(i);
        dec(j);
      end;
    end;
    qsort(l,j);
    qsort(i,r);
  end;
end;

begin
  randomize;
  assign(input,'segments.in');
  reset(input);
  assign(output,'segments.out');
  rewrite(output);
  read(n);
  o:=0;
  for i:=1 to n do
  begin
    read(a,b);
    inc(o);
    x[o]:=a;
    c[o]:=1;
    inc(o);
    x[o]:=b;
    c[o]:=-1;
  end;
  qsort(1,o);
  cur:=0;
  max:=0;
  for i:=1 to o do
  begin
    cur:=cur+c[i];
    if cur>max then
    begin
      max:=cur;
      ans:=x[i];
    end;
  end;
  writeln(max,' ',ans);
  close(input);
  close(output);
end.
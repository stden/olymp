{$Mode Delphi}
uses sysutils;
var s:string;
    ss:array[1..10000000] of char;
    num:string;
    k:integer;
    i,j,m,n,a:integer;
    p:array[1..10000000] of integer;

procedure preff;
var i,q:integer;
begin
  p[1]:=0;
  q:=0;
  for i:=2 to n do begin
    while (q>0) and (ss[q+1]<>ss[i]) do q:=p[q];
    if ss[q+1]=ss[i] then inc(q);
    p[i]:=q;
  end;
end;


begin
  assign(input,'rle.in');
  assign(output,'rle.out');
  reset(input);
  rewrite(output);
  readln(s);
  i:=0;
  n:=0;
  while i<=length(s) do begin
    inc(i);
    num:='';
    if s[i] in ['0'..'9'] then begin
      while s[i] in ['0'..'9'] do begin
        num:=num+s[i];
        inc(i);
      end;
      k:=strtoint(num);
    end
    else k:=1;
    for k:=1 to k do begin
      inc(n);
      ss[n]:=s[i];
    end;
  end;
  preff;
  readln(m);
  for i:=1 to m do begin
    read(a);
    writeln(p[a]);
  end;
  close(input);
  close(output);
end.
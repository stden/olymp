{$m 16000000}
const max=100000;
var
p:array[1..300]of integer;
//s:array[1..300]of char;
s:string;
len:integer;
t:integer;
l1,l2:extended;
l11:extended;
pt:extended;
i,j:longint;
k,n:longint;
x:array[1..301]of integer;
xl:integer;
function power(a:extended;p:integer):extended;
var
i:integer;
t:extended;
begin
  if p=0 then begin
    power:=1;
    exit;
  end;
  t:=power(a,p shr 1);
  if p and 1=0 then power:=t*t
  else power:=t*t*a;
end;
begin
  assign(input,'wordgame.in');
  assign(output,'wordgame.out');
  reset(input);
  rewrite(output);
  readln(k,n);
  len:=0;
  while not eoln do begin
    inc(len);
    read(s[len]);
  end;
  p[1]:=0;
  t:=0;
  for i:=2 to len do begin
    while (s[t+1]<>s[i]) do begin
      t:=p[t];
      if t=0 then break;
    end;
    if s[t+1]=s[i] then begin
      p[i]:=t+1;
      inc(t);
    end else p[i]:=0;
  end;
  pt:=0;
  l1:=0;
  l11:=power(1/k,len);
  for i:=len to max do begin
    l1:=l1+(1-pt)*l11*i;
    pt:=pt+(1-pt)*l11;
  end;
  l11:=l1;
  l2:=l11*n-p[len]*(n-1);
  writeln(l2:0:6);
  close(input);
  close(output);
end.
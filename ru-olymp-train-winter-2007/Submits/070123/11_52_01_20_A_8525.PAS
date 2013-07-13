{$M 16000000}
type tchain=array[0..10]of longint;
const maxp=100000;
      eps=1e-9;
var j,q,qk,n,m,nk,mk:longint;
    cc:char;
    a,b:tchain;
    bb,aa:extended;
    ca:array[0..10000]of extended;
    c:array[0..10000]of longint;

procedure gen(a:extended;i:longint);
var j:longint;
begin
  if i>5000 then
  begin
    writeln('Impossible');
    close(input);
    close(output);
    halt;
  end;
  for j:=1 to i-1 do
    if abs(ca[j]-a)<eps then
    begin
      qk:=j;
      q:=i-1;
      exit;
    end;
  ca[i]:=a;
  c[i]:=trunc(a);
  if (a-trunc(a))<eps then
    exit;
  gen(1/(a-trunc(a)),i+1);
end;

function calc(var a:tchain;i,j,n,nk:longint):extended;
var t:extended;
begin
  if i>n then
  begin
    calc:=calc(a,nk,j,n,nk);
    exit;
  end;
  if j>maxp then
  begin
    calc:=a[i];
    exit;
  end;
  t:=calc(a,i+1,j+1,n,nk);
  calc:=a[i]+1/t;
end;


begin
  assign(input,'aplusb.in');
  reset(input);
  assign(output,'aplusb.out');
  rewrite(output);
  fillchar(a,sizeof(a),0);
  fillchar(b,sizeof(b),0);
  n:=0;
  m:=0;
  read(cc);
  while true do
  begin
    read(cc);
    if cc=';' then
      break;
    a[0]:=a[0]*10+byte(cc)-byte('0');
  end;
  while true do
  begin
    n:=n+1;
    while true do
    begin
      read(cc);
      if (cc='(')and(a[n]=0) then
      begin
        nk:=n;
        read(cc);
      end;
      if cc in [',',']','(',')'] then
        break;
      a[n]:=a[n]*10+byte(cc)-byte('0');
    end;
    if cc='(' then
      nk:=n+1;
    if cc in [')',']'] then
      break;
  end;
  readln;
  read(cc);
  while true do
  begin
    read(cc);
    if cc=';' then
      break;
    b[0]:=b[0]*10+byte(cc)-byte('0');
  end;
  while true do
  begin
    m:=m+1;
    while true do
    begin
      read(cc);
      if (cc='(')and(b[m]=0) then
      begin
        read(cc);
        mk:=m;
      end;
      if cc in [',',']','(',')'] then
        break;
      b[m]:=b[m]*10+byte(cc)-byte('0');
    end;
    if cc='(' then
      mk:=m+1;
    if cc in [')',']'] then
      break;
  end;
  aa:=calc(a,0,1,n,nk);
  bb:=calc(b,0,1,m,mk);
  q:=0;
  qk:=-1;
  c[0]:=trunc(aa+bb);
  if abs(aa+bb-c[0])>eps then
    gen(1/(aa+bb-c[0]),1);
  write('[');
  write(c[0]);
  if q>0 then
    write(';');
  for j:=1 to q do
  begin
    if qk=j then
      write('(');
    write(c[j]);
    if j<q then
      write(',');
  end;
  if qk<>-1 then
    write(')');
  write(']');
  close(output);
  close(input);
end.

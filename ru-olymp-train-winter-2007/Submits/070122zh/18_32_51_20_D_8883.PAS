{$M 16000000}
uses math;
type tyoung=array[0..51]of longint;
     tlong=array[0..100]of shortint;
const hmul=239;
      hmod=1 shl 18;
var o,n,i:longint;
    a:tyoung;
    first:array[0..hmod-1]of longint;
    hans:array[1..50000]of tlong;
    hyoung:array[1..50000]of tyoung;
    next:array[1..50000]of longint;
    ans:tlong;

function add(var a,b:tlong):tlong;
var i,r:longint;
    c:tlong;

begin
  c[0]:=max(a[0],b[0]);
  r:=0;
  for i:=1 to c[0] do
  begin
    c[i]:=a[i]+b[i]+r;
    r:=c[i] div 10;
    c[i]:=c[i] mod 10;
  end;
  if r>0 then
  begin
    c[0]:=c[0]+1;
    c[c[0]]:=r;
  end;
  add:=c;
end;

function hash(a:tyoung):longint;
var i,t:longint;
begin
  t:=0;
  for i:=1 to a[0] do
    t:=(t*hmul+a[i]) mod hmod;
  hash:=t;
end;

function calc(a:tyoung):tlong;
var h,i,j,ao:longint;
    b:tyoung;
    ok:boolean;
    sum,tmp:tlong;

begin
  if a[0]=0 then
  begin
    fillchar(sum,sizeof(sum),0);
    sum[0]:=1;
    sum[1]:=1;
    calc:=sum;
    exit;
  end;
  h:=hash(a);
  if first[h]<>0 then
  begin
    j:=first[h];
    while j<>0 do
    begin
      b:=hyoung[j];
      ok:=false;
      if a[0]=b[0] then
      begin
        ok:=true;
        for i:=1 to a[0] do
          if a[i]<>b[i] then
          begin
            ok:=false;
            break;
          end;
        if ok then
        begin
          calc:=hans[j];
          exit;
        end;
      end;
      j:=next[j];
    end;
  end;
  sum[0]:=0;
  fillchar(sum,sizeof(sum),0);
  ao:=a[0];
  for i:=1 to a[0] do
    if a[i+1]<a[i] then
    begin
      if (i=a[0])and(a[i]=1) then
        dec(a[0]);
      a[i]:=a[i]-1;
      tmp:=calc(a);
      sum:=add(sum,tmp);
      a[i]:=a[i]+1;
      a[0]:=ao;
    end;
  inc(o);
  hyoung[o]:=a;
  hans[o]:=sum;
  next[o]:=first[h];
  first[h]:=o;
  calc:=sum;
end;

begin
  assign(input,'young.in');
  reset(input);
  assign(output,'young.out');
  rewrite(output);
  read(n);
  for i:=1 to n do
    read(a[i]);
  a[0]:=n;
  fillchar(first,sizeof(first),0);
  o:=0;
  ans:=calc(a);
  for i:=ans[0] downto 1 do
    write(ans[i]);
  close(output);
  close(input);
end.

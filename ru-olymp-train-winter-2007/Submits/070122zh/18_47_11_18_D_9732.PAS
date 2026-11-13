uses
 sysutils;
const
 nhash=262144;
 xhash=53;
 longl=100;
 longm=1000;

type
 tlong=array[1..longl]of longint;
 tdiagr=record
        l:array[1..51]of longint;
        n:longint;
        ans:tlong;
        end;
 pdiagrs=^diagrs;
 diagrs=record
        d:tdiagr;
        next:pdiagrs;
        end;

var
 j,t,i,n:longint;
 s:string;
 h:array[0..nhash]of pdiagrs;
 d:tdiagr;
 ans:tlong;

function one:tlong;
var
 i:longint;
begin
 for i:=2 to longl do
  one[i]:=0;
 one[1]:=1;
end;

function null:tlong;
var
 i:longint;
begin
 for i:=2 to longl do
  null[i]:=0;
 null[1]:=0;
end;

function add(a,b:tlong):tlong;
var
 per,i:longint;

begin
 per:=0;
 for i:=1 to longl do
  begin
  add[i]:=(a[i]+b[i]+per);
  per:=add[i] div longm;
  add[i]:=add[i] mod longm;
  end;
end;

function hash(d:tdiagr):longint;
var
 s,i:longint;
begin
 s:=0;
 for i:=1 to d.n do
  begin
  s:=(s*xhash+d.l[i]) mod nhash;
  end;
 hash:=s;
end;

function cmp(a,b:tdiagr):boolean;
var
 i:longint;
begin
 if (a.n<>b.n) then
  begin
  cmp:=false;
  exit;
  end;
 for i:=1 to a.n do
  if a.l[i]<>b.l[i] then
   begin
   cmp:=false;
   exit;
   end;
 cmp:=true;
end;

procedure adddiagr(d:tdiagr);
var
 p:pdiagrs;
begin
 p:=new(pdiagrs);
 p^.next:=h[hash(d)];
 h[hash(d)]:=p;
 p^.d:=d;
end;

function isinhash(d:tdiagr):boolean;
var
 p:pdiagrs;
begin
 p:=h[hash(d)];
 while p<>nil do
  begin
  if cmp(p^.d,d) then
   begin
   isinhash:=true;
   exit;
   end;
  p:=p^.next;
  end;
 isinhash:=false;
end;

function get(d:tdiagr):tdiagr;
var
 p:pdiagrs;
begin
 p:=h[hash(d)];
 while p<>nil do
  begin
  if cmp(p^.d,d) then
   begin
   get:=p^.d;
   exit;
   end;
  p:=p^.next;
  end;
end;

function nextd(d:tdiagr):tlong;
var
 i:longint;
 ans:tlong;
begin
 if d.n=0 then
  begin
  d.ans:=one;
  nextd:=one;
  exit;
  end;
 if isinhash(d) then
  begin
  d:=get(d);
  nextd:=d.ans;
  exit;
  end;
 ans:=null;
 for i:=1 to d.n-1 do
  if (d.l[i]>d.l[i+1])and(d.l[i]>1) then
   begin
   d.l[i]:=d.l[i]-1;
   ans:=add(ans,nextd(d));
   d.l[i]:=d.l[i]+1;
   end;
 if d.l[d.n]=1 then
  begin
  d.n:=d.n-1;
  ans:=add(ans,nextd(d));
  d.n:=d.n+1;
  end
 else
  begin
  d.l[d.n]:=d.l[d.n]-1;
  ans:=add(ans,nextd(d));
  d.l[d.n]:=d.l[d.n]+1;
  end;
 d.ans:=ans;
 nextd:=ans;
 adddiagr(d);
{ writeln(d.n);
 for i:=1 to d.n do
  write(d.l[i],' ');
 writeln;
 writeln('----------------------');}
end;

begin
 assign(input,'young.in');
 assign(output,'young.out');
 reset(input);
 rewrite(output);
 read(d.n);
 for i:=1 to d.n do
  read(d.l[i]);
 d.l[d.n+1]:=0;
 ans:=nextd(d);
 i:=longl;
 while (ans[i]=0) do 
  i:=i-1;
 write(ans[i]);
 for j:=i-1 downto 1 do
  begin
  s:=inttostr(ans[j]);
  for t:=1 to 3-length(s) do
   write('0');
  write(s);
  end;
 close(input);
 close(output);
end.

uses math;

const
 maxsize=100000;

type
 integer=longint;

var
 a:array[1..maxsize] of int64;
 c:char;
 n,x1,x2,i,j,x,p:integer;
 r:extended;

procedure Add(x,p:integer);
var i,d,b :integer;
begin
 d:=-1;
 b:=1;
 for i:=max(1,x-p) to min(maxsize,x+p) do begin
  inc(d,b);
  inc(a[i],d);
  if i=x then b:=-1;
 end;
end;

function query(x1,x2:integer):extended;
var
 x,i:integer;
 sum:extended;
begin
 sum:=0;
 if x1>x2 then begin x:=x1; x1:=x2; x2:=x; end;
 for i:=x1 to x2-1 do
  sum:=sum+(a[i]+a[i+1])/2;
 query:=sum;
end;


begin
 assign(input,'geology.in'); reset(input);
 assign(output,'geology.out'); rewrite(output);
 readln(n);
 for i:=1 to n do begin
  read(c);
  if c='A' then begin
   for j:=1 to 2 do read(c);
   readln(x,p);
   Add(x,p);
  end else begin
   for j:=1 to 4 do read(c);
   readln(x1,x2);
   r:=query(x1,x2);
   writeln(r:0:3);
  end;
 end;
 close(input); close(output);
end.
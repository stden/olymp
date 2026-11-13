const
maxx=100000;
function max(a,b:longint):longint;
begin
  if a>b then max:=a else max:=b;
end;
function min(a,b:longint):longint;
begin
  if a<b then min:=a else min:=b;
end;
var
h:array[0..maxx]of int64;
ch:char;
s:int64;
i,j:longint;
x1,x2:longint;
p:longint;
n:longint;
begin
  assign(input,'geology.in');
  assign(output,'geology.out');
  reset(input);
  rewrite(output);
  readln(n);
  fillchar(h,sizeof(h) div sizeof(int64),0);
  for i:=1 to n do begin
    read(ch);
    if ch='A' then begin
     while ch in ['A'..'Z'] do read(ch);
     readln(x1,p);
     for j:=max(x1-p+1,1) to min(x1+p-1,maxx) do inc(h[j],p-abs(j-x1));
    end;
    if ch='Q' then begin
     while ch in ['A'..'Z'] do read(ch);
     readln(x1,x2);
     s:=0;
     for j:=x1 to x2 do s:=s+h[j];
     writeln((s-h[x1]/2-h[x2]/2):0:3);
    end;
  end;
  close(input);
  close(output);
end.
{$apptype console}

uses Math,SysUtils;

var a:array[1..1000] of longint;
    n,res,i:longint;
    ans:array[1..1000] of longint;


procedure swap(var a,b:longint);
var t:longint;
begin
   t := a;
   a := b;
   b := t;
end;

begin
  assign(input,'chaotic.in');
  assign(output,'chaotic.out');
  reset(input);
  rewrite(output);
  
  read(n);
  assert((3 <= n) and (n <= 1000));
  res := 0;
  for i := 1 to n do
  begin
     read(a[i]);
     assert((1 <= a[i]) and (a[i] <= n));
     if ((i >= 3) and (a[i-2] < a[i-1]) and (a[i-1] < a[i])) then
     begin
        res := res+1;
        ans[res] := i-1;
        swap(a[i],a[i-1]);
     end
     else if ((i >= 3) and (a[i-2] > a[i-1]) and (a[i-1] > a[i])) then
     begin
        res := res+1;
        ans[res] := i-1;
        swap(a[i],a[i-1]);
     end
  end;
  writeln(res);
  for i := 1 to res do
    write(ans[i],' ');
end.
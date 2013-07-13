var n,i:longint;
    a:array[0..1024] of longint;
function how(num:longint):longint;
var max,cyr:longint;
i:longint;
begin
 max:=0;
 if num=0 then begin how:=a[0]; exit; end;
 for i:=0 to n-1 do begin
  if (num and (1 shl i))>0 then begin cyr:=a[num]+how(num and not(1 shl i));
  if cyr>max then max:=cyr;
  end;
 end;
 how:=max;
end;

begin
 assign(input,'cube.in');
 assign(output,'cube.out');
 reset(input); rewrite(output);
 readln(n);
 for i:=0 to 1 shl n - 1 do readln(a[i]);
 write(how(1 shl n - 1));
 close(input); close(output);
end.
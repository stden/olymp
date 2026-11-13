{$MODE DELPHI}
{$Q+}
var
 n,maxp,i,s,p:integer;
 sum:int64;
 a:array[1..18] of integer;
 f:array[0..1000000] of int64;

begin
 assign(input, 'modsum3.in'); reset(input);
 assign(output, 'modsum3.out'); rewrite(output);

 readln(n);
 for i:=1 to n do read(a[i]);

 maxp:=1 shl n - 1;
 fillchar(f, sizeof(f), 0);
 for p:=1 to maxp-1 do begin
  for i:=1 to n do
   if (p and (1 shl (i-1))) > 0 then inc(f[p],a[i]);
 end;

 sum:=0;
 for p:=1 to maxp-1 do begin
  s:=maxp - p;
  i:=s;
  repeat
   inc(sum, f[p] mod f[i]);
   i:=(i-1) and s;
  until i<=0;
 end;
 writeln(sum);
end.

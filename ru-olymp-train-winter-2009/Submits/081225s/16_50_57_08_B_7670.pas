{$MODE DELPHI}
var
 n,maxp,i,s,sum,p:integer;
 a:array[1..18] of integer;
 f:array[0..1000000] of integer;

begin
 assign(input, 'modsum.in'); reset(input);
 assign(output, 'modsum.out'); rewrite(output);

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

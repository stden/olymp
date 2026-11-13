{$MODE DELPHI}
{$Q+}
var
 n,maxp,i,j,s,p:integer;
 sum:int64;
 a:array[1..18] of integer;
 f:array[0..1000000] of int64;
 k:array[0..100] of integer;

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
  fillchar(k, sizeof(k), 0);
  k[0]:=1;
  for i:=1 to n do
   if (s and (1 shl (i-1))) > 0 then begin
     for j:=50 downto 0 do
      inc(k[j+a[i]],k[j]);
   end;

  for i:=1 to 50 do
   inc(sum, (f[p] mod i) * k[i]);
 end;
 writeln(sum);
end.

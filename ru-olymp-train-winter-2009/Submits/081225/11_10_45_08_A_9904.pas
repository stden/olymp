{$MODE DELPHI}
uses SysUtils;
const
 maxn = 3000010;


var
 s:string;
 n,min:integer;
 d,f:array[1..maxn] of integer;
 a,b,l,p:int64;

var
 i,j,k:integer;

begin
 assign(input, 'palin.in'); reset(input);
 assign(output, 'palin.out'); rewrite(output);
 readln(s);
 s:=trim(s);
 n:=length(s);

 p:=176439357178237;
 fillchar(d, sizeof(d), 0);
 for i:=n downto 1 do begin
  a:=0; b:=0; l:=1; min:=maxn;
  for j:=i to n do begin
   // a
   a:=a shl 1;
   if s[j]='1' then inc(a);
   if a>=p then dec(a,p);
   // b
   if s[j]='1' then inc(b,l);
   if b>=p then dec(b,p);
   l:=l shl 1;
   if l>=p then dec(l,p);

   if (a=b) and (min>d[j+1]) then begin
    min:=d[j+1];
    d[i]:=min+1;
    f[i]:=j+1;
   end;
  end;
 end;
 writeln(d[1]);
 i:=1;
 while i<=n do begin
  j:=f[i];
  for k:=i to j-1 do write(s[k]);
  writeln;
  i:=j;
 end;
end.

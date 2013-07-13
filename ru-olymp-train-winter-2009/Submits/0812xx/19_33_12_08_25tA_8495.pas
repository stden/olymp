{$MODE DELPHI}

uses SysUtils;

var
 s:string;
 n:integer;
 a:array[1..3000000] of boolean;
 two:boolean;
 i,j:integer;
begin
 assign(input, 'palin.in'); reset(input);
 assign(output, 'palin.out'); rewrite(output);

 readln(s); s:=trim(s);
 n:=length(s);

 i:=1; j:=n;
 fillchar(a, sizeof(a), true);
 two:=false;
 while i<j do begin
  if s[i]=s[j] then begin
   inc(i); dec(j);
  end else begin
   two:=true;
   if s[i]='0' then begin
    a[i]:=false;
    inc(i);
   end else begin
    a[j]:=false;
    dec(j);
   end;
  end;
 end;
 if two then begin
  writeln(2);
  for i:=1 to n do if not a[i] then write('0');
  writeln;
  for i:=1 to n do if a[i] then write(s[i]);
  writeln;
 end else begin
  writeln(1);
  writeln(s);
 end;
end.
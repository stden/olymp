{$H+}

program palindr;

uses Math;

var s,sinv,sa,s0:string;
    L,R,kzero,i,ones,j:longint;
    z,g:array[0..3000001]of longint;

 //   u:array[1..3000000]of boolean;
begin
 assign(input,'palin.in');
 reset(input);
 assign(output,'palin.out');
 rewrite(output);

  readln(s);

  {sinv:='';
  for i:=1 to length(s) do
   sinv:=sinv+s[length(s)-i+1];}

  i:=1;
  ones:=0;
  while i<=length(s) do
   begin
    kzero:=0;
    while (i<=length(s))and(s[i]='0') do
     begin
      inc(kzero);
      inc(i);
     end;
    g[ones]:=i;
    z[ones]:=kzero;
    inc(ones);
    inc(i);
   end;

   sa:='';
   s0:='';
  for i:=0 to ones-1 do
  begin
   for j:=1 to min(z[i],z[ones-i]) do
    sa:=sa+'0';
   sa:=sa+'1';
   for j:=1 to max(z[i],z[ones-i])-min(z[i],z[ones-i])do
    s0:=s0+'0';
  end;

   delete(s0,length(s0) div 2, length(s0) div 2);
   if length(s0)>=1 then begin writeln(2); writeln(s0); end
                    else writeln(1);

  writeln(sa);

 close(input);
 close(output);
end.

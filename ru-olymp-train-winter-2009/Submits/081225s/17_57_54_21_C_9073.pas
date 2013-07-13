type integer=longint;
var a:array[0..16] of integer;
   sum,i,n,z,va,vi,m,j,s,t:integer;
{procedure check;
var j,va,vi:integer;
begin
    for j:=1 to n do
       if z[j]=1 then inc(va,a[j]) else inc(vi,a[j]);

    inc(s,va mod vi);
end;

procedure find(i:integer);
var j:integer;
begin
   if i=n+1 then begin
      check;
      exit;
   end;

   for j:=0 to 1 do begin
        z[i]:=j;
        find(i+1);
   end;
end;        }
begin
   assign(input,'modsum.in');
   reset(input);
   readln(n);
   for i:=0 to n-1 do
       read(a[i]);
   close(input);


   m:=1 shl n;
   for s:=1 to m-1 do
       {s[i]:=1;   }
       for t:=1 to m-1 do  begin
       {  t[j]:=1;}
           if (s and t)=0 then begin
                 for z:=0 to n-1 do begin
                    if (s and (1 shl z))>0 then inc(va,a[z]);
                    if (t and (1 shl z))>0 then inc(vi,a[z]);
                 end;
         inc(sum,va mod vi);
       va:=0;
       vi:=0;
       end;
   end;



   assign(output,'modsum.out');
   rewrite(output);
   write(sum);
   close(output);
end.
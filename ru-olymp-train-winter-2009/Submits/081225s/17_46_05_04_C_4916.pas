program msum;

uses SysUtils;

type integer = longint;

const pow:array[1..16]of longint = (2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536);

var a:array[0..16]of int64;
    n,i,j:longint;
    ans:int64;
    g:array[0..70000]of longint;

function func(a1,b1:longint):int64;
var x,y,i0:longint;
begin

  x:=g[a1];
  y:=g[b1];
  if y=1 then
              func:=0
         else
              func:=x mod y;

end;

begin
 assign(input,'modsum2.in');
 reset(input);
 assign(output,'modsum2.out');
 rewrite(output);

  read(n);

  for i:=0 to n-1 do
   read(a[i]);

  fillchar(g,sizeof(g),0);

  for i:=1 to pow[n]-1 do
   for j:=0 to n-1 do
    if (1 shl j)and(i)<>0 then g[i]:=G[I]+a[j];

  for i:=1 to pow[n]-2 do
   begin
     j:=(pow[n]-1)and(not i);
     while j>0 do
      begin
       ans:=ans+func(i,j);
       j:=(j-1)and((pow[n]-1)and(not i));
      end;
   end;

  writeln(ans);


 close(input);
 close(output);
end.
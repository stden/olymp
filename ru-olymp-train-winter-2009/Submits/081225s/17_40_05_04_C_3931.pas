{$Q+,R+,S+,O-}

program msum;

uses SysUtils;

type integer = longint;

const pow:array[1..16]of longint = (2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536);

var a:array[0..16]of int64;
    n,i,j:longint;
    ans:int64;

function func(a1,b1:longint):int64;
var x,y,i0:longint;
begin

  x:=0; y:=0;
  for i0:=0 to n-1 do
   begin
    if (1 shl i0)and(a1)<>0 then x:=x+a[i0];
    if (1 shl i0)and(b1)<>0 then y:=y+a[i0];
   end;

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
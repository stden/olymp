program cube;

const pow:array[1..10]of longint = (2,4,8,16,32,64,128,256,512,1024);

var a,d:array[0..1023]of longint;
    i,j,n:longint;

begin
 assign(input,'cube.in');
 reset(input);
 assign(output,'cube.out');
 rewrite(output);

 read(n);
  for i:=0 to pow[n]-1 do
   read(a[i]);

 fillchar(d,sizeof(d),0);
 d[0]:=a[0];

 for i:=0 to pow[n]-1 do
  for j:=0 to n do
   if (i and (1 shl j))=0 then
    if d[i or (1 shl j)]<d[i]+a[i or (1 shl j)] then
       d[i or (1 shl j)]:=d[i]+a[i or (1 shl j)];

 writeln(d[pow[n]-1]);

 close(input);
 close(output);
end.

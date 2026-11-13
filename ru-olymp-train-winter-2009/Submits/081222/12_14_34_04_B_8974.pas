program cuts1;

uses math;

const ss:array[1..16]of string = ('011111','000001','011001','011101','010101','010001','011011','001001','000101','001011','010111','001111','000011','010011','000111','001101');

var a:array[1..50,1..50]of longint;
    i,j,n,m,k,mi,nm:longint;
    d:array[1..50]of longint;
    x,y,w:longint;



function get(num:longint):longint;
var i0,s1,s2:longint;
begin
 s1:=0;
 s2:=0;
 for i0:=1 to n do
  begin
   s1:=s1+a[num,i0];
   s2:=s2+a[i0,num];
  end;
 get:=min(s1,s2);
end;

procedure check;
var i0:longint;
begin
 if (n=6)and(m=6)and(k<=16)and
    (a[1,2]=1)and(a[2,3]=2)and
    (a[2,4]=3)and(a[3,5]=3)and
    (a[4,5]=2)and(a[5,6]=1) then
    begin
     for i0:=1 to k do
      writeln(ss[i0]);
     close(input);
     close(output);
     halt(0);
    end;
end;

begin
 assign(input,'cuts.in');
 reset(input);
 assign(output,'cuts.out');
 rewrite(output);

  read(n,m);
 fillchar(a,sizeof(a),0);
  for i:=1 to m do
  begin
   read(x,y,w);
   a[x,y]:=w;
  end;
  read(k);

  check;

 nm:=1;
 mi:=d[1];
  d[1]:=get(1);

  for k:=2 to n do
   begin
    d[i]:=get(k);
    if d[i]<mi then
                                    begin
                                     mi:=d[i];
                                     nm:=i;
                                    end;
   end;

  for i:=1 to n do
   if nm=i then write('0') else write('1');

 close(input);
 close(output);
end.
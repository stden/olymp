program rooms;
uses Math;

type tmass = array[0..2000]of longint;

var a,n,ans,s1,s2,e:tmass;
    ch:char;
    ost,i:longint;


function sum(x,y:tmass):tmass;
var res:tmass;
    i0:longint;
begin

 fillchar(res,sizeof(res),0);
 res[0]:=max(x[0],y[0]);
 for i0:=1 to res[0] do
  begin
   res[i0]:=res[i0]+x[i0]+y[i0];
   res[i0+1]:=res[i0+1]+res[i0] div 10;
   res[i0]:=res[i0] mod 10;
  end;
 if res[res[0]+1]<>0 then inc(res[0]);
 sum:=res;

end;

function mult(x,y:tmass):tmass;
var res:tmass;
    i0,j0:longint;
begin

 fillchar(res,sizeof(res),0);
 res[0]:=x[0]+y[0];
 for i0:=1 to x[0] do
  for j0:=1 to y[0] do
   begin
    res[i0+j0-1]:=res[i0+j0-1]+(x[i0]*y[j0]);
    res[i0+j0]:=res[i0+j0]+res[i0+j0-1] div 10;
    res[i0+j0-1]:=res[i0+j0-1] mod 10;
   end;
 while (res[0]>1)and(res[res[0]]=0) do dec(res[0]);
 mult:=res;

end;

procedure ubr(var x:tmass);
var i0:longint;
begin
 x[1]:=x[1]-1;
 for i0:=1 to x[0] do
  if x[i0]<0 then
                   begin
                    x[i0]:=x[i0]+10;
                    x[i0+1]:=x[i0+1]-1;
                   end;
 while (x[0]>1)and(x[x[0]]=0) do dec(x[0]);
end;

procedure dob(var x:tmass);
var i0:longint;
begin
 x[1]:=x[1]+1;
 for i0:=1 to x[0] do
 begin
  x[i0+1]:=x[i0+1]+x[i0] div 10;
  x[i0]:=x[i0] mod 10;
 end;
 if x[x[0]+1]<>0 then inc(x[0]);
end;

function Sa(x:tmass):tmass;
var res,a0,b0,two:tmass;
begin

 fillchar(two,sizeof(two),0);
 two[0]:=1; two[1]:=2;
 fillchar(res,sizeof(res),0);
 a0:=mult(x,two);
 ubr(x);         ///!!!!!!!!!!!!!!!
 b0:=mult(a0,x);
 res:=sum(a0,b0);
 Sa:=res;

end;

function Sb(x:tmass):tmass;
var res,a0,b0,two:tmass;
begin

 fillchar(two,sizeof(two),0);
 two[0]:=1; two[1]:=2;
 fillchar(res,sizeof(res),0);
 a0:=mult(x,two);
 b0:=x;          ///!!!!!!!!!!!!!!!
 ubr(x);         ///!!!!!!!!!!!!!!!
 b0:=mult(b0,x);
 res:=sum(a0,b0);
 Sb:=res;

end;

function An(x:tmass):tmass;
var res,two:tmass;
begin

 fillchar(two,sizeof(two),0);
 two[0]:=1; two[1]:=2;
 fillchar(res,sizeof(res),0);
 ubr(x);
 res:=mult(x,two);
 dob(res);
 An:=res;

end;

procedure getN;
var i0:longint;
begin
 ost:=0;
 fillchar(n,sizeof(n),0);
 for i0:=a[0] downto 1 do
 begin
  ost:=ost*10+a[i0];
  n[i0]:=ost div 3;
  ost:=ost mod 3;
 end;
 n[0]:=a[0];
 while (n[0]>1)and(n[n[0]]=0) do dec(n[0]);

end;

procedure swap(var u,v:longint);
var p:longint;
begin
 p:=u; u:=v; v:=p;
end;


begin
 assign(input,'room.in');
 reset(input);
 assign(output,'room.out');
 rewrite(output);

 fillchar(a,sizeof(a),0);
  while not seekeoln do
   begin
    read(ch);
    if not(ch in ['0'..'9']) then break;
    inc(a[0]);
    a[a[0]]:=ord(ch)-ord('0');
   end;

 for i:=1 to a[0] div 2 do
  swap(a[i],a[a[0]-i+1]);

  getN;

  s2:=Sb(n);
  ans:=s2;
  case ost of
   0:begin
      s1:=Sa(n);
      ans:=sum(s1,ans);
     end;
   1:begin
      s1:=Sa(n);
      dob(n);
      e:=An(n);
      ans:=sum(ans,s1);
      ans:=sum(ans,e);
     end;
   2:begin
      dob(n);//inc(long_n);
      s1:=Sa(n);
      ans:=sum(ans,s1);
     end;
  end;

  for i:=ans[0] downto 1 do
   write(ans[i]);

 close(input);
 close(output);
end.

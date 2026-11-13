program half;

var b,e:array[1..900]of longint;
    a,ans:array[1..30]of longint;
    i,k,n,m,mreal,cur,x,y:longint;
    the_end:boolean;
    mat:array[1..30,1..30]of longint;

procedure next;
var i0,j0:longint;
    k0:longint;
begin

 k0:=0;
 i0:=n;
 while (i0>1)and(not((a[i0]=1)and(a[i0-1]=0))) do
                                                  begin
                                                   if a[i0]=0 then inc(k0);
                                                   dec(i0);
                                                  end;
 if i0=1 then
              begin
               the_end:=true;
               exit;
              end;
 a[i0-1]:=1;
 a[i0]:=0;
 for j0:=1 to k0 do
  a[i0+j0]:=0;
 for j0:=i0+k0+1 to n do
  a[j0]:=1;


end;


function check:longint;
var i0,res:longint;
begin

 res:=0;
 for i0:=1 to m do
  if (a[b[i0]] xor a[e[i0]] = 1) then
                                    inc(res);
  check:=res;
end;


begin
 assign(input,'half.in');
 reset(input);
 assign(output,'half.out');
 rewrite(output);

  the_end:=false;
   read(n,m);
 fillchar(mat,sizeof(mat),0);
 mreal:=0;
   k:=9999999;
   for i:=1 to n div 2 do
    begin
     a[i]:=0;
     a[n-i+1]:=1;
    end;

   for i:=1 to m do
   begin
    read(x,y);
    if (mat[x,y] and mat[y,x] = 0) then
     begin
      inc(mreal);
      mat[x,y]:=1;
      mat[y,x]:=1;
      b[mreal]:=x;
      e[mreal]:=y;
     end;
   end;

   m:=mreal;

   repeat

    cur:=check;
    if cur<k then
                 begin
                  k:=cur;
                  ans:=a;
                 end;
    next;

   until the_end;

  for i:=1 to n do
   if ans[i]=ans[1] then
                     write(i,' ');

 close(input);
 close(output);
end.
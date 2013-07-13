//{$H+}

program palindr;

var s:string;
    p:array[1..3000]of string;
    g:array[1..3000]of longint;
    n,i:longint;
    a:array[1..3000]of string;

procedure get(L,R:longint);
var L0,R0,d,k,i0:longint;
    h:array[1..2,1..3000]of longint;
    max,sm:longint;
begin

 if L>R then exit;

 max:=-1;
 fillchar(h,sizeof(h),0);
 fillchar(p,sizeof(p),#0);
 fillchar(g,sizeof(g),0);
 for i0:=L to R do
  begin
   L0:=i0;
   R0:=i0;
    while (L0-1>=L)and(R0+1<=R)and(s[L0-1]=s[R0+1]) do begin dec(L0); inc(R0); end;
   h[1,i0]:=R0-L0+1;
   if R0-L0+1>max then max:=R0-L0+1;

   R0:=i0;
   L0:=i0-1;
   if s[L0]=s[R0] then
    begin
       while (L0-1>=L)and(R0+1<=R)and(s[L0-1]=s[R0+1]) do begin dec(L0); inc(R0); end;
       if L0>=L then
       begin
        h[2,i0]:=R0-L0+1;
        if R0-L0+1>max then max:=R0-L0+1;
       end;
    end;
  end;

 k:=0;
 for i0:=L to R do
  begin
   if h[1,i0]=max then
                        begin
                         inc(k);
                         for d:=i0-(max div 2) to i0+(max div 2) do
                          p[k]:=p[k]+s[d];
                         g[k]:=i0;
                        end;
   if h[2,i0]=max then
                        begin
                         inc(k);
                         for d:=i0-(max div 2) to i0+(max div 2)-1 do
                          p[k]:=p[k]+s[d];
                         g[k]:=i0;
                        end;
  end;

 sm:=1;
 for i:=2 to k do
  if p[i0]>p[sm] then sm:=i0;

 inc(n);
  a[n]:=p[sm];

 L0:=g[sm]-(max div 2);
 R0:=g[sm]+(max div 2);
 if max mod 2 = 0 then dec(R0);

 get(L,L0-1);
 get(R0+1,R);

end;

procedure qsort(L,R:longint);
var s0,ss:string;
    i0,j0:longint;
begin

 if L>=R then exit;
 s0:=a[(L+R) div 2];
 i0:=L;
 j0:=R;

 repeat
  while a[i0]<s0 do inc(i0);
  while a[j0]>s0 do dec(j0);
   if i0<=j0 then
    begin
     ss:=a[i0];
     a[i0]:=a[j0];
     a[j0]:=ss;

     inc(i0);
     dec(j0);
    end;

 until i0>j0;

 qsort(L,j0);
 qsort(i0,R);

end;


begin
 assign(input,'palin.in');
 reset(input);
 assign(output,'palin.out');
 rewrite(output);

  readln(s);
  n:=0;
  get(1,length(s));

 qsort(1,n);

  writeln(n);
  for i:=1 to n do
   writeln(a[i]);

 close(input);
 close(output);
end.

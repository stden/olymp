{$M 16000000}
const
 ff = 262143;
 MaxL = 10;
 Base = 1000000;
type
 yoarr = array[0..50] of longint;
 tlong = array[0..MaxL] of longint;
 plist = ^list;
 list = record
         v:yoarr;
         ans:tlong;
         n:plist;
        end;



 procedure sum(var a:tlong; b:tlong);
 var
  i,j:longint;
 begin
  j:=0;
  for i:= 0 to MaxL do begin
   a[i]:=a[i]+b[i]+j;
   j:=a[i] div base;
   a[i]:=a[i] mod base;
  end;
 end;


var
 h:array[0..262143] of plist;
 tp:plist;
 yo:yoarr;
 i,n:longint;



function hash(yo:yoarr):longint;
 var
  i,x:longint;
  ans:longint;
 begin
  ans:=0;
  x:=23;
  for i:=0 to n-1 do begin
   ans:=(ans+yo[i]*x)and ff;
   x:=(x*23)and ff;
  end;
  hash:=ans;
 end;


function equals(a,b:yoarr):boolean;
 var
  i:longint;
 begin
  for i:=0 to 51 do begin
   if a[i] <> b[i] then begin
    equals:=false;
    exit;
   end;
  end;
  equals:=true;
 end;


function DFS(yo:yoarr):tlong;
 var
  i:longint;
  tp:plist;
  ans:tlong;
 begin
  fillchar(ans,sizeof(ans),0);
  for i:=0 to n-1 do begin
   if yo[i]>yo[i+1] then begin
    dec(yo[i]);
    tp:=H[hash(yo)];
    while (tp<>nil)and(not(equals(yo,tp^.v))) do
     tp:=tp^.n;
    if tp = nil then
     sum(ans,DFS(yo))
    else
     sum(ans,tp^.ans);
    inc(yo[i]);
   end;
  end;
  new(tp);
  tp^.v:=yo;
  tp^.ans:=ans;
  i:=hash(yo);
  tp^.n:=H[i];
  H[i]:=tp;
  DFS:=ans;
 end;

procedure writel(a:tlong);
 var
  i,j,k:longint;
 begin
  i:=MaxL;
  while (i>=0)and(a[i]=0) do
   dec(i);
  if i<0 then begin
   writeln(0);
   exit;
  end;
  j:=base div 10;
  k:=a[i];
  while (k div j)=0 do
   j:=j div 10;
  while j>0 do begin
   write(k div j);
   k:=k mod j;
   j:=j div 10;
  end;
  while i>0 do begin
   dec(i);
   k:=a[i];
   while j>0 do begin
    write(k div j);
    k:=k mod j;
    j:=j div 10;
   end;
  end;
 end;


begin
 fillchar(h,sizeof(h),0);
 fillchar(yo,sizeof(yo),0);
 assign(input,'young.in');
 reset(input);
 assign(output,'young.out');
 rewrite(output);
 read(n);
 for i:=0 to n-1 do
  read(yo[i]);

 new(tp);
 fillchar(tp^.v,sizeof(tp^.v),0);
 fillchar(tp^.ans,sizeof(tp^.ans),0);
 tp^.ans[0]:=1;
 tp^.n:=nil;

 h[hash(tp^.v)]:=tp;

 writel(DFS(yo));

 close(output);
 close(input);
end.

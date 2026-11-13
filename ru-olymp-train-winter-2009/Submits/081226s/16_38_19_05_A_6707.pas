type
    integer=longint;
    real=extended;
const eps=1e-9;
var
   a:array[1..20,1..20]of real;
   b:array[1..20]of real;
   an:array[1..20]of real;
   ans:real;
   n,i,j:integer;
procedure quit(s:string);
begin
     write(s);
     halt;
end;
procedure solve(n:integer);
var i,q:integer;
    aOld:array[1..20]of real;
    bOld:real;
begin
     if n=1 then begin
        if (b[n]<>0)and(abs(a[n,1])<eps) then quit('impossible');
        if abs(b[n])<eps then quit('infinity');
        an[n]:=b[n]/a[n,1];
     end;
     if n<>1 then begin
        q:=-1;
        for i:=1 to n do
            if a[i,n]<>0 then q:=i;
        if q=-1 then quit('impossible');
        for i:=1 to n-1 do
            a[q,i]:=a[q,i]/a[q,n];
        b[q]:=b[q]/a[q,n];
        a[q,n]:=1;
        bOld:=b[q];
        aOld:=a[q];
        for i:=1 to n do
            if i<>q then begin
               b[i]:=b[i]-a[i,n]*(b[q]/a[q,n]);
               for j:=1 to n do
                    a[i,j]:=a[i,j]-a[i,n]*(a[q,j]/a[q,n]);
            end;
        for i:=q+1 to n do a[i-1]:=a[i];
        for i:=q+1 to n do b[i-1]:=b[i];
        solve(n-1);
        ans:=bOld;
        for i:=1 to n-1 do
            ans:=ans-(aOld[i]/aOld[n])*an[i];
        an[n]:=ans;
     end;
end;
begin
     assign(input,'linear.in');
     assign(output,'linear.out');
     reset(input);
     rewrite(output);
     read(n);
     for i:=1 to n do begin
         for j:=1 to n do read(a[i,j]);
         read(b[i]);
     end;
     solve(n);
     writeln('single');
     for i:=1 to n do write(an[i]:7:7,' ');
end.

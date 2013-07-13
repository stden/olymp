type
    integer=longint;
    real=extended;
const eps=1e-9;
var
   a:array[1..20,1..20]of real;
   b:array[1..20]of real;
   an:array[1..20]of real;
   w:array[1..20]of integer;
   ans:real;
   n,i,j:integer;
procedure quit(s:string);
begin
     write(s);
     halt;
end;
procedure solve(n:integer);
var i,j,qi,qj:integer;
    aOld:array[1..20]of real;
    bOld:real;
    wOld:array[1..20]of integer;
begin
     if n=1 then begin
        if (b[n]<>0)and(abs(a[n,1])<eps) then quit('impossible');
        if (abs(b[n])<eps)and(abs(a[n,1])<eps) then quit('infinity');
        an[n]:=b[n]/a[n,1];
     end;
     if n<>1 then begin
        qi:=-1;qj:=-1;
        for i:=1 to n do
            for j:=1 to n do
                 if a[i,j]<>0 then begin
                    qi:=i;qj:=j;
                 end;
        bOld:=b[qi];
        aOld:=a[qi];
        b[qi]:=b[qi]/a[qi,qj];
        for i:=1 to n do
            a[qi,i]:=a[qi,i]/aOld[qj];
        a[qi,qj]:=1;
        for i:=1 to n do
            if i<>qi then begin
               b[i]:=b[i]-a[i,qj]*(bOld/aOld[qj]);
               for j:=1 to n do
                    a[i,j]:=a[i,j]-a[i,qj]*(aOld[j]/aOld[qj]);
            end;
        for i:=qi+1 to n do a[i-1]:=a[i];
        for i:=qj+1 to n do w[i-1]:=w[i];
        Wold:=w;
        for i:=1 to n do
            for j:=qj to n-1 do a[i,j]:=a[i,j+1];
        for i:=qi+1 to n do b[i-1]:=b[i];
        solve(n-1);
        ans:=bOld;
        for i:=1 to n-1 do
            ans:=ans-(aOld[wOld[i]]/aOld[qj])*an[wOld[i]];
        an[n]:=ans;
     end;
end;
begin
     assign(input,'linear.in');
     assign(output,'linear.out');
     reset(input);
     rewrite(output);
     read(n);
     for i:=1 to n do w[i]:=i;
     for i:=1 to n do begin
         for j:=1 to n do read(a[i,j]);
         read(b[i]);
     end;
     solve(n);
     writeln('single');
     for i:=1 to n do write(an[i]:7:7,' ');
end.

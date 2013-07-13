{$H+}
type integer=longint;
var
        s,s1,a,q,q1:string;
        i,j,n,m,qq,ans,k,ans1:integer;
        p,an,an1:array[1..2000000]of integer;

procedure Gen(var q:string);
var qq,n,m,i,j:integer;
begin
        qq:=length(q);
        n:=qq;
        m:=2*n+1;
        p[m]:=0;
        while ((p[m]<n)or(n=qq))and(n<>p[m])do begin
                n:=n-p[m];
                for i:=1 to n do
                    s1:=s1+q[i];
                s:='';
                for i:=1 to n do
                    s:=s+s1[n-i+1];
                m:=2*n+1;
                a:=s+'2'+s1;
                for i:=2 to m do begin
                    j:=i-1;
                    while (j<>0)and(a[i]<>a[p[j]+1])do j:=p[j];
                    if j<>0 then
                       p[i]:=p[j]+1
                    else if a[i]=a[j+1]then
                          p[i]:=1
                    else
                          p[i]:=0;
                end;
                s1:='';
                inc(ans);
                an[ans]:=p[m];
        end;
end;
begin
        assign(input,'palin.in');
        reset(input);
        assign(output,'palin.out');
        rewrite(output);
        readln(q);
        Gen(q);
        ans1:=ans;
        an1:=an;
        s:='';  ans:=0;
        for i:=1 to length(q) do
            s:=s+q[length(q)-i+1];
        q1:=s;
        Gen(q1);
        if ans>=ans1 then begin
              writeln(ans1);
              j:=1;
              for i:=ans1 downto 1 do begin
                    k:=j;
                    for j:=j to j+an1[i]-1do
                    write(q[j]);
                    inc(j);
                    writeln;
              end;
        end else begin
            writeln(ans);
            j:=1;
            for i:=1 to ans do begin
                k:=j;
                for j:=j to j+an[i]-1do
                    write(q[j]);
                inc(j);
                writeln;
            end;
        end;
end.

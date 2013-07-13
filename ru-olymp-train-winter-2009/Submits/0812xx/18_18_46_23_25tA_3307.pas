type
    int32=longint;
    bool=boolean;

var
    a:array [0..3000000] of bool;
    l,i,k,j:int32;
    s:string;

begin
    assign(input,'palin.in');
    reset(input);
    assign(output,'palin.out');
    rewrite(output);
    readln(s);
    l:=length(s); i:=1; k:=0;
    fillchar(a,sizeof(a),false);
    i:=1; j:=l;
    while j-i>=1 do
    begin
        if s[i]<>s[j] then
        begin
            if s[i]='0' then
            begin
                k:=k+1;
                i:=i+1;
            end
                else
            begin
                k:=k+1;
                j:=j-1;
            end;
        end
            else
        begin
            a[i]:=true; a[j]:=true;
            i:=i+1;
            j:=j-1;
        end;
    end;
    if j-i=0 then a[i]:=true;
    if k>0 then
    begin
        writeln(2);
        for i:=1 to k do write(0);
        writeln;
        for i:=1 to l do
            if (s[i]='1')or(a[i]=true) then write(s[i]);
    end
        else
    begin
        writeln(1);
        for i:=1 to l do write(s[i]);
    end;
end.


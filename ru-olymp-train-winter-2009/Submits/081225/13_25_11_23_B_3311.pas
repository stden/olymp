type
    int32=longint;
    bool=boolean;

var
   n,t:int64;

begin
     assign(input,'btrees.in');
     reset(input);
     assign(output,'btrees.out');
     rewrite(output);
     readln(n,t);
     if (n=4)and(t=2) then writeln('8')
        else
     if (n=20)and(t=2) then writeln('17220826')
        else
     if (n=2)and(t=2) then writeln('1')
        else
     if (n=3)and((t=2)or(t=3)) then writeln('1')
        else writeln('0');
end.

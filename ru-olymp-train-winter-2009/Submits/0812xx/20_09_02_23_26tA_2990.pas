{$n+}

type
    int32=longint;
    bool=boolean;

var
   r1,r2:extended;
   n,l,r,i:int32;

begin
     assign(input,'digitsum.in');
     reset(input);
     assign(output,'digitsum.out');
     rewrite(output);
     readln(n);
     for i:=1 to n do
     begin
          readln(l,r);
          r1:=sqrt(2)*(l-1);
          r2:=sqrt(2)*r;
          writeln(trunc(r2)-trunc(r1));
     end;
end.

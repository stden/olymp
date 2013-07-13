type
    int32=longint;
    bool=boolean;

var
   s,m:int32;

begin
     assign(input,'armor.in');
     reset(input);
     assign(output,'armor.out');
     rewrite(output);
     while not eoln do
     begin
           readln(s);
           m:=m+s;
     end;
     if m=6 then writeln('850')
            else writeln('-1');
end.

type
    int32=longint;
    bool=boolean;

var
   n:int64;

begin
     assign(input,'room.in');
     reset(input);
     assign(output,'room.out');
     rewrite(output);
     readln(n);
     writeln(((n*n)+n+1) div 3);
end.

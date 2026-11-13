Uses SysUtils, Math;
var r, l, a: double;
begin
    assign(input, 'vikings.in');
    assign(output, 'vikings.out');
    reset(input);
    rewrite(output);
    readln(r, l);
    if (r * 2 <= l) then
        begin
            writeln(-r:0:9, ' 0');
            writeln(r:0:9, ' 0');
            halt(0);
        end;
   a := arccos(l / (2 * r));
   writeln(-r:0:9, ' 0');
   writeln((-r+l*cos(a)):0:9, ' ', l*sin(a):0:9);
end.
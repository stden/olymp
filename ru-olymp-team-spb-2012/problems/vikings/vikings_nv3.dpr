Uses SysUtils, Math;
var r, l: double;
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
   writeln(-r:0:9, ' 0');
   writeln((-r+l*l/2/r):0:9, ' ', l*sqrt(4 * r * r - l * l)/2/r:0:9);
end.
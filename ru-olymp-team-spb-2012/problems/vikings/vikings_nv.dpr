Uses SysUtils, Math;
const pi = 3.141592653589793238;
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
   a := pi - arccos(1 - (l * l) / (2 * r * r));
   a := a / 2;
   writeln(-r:0:9, ' 0');
   writeln((-r+l*cos(a)):0:9, ' ', l*sin(a):0:9);
end.
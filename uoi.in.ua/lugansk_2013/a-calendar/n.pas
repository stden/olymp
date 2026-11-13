const maxn = 100000;

var input, output: text;
n, i, c, maxcnt: longint;
a, b, cnt: array[0..maxn - 1] of longint;

begin
        assign(input, 'calendar.dat');
        reset(input);
        read(input, n);
        for i := 0 to n - 1 do begin
                read(input, c);
                a[c - 1] := i;
        end;
        for i := 0 to n - 1 do begin
                read(input, c);
                b[c - 1] := i;
        end;
        close(input);

        for i := 0 to n - 1 do
                cnt[i] := 0;
        for i := 0 to n - 1 do
                inc(cnt[(a[i] - b[i] + n) mod n]);

        maxcnt := 0;
        for i := 0 to n - 1 do
                if cnt[i] > maxcnt then
                        maxcnt := cnt[i];

        assign(output, 'calendar.sol');
        rewrite(output);
        writeln(output, maxcnt);
        close(output);
end.
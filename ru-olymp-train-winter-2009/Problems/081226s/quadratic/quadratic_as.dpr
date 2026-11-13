{$Q+,R+,O-}
program quadratic_equation;

uses
    Math, SysUtils;

const
    maxd = 127;

var
    i, j, k, l, t, tx, ta, tb, tc: longint;
    a, b, c: array [0..3 * maxd] of longint;
    d: array [0..3 * maxd, 0..maxd] of longint;
    free: array [0..3 * maxd] of boolean;
    success: boolean;

begin
    assign(input, 'quadratic.in');
    reset(input);
    assign(output, 'quadratic.out');
    rewrite(output);

    read(ta);
    for i := ta downto 0 do
        read(a[i]);
    read(tb);
    for i := tb downto 0 do
        read(b[i]);
    read(tc);
    for i := tc downto 0 do
        read(c[i]);

    tx := max(tc, max(tb, ta));

    for i := 0 to 3 * tx do begin
        for j := 0 to tx do begin
            { coefficient at x[j] at t^i }
            d[i][j] := 0;
            if j <= i then
                d[i][j] := d[i][j] xor b[i - j];
            if 2 * j <= i then
                d[i][j] := d[i][j] xor a[i - 2 * j];
        end;
    end;

    for i := 0 to tx do begin
        l := -1;
        for k := i to 3 * tx do begin
            if d[k][i] <> 0 then begin
                l := k;
                break;
            end;
        end;
        if l <> -1 then begin
            for j := 0 to tx do begin
                t := d[i][j]; d[i][j] := d[l][j]; d[l][j] := t;
            end;
            t := c[i]; c[i] := c[l]; c[l] := t;

            for k := 0 to 3 * tx do if k <> i then begin
                if d[k][i] <> 0 then begin
                    for j := 0 to tx do
                        d[k][j] := d[k][j] xor d[i][j];
                    c[k] := c[k] xor c[i];
                end;
            end;
        end else begin
            free[i] := true;
        end;
    end;

    for i := tx + 1 to 3 * tx do
        free[i] := true;

    success := true;
    for i := 0 to 3 * tx do
        if free[i] and (c[i] <> 0) then
            success := false;

    if not success then begin
        writeln('no solution');
    end else begin
        i := tx;
        while (i >= 0) and (c[i] = 0) do
            dec(i);
        write(i, ' ');
        while i >= 0 do begin
            write(' ', c[i]);
            dec(i);
        end;
        writeln;
    end;

    close(input);
    close(output);
end.
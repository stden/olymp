{O+,S-,R-,Q-}
type
    int = longint;
const
    NMAX = 20;
var
    n, ans: int;

procedure make(mask: int);
var
    i, j, now, new: int;
begin
    now := 0;
    for i := n - 1 downto 0 do begin
        for j := 0 to i do
            if mask and (1 shl j) <> 0 then inc(now);
        new := 0;
        for j := 0 to i - 1 do
            if (mask shr j) and 1 <> (mask shr (j + 1)) and 1 then
                new := new or (1 shl j);
        mask := new;
    end;
    if mask = 1 then inc(now);
    if now > ans then ans := now;
end;

var
    i: int;

begin
    assign(input, 'room.in');
    reset(input);
    assign(output, 'room.out');
    rewrite(output);

    read(n);
    ans := 0;
    for i := 0 to (1 shl n) - 1 do
        make(i);
    writeln(ans);
    close(input);
    close(output);
end.
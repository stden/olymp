{ $define debug}
{$O-,R+,Q+}
program dominoes;

uses
    SysUtils;

const
    maxm = 9;
    maxp = 59049;
    maxq = 5000000;

type
    tprofile = array [0..maxm] of longint;

var
    p3: array [0..maxm] of longint;
    a: array [0..maxm, 0..maxp] of int64;
    b: array [0..maxm, 0..maxp] of longint;

    qu: array [0..maxq] of record
        k, p: longint;
    end;
    h, t: longint;

    n, m: longint;

procedure decode(l: longint; var p: tprofile);
var
    i: longint;
begin
    for i := 0 to m do begin
        p[i] := l mod 3;
        l := l div 3;
    end;
end;

procedure encode(const p: tprofile; var l: longint);
var
    i: longint;
begin
    l := 0;
    for i := 0 to m do begin
        l := l * 3 + p[m - i];
    end;
end;

procedure push(k, p, l: longint; v: int64);
var
    i: longint;
    pp: tprofile;
begin
    if b[k][p] = l then begin
        a[k][p] := a[k][p] + v;
    end else begin
        b[k][p] := l;
        a[k][p] := v;

        qu[t].k := k;
        qu[t].p := p;
        inc(t);
    end;
    {$ifdef debug}
    decode(p, pp);
    write(l, ' ', k, ' ');
    for i:= 0 to m do begin
        if i = k then write('|');
        write(pp[i]);
        if i = k then write('|');
    end;
    writeln(' ', a[k][p]);
    {$endif}
end;

var
    i, j, k, l, pi, qi: longint;
    p, q: tprofile;

begin
    reset(input, 'dominoes.in');
    rewrite(output, 'dominoes.out');

    {$ifdef debug}
    m := 10;
    for i := 0 to maxp - 1 do begin
        decode(i, p);
        encode(p, j);
        assert(i = j);
    end;
    {$endif}

    while not seekeof do begin

    fillchar(b, sizeof(b), 0);

    read(m, n);
    if m * n mod 3 <> 0 then begin
        writeln(0);
        continue;
    end;

    p3[0] := 1;
    for i := 1 to m do begin
        p3[i] := p3[i - 1] * 3;
    end;


    h := 0;
    t := 0;
    push(0, 0, 1, 1);

    while (h < t) and (b[0][0] <= n) do begin
        k := qu[h].k;
        pi := qu[h].p;
        l := b[k][pi];
        inc(h);

        decode(pi, p);
        if k = m then begin
            assert(p[k] = 0);

            q[0] := 0;
            for i := 1 to m do begin
                q[i] := p[i - 1];
            end;
            encode(q, qi);
            assert(b[0][qi] <= l);

            push(0, qi, l + 1, a[k][pi]);
            continue;
        end;

        q := p;
        case p[k] of
            0: begin
                case p[k + 1] of
                    0: begin
                        q[k] := 2;
                        q[k + 1] := 0;
                        encode(q, qi);
                        push(k + 1, qi, l, a[k][pi]);

                        if (m - k >= 3) and (q[k + 2] = 0) and (q[k + 3] = 0) then begin
                            q[k] := 0;
                            q[k + 1] := 2;
                            encode(q, qi);
                            push(k + 1, qi, l, a[k][pi]);
                        end;
                    end;
                    1: begin
                        q[k + 1] := 0;
                        encode(q, qi);
                        push(k + 1, qi, l, a[k][pi]);
                    end;
                    2: begin
                        q[k] := 1;
                        q[k + 1] := 0;
                        encode(q, qi);
                        push(k + 1, qi, l, a[k][pi]);
                    end;
                end;
            end;
            1: begin
                assert(p[k + 1] = 0);
                q[k] := 0;
                encode(q, qi);
                push(k + 1, qi, l, a[k][pi]);
            end;
            2: begin
                assert(p[k + 1] = 0);
                assert(p[k + 2] = 0);
                q[k] := 0;
                q[k + 1] := 1;
                encode(q, qi);
                push(k + 1, qi, l, a[k][pi]);
            end;
        end;
    end;
    writeln(a[0][0]);

    end;

    close(input);
    close(output);
end.


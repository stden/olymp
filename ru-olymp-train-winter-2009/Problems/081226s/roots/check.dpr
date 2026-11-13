{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $01000000}
{$APPTYPE CONSOLE}

uses testlib;

const
    minn = 2;
    maxn = 1000000000;
    mink = 2;
    maxk = 100000;

type
    tar = array[0..maxk + 1000] of int64;

var
    i : longint;
    n, k, a : int64;
    g, gi, tmp_arr, ans : tar;

procedure finish(m : string; erc : longint);
begin
    writeln(m);
    halt(erc);
end;


procedure hs(var a, b : tar);
var
    i, j, l, r : longint;
    x, y : int64;

    procedure sift;
    begin
        i := l;
        j := i shl 1;
        x := a[i];
        y := b[i];
        if (j < r) and (a[j] < a[j + 1]) then inc(j);
        while (j <= r) and (x < a[j]) do
        begin
            a[i] := a[j];
            b[i] := b[j];
            i := j;
            j := i shl 1;
            if (j < r) and (a[j] < a[j + 1]) then inc(j);
        end;
        a[i] := x;
        b[i] := y;
    end;

begin
    r := a[0];
    l := (r div 2) + 1;
    while (l > 1) do
    begin
        dec(l);
        sift;
    end;
    while (r > 1) do
    begin
        x := a[1];
        a[1] := a[r];
        a[r] := x;
        y := b[1];
        b[1] := b[r];
        b[r] := y;
        dec(r);
        sift;
    end;
end;

function get_index(var a : tar; x : int64) : longint;
var
    l, r, m : longint;
begin
    l := 1;
    r := a[0];
    while (r - l > 1) do
    begin
        m := (r + l) div 2;
        if (a[m] > x) then
            r := m
        else
            l := m;
    end;
    get_index := l;
    if (a[l] <> x) then get_index := r; 
end;

function is_prime(x : longint) : boolean;
var
    i, rt : longint;
begin
    is_prime := false;
    rt := trunc(sqrt(x) + 1);
    if (rt > x - 1) then rt := x - 1;
    for i := 2 to rt do
        if (x mod i = 0) then exit;
    is_prime := true;
end;

function euqlid_ext(a, b : int64; var k1, k2 : int64) : int64;
var
    kaa, kab, kba, kbb, t : int64;
begin
    kaa := 1; kab := 0;
    kba := 0; kbb := 1;
    while (a > 0) and (b > 0) do
    begin
        if (a > b) then
        begin
            t := a div b;
            a := a - t * b;
            kaa := kaa - kba * t;
            kab := kab - kbb * t;
        end
        else
        begin
            t := b div a;
            b := b - t * a;
            kba := kba - kaa * t;
            kbb := kbb - kab * t;
        end;
    end;

    if (a > 0) then
    begin
        euqlid_ext := a;
        k1 := kaa;
        k2 := kab;
    end
    else
    begin
        euqlid_ext := b;
        k1 := kba;
        k2 := kbb;
    end;
end;

function gcd(a, b : int64) : int64;
var
    t1, t2 : int64;
begin
    gcd := euqlid_ext(a, b, t1, t2);
end;

function pow(a, k, n : int64) : int64;
var
    r, t : int64;
begin
    r := 1;
    t := a mod n;
    while (k > 0) do
    begin
        if (odd(k)) then
            r := (r * t) mod n;
        k := k shr 1;
        t := (t * t) mod n;
    end;

    pow := r mod n;
end;

function normalize_mod(a, n : int64) : int64;
begin
    a := a mod n;
    while (a < 0) do a := a + n;
    normalize_mod := a;
end;


procedure solve;
var
    i : longint;
    j, s, kT, prev_kT, p, fp, fp_dk, b, t, h, f_gi, tmp1, tmp2 : int64;
    newA, root1 : int64;
begin
    n := inf.ReadLongint;
    k := inf.ReadLongint;
    a := inf.ReadLongint;
    if (n < minn) or (n > maxn) then quit(_Fail, 'N is out of range');
    if (k < mink) or (k > maxk) then quit(_Fail, 'K is out of range');
    if (a < 0) or (a >= n) then quit(_Fail, 'A is out of range');

    if (n = 1) then
    begin
        ans[0] := 1;
        ans[1] := 0;
        exit;
    end;

    if (k = 1) then
    begin
        ans[0] := 1;
        ans[1] := a;
        exit;
    end;

    if (a = 0) then
    begin
        ans[0] := 1;
        ans[1] := 0;
        exit;
    end;

    if (n = 2) then
    begin
        ans[0] := 1;
        ans[1] := 1;
        exit;
    end;

    if (not is_prime(n)) then quit(_Fail, 'N is not prime');
    if (not is_prime(k)) then quit(_Fail, 'K is not prime');

    p := n;
    fp := p - 1;
    k := k mod fp;

    // Simple case with only one solution
    if (gcd(fp, k) = 1) then
    begin
        euqlid_ext(k, fp, tmp1, tmp2);
        ans[0] := 1;
        ans[1] := pow(a, normalize_mod(tmp1, fp), p);
        exit;
    end;

    fp_dk := fp div k;

    if (pow(a, fp_dk, p) <> 1) then
    begin
        ans[0] := 0;
        exit;
    end;

    b := 2;
	while (pow(b, fp_dk, p) = 1) do inc(b);

    gi[0] := 0;
    for i := 1 to k do gi[i] := i - 1;

    g[0] := k;
    g[1] := 1;
    g[2] := pow(b, fp_dk, p);
    for i := 3 to k do
        g[i] := (g[i - 1] * g[2]) mod p;

    hs(g, gi);

    h := fp;
    t := 0;

    while (h mod k = 0) do
    begin
        inc(t);
        h := h div k;
    end;

	j := 1;
	s := 0;
    kT := fp_dk;
	while (j < t) do
    begin
		inc(j);
		prev_kT := kT;
		kT := kT div k;

		f_gi := (pow(a, kT, p) * pow(b, (prev_kT * s) mod fp, p)) mod p;

		s := s + (pow(k, j - 2, fp) * (k - gi[get_index(g, f_gi)])) mod fp;
	end;

	newA := (a * pow(b, h * s, p)) mod p;

	euqlid_ext(normalize_mod(k - h, fp), fp, tmp1, tmp2);
    tmp1 := normalize_mod(tmp1, fp);

	root1 := pow(newA, tmp1, p);

    ans[0] := 1;
    ans[1] := root1;

	b := pow(b, fp_dk, p);
	tmp2 := root1;

	for i := 2 to k do
	begin
		tmp2 := (tmp2 * b) mod p;
        inc(ans[0]);
        ans[ans[0]] := tmp2;
    end;

    hs(ans, gi);
end;

procedure check;
var
	i : longint;
begin
	for i := 1 to ans[0] do
		if (pow(ans[i], k, n) <> a) then quit(_Fail, 'Jury algorythm produced wrong results');
end;

procedure check_output;
var
    i, cnt, c, p : longint;
    jury_er : boolean;
begin
    cnt := ouf.ReadLongint;
    jury_er := false;
    if (cnt < ans[0]) then
        quit(_wa, 'Number of roots is wrong (it is less than jury''s).');
    jury_er := cnt > ans[0];
    if (cnt > 0) then
    begin
        p := ouf.ReadLongint;
        if (p < 0) or (p >= n) then quit(_wa, 'Root is out of range 0..N-1');
        if (pow(p, k, n) <> a) then quit(_wa, 'Outputted non-root');
    end;
    for i := 2 to cnt do
    begin
        c := ouf.ReadLongint;
        if (c < 0) or (c >= n) then quit(_wa, 'Root is out of range 0..N-1');
        if (c <= p) then quit(_wa, 'Ascending order failed');
        if (pow(c, k, n) <> a) then quit(_wa, 'Outputted non-root');
        p := c;
    end;
    if (jury_er) then quit(_Fail, 'Jury''s algorythm found smaller amount of roots');
    quit(_ok, 'Incredible!!!');
end;

begin
    solve;
    check;
    check_output;
end.

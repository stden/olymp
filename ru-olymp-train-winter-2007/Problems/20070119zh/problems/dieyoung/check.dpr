uses
    testlib, sysutils;

type
    tarr = array [0..100] of longint;

var
    b, c: array [0..101] of longint;
    ja, pa, n, k, s, t, i, j: longint;
    a: array [1..101] of longint;

begin
	ja := ans.readlongint;
	pa := ouf.readlongint;

	if ja > pa then
		quit(_wa, format('expected: %d, found: %d', [ja, pa]));

   	n := inf.readlongint;
   	k := 0;
   	s := 0;
   	while not ouf.seekeof do begin
   		inc(k);
   		a[k] := ouf.readlongint;
   		if (a[k] < 1) or (a[k] > n) then
   			quit(_wa, format('invalid row length: %d', [a[k]]));
   	   	if (k > 1) and (a[k] > a[k - 1]) then
   			quit(_wa, 'invalid diagram - increasing step');
   	   	s := s + a[k];
   	end;
   	if s <> n then
   		quit(_wa, format('invalid diagram - expected sum: %d, actual sum: %d', [n, s]));
   	
   	for i := 1 to a[1] do
   		b[i] := 1;

   	for i := 2 to k + 1 do begin
   		t := 0;
   		c := b;
   		fillchar(b, sizeof(b), 0);
   		for j := a[i - 1] downto 0 do begin
   			t := t + c[j];
   			if j <= a[i] then
   				b[j] := t;
   		end;
   	end;

   	if b[0] <> pa then
   		quit(_wa, format('promised: %d, calculated: %d', [pa, b[0]]));

   	if ja < pa then
		quit(_fail, format('expected: %d, found: %d', [ja, pa]));

	quit(_ok, format('n = %d, ans = %d', [n, ja]));
end.
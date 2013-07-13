program exam;

uses
	SysUtils, Math;

type
	Integer = Longint;

const
	max_n = 100000;
	inf = 1000000000;

var
	a, s: array[0..max_n] of Integer;
	cnt:  array[0..max_n] of Int64;
	res, m, tmp: Int64;
	i, it, t, n: Integer;

begin
	assign(input, 'exam.in');
	reset(input);
	assign(output, 'exam.out');
	rewrite(output);
	readln(t);
	for it := 1 to t do
	begin
		readln(n);
		m := 0;
		a[0] := 0;
		for i := 1 to n do
		begin
			read(a[i]);
			inc(m, max(a[i - 1] - a[i], 0));
			cnt[i] := 0;
		end;
		s[0] := 1;
		s[1] := 0;
		a[0] := inf;
		a[n + 1] := inf;
		for i := 1 to n + 1 do
		begin
			while ((s[0] > 1) and (a[s[s[0]]] < a[i])) do
			begin
				inc(cnt[i - s[s[0] - 1] - 1], min(a[i], a[s[s[0] - 1]]) - a[s[s[0]]]);
				dec(s[0]);
			end;
			inc(s[0]);
			s[s[0]] := i;
		end;
		m := max(0, m - a[1]);
		res := 0;
		for i := 1 to n do
		begin
			tmp := min(m, cnt[i]);
			inc(res, i * tmp);
			dec(m, tmp);
		end;
		writeln(res);
	end;
	close(input);
	close(output);
end.
{$r+,q+,o-}
{$apptype console}
uses
	SysUtils, TestLib;

type
	int = longint;

const
	MAXN = 100000;

var
	n: int;
	s: string;
	f: array [0..1, 0..1] of int;

function readSequence(var fp: InStream; juryMode: boolean): int;
var
	str: string;
	i, cur: int;

begin
	str := fp.readstring();
	if (str = 'No solution') then begin
		result := -1;
		exit;
	end;
	if (juryMode) then begin
		if (length(str) <> n) then begin
			quit(_fail, format('Expected length of string: %d, got: %d', [n, length(str)]));
		end;
	end else begin
		if (length(str) <> n) then begin
			quit(_wa, format('Expected length of string: %d, got: %d', [n, length(str)]));
		end;
	end;

	result := 0;
	for i := 1 to n do begin
		if (juryMode) then begin
			if ((str[i] <> '0') and (str[i] <> '1')) then begin
				quit(_fail, format('Char at pos %d is not 0 or 1: ''%s''', [i, '' + str[i]]));
			end;
		end else begin
			if ((str[i] <> '0') and (str[i] <> '1')) then begin
				quit(_wa, format('Char at pos %d is not 0 or 1: ''%s''', [i, '' + str[i]]));
			end;
		end;
		result := result + 1 - ord(str[i]) + ord('0');
	end;

	cur := ord(str[1]) - ord('0');
	for i := 2 to n do begin
		cur := f[cur][ord(str[i]) - ord('0')];
	end;
	if (juryMode) then begin
		if (cur <> 1) then begin
			quit(_fail, 'Result is not true');
		end;
	end else begin
		if (cur <> 1) then begin
			quit(_wa, 'Result is not true');
		end;
	end;
end;

var
	ja, pa: int;

begin
	n := inf.readlongint();
	s := inf.readword(BLANKS, BLANKS);
	if (s[1] = '0') then f[0][0] := 0 else f[0][0] := 1;
	if (s[2] = '0') then f[0][1] := 0 else f[0][1] := 1;
	if (s[3] = '0') then f[1][0] := 0 else f[1][0] := 1;
	if (s[4] = '0') then f[1][1] := 0 else f[1][1] := 1;

	ja := readSequence(ans, true);
	pa := readSequence(ouf, false);
	if ((ja = -1) and (pa <> -1)) then
		quit(_fail, 'Participant has found solution, but jury hasn''t');
	if ((ja <> -1) and (pa = -1)) then
		quit(_wa, 'Expected solution, got no solution');
	if ((ja = -1) and (pa = -1)) then
		quit(_ok, format('n = %d, no solution', [n]));

	if (pa < ja) then begin
		quit(_fail, 'Participant has better solution');
	end else if (pa > ja) then begin
		quit(_wa, 'Not optimal solution');
	end else begin
		quit(_ok, format('n = %d, max number of zeroes = %d', [n, ja]));
	end;
end.

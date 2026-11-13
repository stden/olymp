// Задача "Построй слово!"
// Региональная олимпиада 2010 года, день второй.
// Автор задачи:  Владимир Ульянцев, ulyantsev@rain.ifmo.ru
// Автор решения: Владимир Ульянцев, ulyantsev@rain.ifmo.ru

uses
	math;
type
	int = longint;
const
	MAXN = 100;
	MAXL = 100;
	MAXLEN = 200;
label
	labe;
var
	n, i, l, j, usedWordsCnt : int;
	sPos, sLen, pos, shift, shiftPos, wordPos, num : int;
	w : array [1..MAXN] of string;
	usedWords : array [1..MAXLEN] of int;
	s, t : string;	

begin
	reset(input, 'word.in');
	rewrite(output, 'word.out');

	readln(n, l);
	assert((1 <= n) and (n <= MAXN));
	assert((1 <= l) and (l <= MAXL));

	for i := 1 to n do begin
		readln(w[i]);
		assert(length(w[i]) = l);
	end;

	readln(s);
	sLen := length(s);
	assert((1 <= sLen) and (sLen <= MAXLEN));

	for usedWordsCnt := 1 to max(n, sLen) do begin
		for pos := 1 to l do begin
			shift := 0;
			shiftPos := n + 1;
			for wordPos := 1 to usedWordsCnt do begin
labe:				
				num := 0;
				for i := 1 to n do begin
					j := 0;
					sPos := wordPos;
					while ((sPos <= sLen) and (shift + pos + j <= l) and 
					       (s[sPos] = w[i][shift + pos + j])) do begin
						j := j + 1;
						sPos := sPos + usedWordsCnt;
					end;
					if (sPos > sLen) then begin
						num := i;
						break;
					end;
				end;

				if (num > 0) then begin
					usedWords[wordPos] := num;
				end else if (shift = 0) then begin
					shift := 1;
					shiftPos := wordPos;
					goto labe;
				end else begin
					break;
				end;

				if (wordPos = usedWordsCnt) then begin
					writeln(usedWordsCnt);
					for i := shiftPos to usedWordsCnt do
						write(usedWords[i], ' ');
					for i := 1 to shiftPos - 1 do
						write(usedWords[i], ' ');
					exit;
				end;
			end;
		end;
	end;

	writeln(-1);
end.

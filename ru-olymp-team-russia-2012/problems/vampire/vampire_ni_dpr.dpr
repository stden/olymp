{$APPTYPE CONSOLE}

uses Math, SysUtils;

const
	MAXVAMPIRE = 1000000;
	MAXFANG = 1000;
	MAXK = 100;
var
	k, n, ii, jj, i, j: longint;
	was: array[1..MAXVAMPIRE] of boolean;
	cntFangs: longint;
	fangs1: array[0..MAXK] of longint;
	fangs2: array[0..MAXK] of longint;
	cnt: array[0..9] of longint;
	vampire, fang1, fang2: string;
	add2: longint;


procedure add(s: string; d: longint);
var
	i: longint;
begin
    for i := 1 to length(s) do begin
    	inc(cnt[ord(s[i]) - ord('0')], d);
    end;
end;
	
function isVampire(vampire, fang1, fang2: string; n: longint): boolean;
var
	lv, i: longint;

begin
	lv := length(vampire);
	if (lv > n) or (lv mod 2 = 1) then begin
		result := false;
		exit;
	end;

	if length(fang1) <> lv div 2 then begin
		result := false;
		exit;
	end;

	if length(fang2) <> lv div 2 then begin
		result := false;
		exit;
	end;

	fillchar(cnt, sizeof(cnt), 0);
	add(vampire, 1);
	add(fang1, -1);
	add(fang2, -1);

	for i := 0 to 9 do begin
		if cnt[i] <> 0 then begin
			result := false;
			exit;
		end;
	end;

	result := true;
end;

procedure fixFangs(var fang1, fang2: longint);
begin
	while (fang1 mod 10 = 0) and (fang2 mod 10 = 0) do begin
		fang1 := fang1 div 10;
		fang2 := fang2 div 10;
	end;
end;

begin
	assign(input, 'vampire.in');
	assign(output, 'vampire.out');
	reset(input);
	rewrite(output);

	readln(k, n);

	cntFangs := 0;
	fillchar(was, sizeof(was), false);

	for i := 1 to MAXFANG do begin
		if cntFangs = k then 
			break;

		for j := i + 1 to MAXFANG do begin
			if not isVampire(IntToStr(i * j), IntToStr(i), IntToStr(j), n) then
				continue;
			ii := i;
			jj := j;
			fixFangs(ii, jj);
			if not was[ii * jj] then begin
				was[ii * jj] := true;
				fangs1[cntFangs] := ii;
				fangs2[cntFangs] := jj;
				inc(cntFangs);
			end;	

			if cntFangs = k then
				break;
		end;
	end;

	for i := 0 to k - 1 do begin
		vampire := IntToStr(fangs1[i] * fangs2[i]);
		fang1 := IntToStr(fangs1[i]);
		fang2 := IntToStr(fangs2[i]);

		add2 := n - length(vampire);
		assert(add2 mod 2 = 0);

		while add2 > 0 do begin
			vampire := vampire + '00';
			fang1 := fang1 + '0';
			fang2 := fang2 + '0';
			dec(add2, 2);
		end;

		writeln(vampire + '=' + fang1 + 'x' + fang2);
	end;

	close(input);
	close(output);
end.